use strict;
use warnings;

package Dep;

my $DEP_CACHE  = {};
my $DIST_CACHE = {};

use Dep::Module;
use Carp;

sub new {
    my ( $self, @args ) = @_;
    my $obj = bless {@args}, $self;
    die "_name_ required"     unless $obj->{name};
    die "_provides_ required" unless $obj->{provides};
    $obj->{requires} ||= {};
    $obj->_register_provides;
    $obj->_register_dist;
    return $obj;
}

sub name     { $_[0]->{name} }
sub requires { $_[0]->{requires} }

sub provides {
    ref $_[0]->{provides} eq 'HASH'
      ? %{ $_[0]->{provides} }
      : @{ $_[0]->{provides} };
}

sub _register_provides {
    my (@provides) = $_[0]->provides;
    while (@provides) {
        my ( $module, $version ) = splice @provides, 0, 2, ();
        $DEP_CACHE->{$module} = Dep::Module->new( name => $module ) unless exists $DEP_CACHE->{$module};
        $DEP_CACHE->{$module}->register( $version, $_[0] );
    }
}

sub _register_dist {
    $DIST_CACHE->{ $_[0]->{name} } = $_[0];
}

sub get_dist {
    return $DIST_CACHE->{ $_[1] } if exists $DIST_CACHE->{ $_[1] };
}

sub get_module {
    return $DEP_CACHE->{ $_[1] } if exists $DEP_CACHE->{ $_[1] };
}

sub get_distnames {
    sort keys %{$DIST_CACHE};
}

sub get_modulenames {
    sort keys %{$DEP_CACHE};
}

sub get_module_pairs {
    map { $DEP_CACHE->{$_}->version_pairs } sort keys %{$DEP_CACHE};
}

our @context;

sub resolve_dependency {
    my ( $self, $module, $version ) = @_;
    croak "Module not defined" if not defined $module;
    if ( not exists $DEP_CACHE->{$module} ) {
        die "No mapping for $module";
    }
    my $reso = $DEP_CACHE->{$module}->version_satisfies($version);
    if ( not defined $reso ) {
        die "No version >= $version for $module (" . ( join q[, ], $DEP_CACHE->{$module}->versions ) . ')' . join qq[], @context;
    }
    return $reso;
}

sub dep_as_bash_lines {
    my ( $self, $module, $version, $indent ) = @_;
    $indent = '' if not defined $indent;
    my @out;
    my $root = $self->resolve_dependency( $module, $version );
    push @out, $indent . 'has_version ' . $module . ' ' . $version . ' || (';
    for my $child ( sort { int( rand 2 ) - 1 } keys %{ $root->{requires} || {} } ) {
        local @context = ( "Resolving deps for $module $version", @context );

        push @out, $self->dep_as_bash_lines( $child, $root->{requires}->{$child}, $indent . q[  ] );
    }
    push @out, $indent . q[  ] . 'cpan ' . $root->name;
    push @out, $indent . ')';
    return @out;
}

sub dep_as_bash {
    my ( $self, $module, $version ) = @_;
    return join qq[\n], $self->dep_as_bash_lines( $module, $version, '' ), '';
}

1

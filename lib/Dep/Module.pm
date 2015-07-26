use strict;
use warnings;

package Dep::Module;

use Dep::Version;
use Carp qw( croak );

sub new {
    my ( $self, @args ) = @_;
    my $obj = bless {@args}, $self;
    die "_name_ required" unless $obj->{name};
    $obj->{versions} = {};
    return $obj;
}

sub register {
    my ( $self, $version, $dep ) = @_;
    croak "version must be defined" unless defined $version;
    $self->{versions}->{$version} = $dep;
}

sub versions {
    my ($self) = @_;
    return sort { fast_numify($a) <=> fast_numify($b) } keys %{ $self->{versions} };
}

sub version_pairs {
    my ($self) = @_;
    return map { [ $self->{name}, $_ ] } $self->versions;
}

sub version_satisfies {
    my ( $self, $version ) = @_;
    my $minver = fast_numify($version);
    for my $version ( $self->versions ) {
        my $choice = fast_numify($version);
        if ( $choice >= $minver ) {
            return $self->{versions}->{$version};
        }
    }
    return;
}
1;

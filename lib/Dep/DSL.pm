use strict;
use warnings;

package Dep::DSL;

sub _clean_eval { eval $_[0] };

use Carp qw( croak );
use Dep;

our $IN_READ;
our $IN_ITEM;

our $item;

sub name($) {
    my ($name) = @_;
    if ( not $IN_ITEM ) {
        croak "name illegal outside item";
    }
    if ( exists $item->{name} ) {
        croak "name already defined";
    }
    $item->{name} = $name;
}

sub provides(%) {
    my (%items) = @_;
    if ( not $IN_ITEM ) {
        croak "provides illegal outside item";
    }
    $item->{provides} ||= {};
    for my $key ( keys %items ) {
        $item->{provides}->{$key} = $items{$key};
    }
}

sub requires(@) {
    my (@items) = @_;
    if ( not $IN_ITEM ) {
        croak "requires illegal outside item";
    }
    $item->{requires} ||= {};
    if ( @items == 1 ) {
        $item->{requires}->{ $items[0] } = 0;
        return;
    }
    my (%items) = @items;
    for my $key ( keys %items ) {
        $item->{requires}->{$key} = $items{$key};
    }
}

use Data::Dumper qw( Dumper );

sub item(&) {
    my ($code) = @_;
    if ( not $IN_READ ) {
        croak "item illegal outside of read_file";
    }
    local $IN_ITEM = 1;
    local $item    = {};
    $code->();
    Dep->new( %{$item} );
    1;
}

sub read_file {
    my ($file) = @_;
    if ($IN_READ) {
        croak "read_file illegal inside read_file";
    }
    my $content = do {
        open my $fh, '<', $file or die "Can't open $file for read, $!";
        local $/;
        <$fh>;
    };
    my $code     = "";
    my $filename = $file;
    $filename =~ s/\n//g;
    $filename =~ s/"/\"/g;
    $code .= sprintf "#file \"%s\"\n#line 1 \"%s\"\n", $filename, $filename;
    $code .= $content;
    local $IN_READ = 1;
    local $@;
    _clean_eval($code);
    die "Error sourcing $file: $@" if $@;
}

1;
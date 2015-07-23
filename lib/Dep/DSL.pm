use strict;
use warnings;

package Dep::DSL;

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

sub requires(%) {
    my (%items) = @_;
    if ( not $IN_ITEM ) {
        croak "requires illegal outside item";
    }
    $item->{requires} ||= {};
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
    print Dumper($item);
    Dep->new( %{$item} );
}

sub read_file {
    my ($file) = @_;
    if ($IN_READ) {
        croak "read_file illegal inside read_file";
    }
    local $IN_READ = 1;
    do $file >= 1 or die "Error sourcing $file";
}

1;

#!/usr/bin/env perl 
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

my $root = "$FindBin::Bin/../resources";

use Dep;
use Dep::DSL;

Dep::DSL::read_tree($root);

for my $pair ( Dep->get_module_pairs ) {
    Dep->resolve_dependency( @{$pair} );
}
for my $distname ( Dep->get_distnames ) {
    my $dist = Dep->get_dist($distname);
    for my $module ( keys %{ $dist->requires } ) {
        Dep->resolve_dependency( $module, $dist->requires->{$module} );
    }
}
print "OK\n";
exit;

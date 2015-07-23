use strict;
use warnings;

package Dep::Graph;

use Dep;

sub as_dot {
    my (@out) = 'digraph a {';
    for my $name ( Dep->get_distnames ) {
        my $dep = Dep->get_dist($name);
        for my $module ( sort keys %{ $dep->requires } ) {
            my $resolvant = Dep->resolve_dependency( $module, $dep->requires->{$module} );
            push @out, sprintf '"%s" -> "%s"', $name, $resolvant->name;
        }
    }
    push @out, '}';
    return join qq[\n], @out;
}

1;

#!/usr/bin/env perl 
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

my $root = "$FindBin::Bin/../resources";

use Dep;
use Dep::DSL;
use Dep::Graph;

Dep::DSL::read_tree($root);
open my $fh, '>', 'deps.dot';
print {$fh} Dep::Graph->as_dot;
close $fh;
print "deps.dot written\n";
exit;

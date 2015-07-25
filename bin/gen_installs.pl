#!/usr/bin/env perl 
use strict;
use warnings;

use FindBin;
use lib "$FindBin::Bin/../lib";

my $root = "$FindBin::Bin/../resources";

use Dep;
use Dep::DSL;

Dep::DSL::read_tree($root);

## Integrity check
if ( $ENV{INTEGRITY_CHECK} ) {
    for my $pair ( Dep->get_module_pairs ) {
        Dep->resolve_dependency( @{$pair} );
    }

    for my $distname ( Dep->get_distnames ) {
        my $dist = Dep->get_dist($distname);
        for my $module ( keys %{ $dist->requires } ) {
            Dep->resolve_dependency( $module, $dist->requires->{$module} );
        }
    }
    exit;
}
##
open my $fh, '>', 'bork_cpan.pm' or die "cant open bork_cpan.pm";
print {$fh} <<'EOF';
#!/usr/bin/env perl 
use strict;
use warnings;

package bork_cpan;

require CPAN;
my ( $orig ) = \&CPAN::Distribution::unsat_prereq;
{ 
  no warnings q[redefine];
  *CPAN::Distribution::unsat_prereq = sub {
    my ( $self, @args ) = @_;
    my ( @return ) = $self->$orig(@args);
    @return = grep { defined $_ and length $_ and !/\A\s*\z/ } @return;
    if ( @return ) {
      die qq[Unsatisfied Prereqs @return];
    }
    return @return;
  };
}

1;
EOF
close $fh;

print <<"EOF";
# vim: syntax=sh

cpan() {
  perl -I. -Mbork_cpan -MCPAN -e 'install(\@ARGV)' \$@
  return \$?
}
cpan_force() {
  perl -I. -Mbork_cpan -MCPAN -e 'force(install=>\@ARGV)' \$@
  return \$?
}

has_version() {
  local ok;
  if [ "\$2" == "0" ]; then
    perl -M\$1 -e 1 2>/dev/null \\
      && echo -e "\\e[32m \$1 \$2 OK\\e[0m" \\
      && return;
  fi
  perl -M\$1\\ \$2 -e 1 2>/dev/null \\
    && echo -e "\\e[32m \$1 \$2 OK\\e[0m" \\
    && return;
  echo -e "\\e[33m \$1 v \$2 Not installed\\e[0m"
  return 1
}


set -euo pipefail
EOF

use Carp;
croak "Need a module" unless $ARGV[0];
print Dep->dep_as_bash( $ARGV[0], $ARGV[1] || '0' );
print "\n#end\n";

if ( $ENV{GRAPH} ) {
    require Dep::Graph;
    open my $fh, '>', 'deps.dot';
    print {$fh} Dep::Graph->as_dot;
    close $fh;
}
exit;

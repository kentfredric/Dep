use strict;
use warnings;
package Dep::Version;

sub import {
  my $caller = caller;
  no strict;
  *{ "$caller" . '::fast_numify' } = \&fast_numify;
}

sub fast_numify {
    my ($version) = @_;
    if ( $version =~ /\A\d+\z/ ) {
        return $version;
    }
    if ( $version =~ /\A\d+\.\d+\z/ ) {
        return $version;
    }
    if ( $version =~ /_/ ) {
        my $stripped = $version;
        $stripped =~ s/_//g;
        if ( $stripped =~ /\A\d+\.\d+\z/ ) {
            return $stripped;
        }
    }
    $version =~ s/\Av//g;    #strip leading v
    my (@parts) = split /_|\./, $version;    # Alpha V-Strings ahoy!
    my $major = shift @parts;
    return sprintf "%s.%s", $major, join q[], map { sprintf "%03d", $_ } @parts;
}
1;


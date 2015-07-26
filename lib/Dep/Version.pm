use strict;
use warnings;

package Dep::Version;

sub import {
    my $caller = caller;
    no strict;
    *{ "$caller" . '::fast_numify' } = \&fast_numify;
    *{ "$caller" . '::fast_vpp' }    = \&fast_vpp;
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

sub fast_vpp {
    my ($version) = @_;
    my ( $major, $minor ) = split /\./, fast_numify($version);
    my $padlength = int( length($minor) / 3 ) + 1 * 3;
    my $needchars = $padlength - length($minor);
    return $major . q[.] . $minor . ( '0' x $needchars ) . q[ (] . $version . ')';
}
1;


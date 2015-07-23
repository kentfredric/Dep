item {
    name 'ZEFRAM/Carp-1.22.tar.gz';
    provides Carp => '1.22';
    requires 'Exporter';
    requires 'Test::More';
};
item {
    name 'ZEFRAM/Carp-1.3301.tar.gz';
    provides Carp     => '1.3301';
    requires 'parent' => '0.217';
    requires 'Test::More';
};
# 1.34_01 to 1.36 broken on perl 5.6.1

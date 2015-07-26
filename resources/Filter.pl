# First version to pass without XS failures on 5.6.1
item {
    name 'PMQS/Filter-1.16.tar.gz';
    provides 'Filter::Util::Call' => '1.04';
    provides 'Filter::Util::Exec' => '1.01';
};

item {
    name 'RURBAN/Filter-1.55.tar.gz';
    provides 'Filter::Util::Call' => '1.55';
    provides 'Filter::Util::Exec' => '1.55';

    requires 'Test::More';
};

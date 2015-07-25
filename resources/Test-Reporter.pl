item {
    name 'AFOXSON/Test-Reporter-1.13.tar.gz';
    provides 'Test::Reporter' => '1.13';

    requires 'Net::SMTP';
};

# Broken due to the SMTP server connection failing
# giving undef->autoflush(1) error;
0 && item {
    name 'RSOD/Test-Reporter-1.27.tar.gz';
    provides 'Test::Reporter' => '1.27';

    requires 'File::Temp';
    requires 'Test::More';
    requires 'Net::SMTP';
};

item {
    name 'FOX/Test-Reporter-1.29_01.tar.gz';
    provides 'Test::Reporter' => '1.29_01';

    requires 'File::Temp';
    requires 'Test::More';
    requires 'Net::SMTP';
};

item {
    name 'FOX/Test-Reporter-1.29_02.tar.gz';
    provides 'Test::Reporter' => '1.29_02';

    requires 'File::Temp';
    requires 'Test::More';
    requires 'Net::SMTP';
};

item {
    name 'FOX/Test-Reporter-1.29_03.tar.gz';
    provides 'Test::Reporter' => '1.29_03';

    requires 'File::Temp';
    requires 'Test::More';
    requires 'Net::SMTP';
};

item {
    name 'FOX/Test-Reporter-1.29_04.tar.gz';
    provides 'Test::Reporter' => '1.29_04';

    requires 'File::Temp';
    requires 'Test::More';
    requires 'Net::SMTP';
};

item {
    name 'FHOXH/Test-Reporter-1.30.tar.gz';
    provides 'Test::Reporter' => '1.30';

    requires 'File::Temp';
    requires 'Net::SMTP';
};

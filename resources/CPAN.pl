item {
    name 'ANDK/CPAN-1.60b.tar.gz';
    provides 'CPAN' => '1.60';
    requires 'Test::More';
};
item {
    name 'ANDK/CPAN-1.70.tar.gz';
    provides 'CPAN' => '1.70';
    requires 'Test::More';
};
item {
    name 'ANDK/CPAN-1.80.tar.gz';
    provides 'CPAN' => '1.80';
    requires 'Test::More';
};
item {
    #| Build.PL Support
    name 'ANDK/CPAN-1.90.tar.gz';
    provides 'CPAN' => '1.90';
    requires 'Test::More';
    requires 'Scalar::Util';
    requires 'Test::Harness' => '2.62';
    requires 'Time::HiRes';
};
item {
    name 'ANDK/CPAN-2.10.tar.gz';
    provides 'CPAN'                => '2.10';
    requires 'Test::More'          => '0.88';
    requires 'Test::Harness'       => '2.62';
    requires 'ExtUtils::MakeMaker' => '6.32';
    requires 'version'             => '0.88';
    requires 'if';
    requires 'CPAN::Meta::Requirements' => '2.121';
    requires 'IO::Scalar'               => '2.105';
    requires 'Time::HiRes';
    requires 'HTTP::Tiny' => '0.005';
};

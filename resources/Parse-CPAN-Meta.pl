item {
    name 'ADAMK/Parse-CPAN-Meta-0.01.tar.gz';
    provides 'Parse::CPAN::Meta' => '0.01';
    requires 'Test::More'        => '0.47';
    requires 'YAML::Tiny';
};
item {
    name 'DAGOLDEN/Parse-CPAN-Meta-1.4400.tar.gz';
    provides 'Parse::CPAN::Meta'         => '1.4400';
    requires 'Test::More'                => '0.47';
    requires 'JSON::PP'                  => '2.27013';
    requires 'CPAN::Meta::YAML'          => '0.002';
    requires 'Module::Load::Conditional' => '0.26';
};


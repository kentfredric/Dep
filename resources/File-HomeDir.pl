item {
    name 'SBURKE/File-HomeDir-0.03.tar.gz';
    provides 'File::HomeDir' => '0.03';
};
item {
    name 'SBURKE/File-HomeDir-0.58.tar.gz';
    provides 'File::HomeDir'       => '0.58';
    requires 'Test::More'          => '0.47';
    requires 'ExtUtils::MakeMaker' => '6.17';    # pm_to_blib sub
};

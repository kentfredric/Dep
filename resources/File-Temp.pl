item {
    name 'TJENNESS/File-Temp-0.13.tar.gz';
    provides 'File::Temp' => '0.13';
};
item {
    # First with '->new'
    name 'TJENNESS/File-Temp-0.14.tar.gz';
    provides 'File::Temp' => '0.14';
};
item {
    name 'TJENNESS/File-Temp-0.16.tar.gz';
    provides 'File::Temp' => '0.16';
    requires 'Test::More';
};
item {
    name 'TJENNESS/File-Temp-0.20.tar.gz';
    provides 'File::Temp' => '0.20';
    requires 'Test::More';
};

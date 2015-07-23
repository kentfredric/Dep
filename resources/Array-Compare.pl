item {
    name 'DAVECROSS/Array-Compare-0.01.tar.gz';
    provides 'Array::Compare' => '0.01';
};
item {
    # Last release before Build.PL was added
    name 'DAVECROSS/Array-Compare-1.03.tar.gz';
    provides 'Array::Compare' => '1.03';
};
item {
    # Last version before Moose/Moo hits
    name 'DAVECROSS/Array-Compare-1.18.tar.gz';
    provides 'Array::Compare' => '1.18';

    requires 'Carp';
    requires 'Module::Build';

    # Earlier CPAN's cant handle Build.PL
    requires 'CPAN' => '1.90 ';
};


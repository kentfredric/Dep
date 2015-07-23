if ( $ENV{ASKING_FOR_PROBLEMS} ) {

    # Versions before 2.110 have values of $VERSION larger than 40 internally == not going to work
    item {
        name 'ERYQ/IO-stringy-1.104.tar.gz';
        provides 'IO::Scalar' => '1.104';
    };
    item {
        name 'ERYQ/IO-stringy-2.105.tar.gz';
        provides 'IO::Scalar' => '2.105';
    };
}
item {
    name 'DSKOLL/IO-stringy-2.110.tar.gz';
    provides 'IO::Scalar' => '2.110';
};
item {
    name 'DSKOLL/IO-stringy-2.111.tar.gz';
    provides 'IO::Scalar' => '2.111';
};

use 5.006;
use strict;
use warnings FATAL => 'all';
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Bio::DB::NextProt',
    AUTHOR           => q{Felipe da Veiga Leprevost <leprevost@cpan.org>},
    VERSION_FROM     => 'lib/Bio/DB/NextProt.pm',
    ABSTRACT_FROM    => 'lib/Bio/DB/NextProt.pm',
    LICENSE          => 'perl',
    PL_FILES         => {},
    MIN_PERL_VERSION => 5.012000,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM => {
	'REST::Client'		=> 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'Bio-DB-NextProt-*' },
);

use strict;
use warnings FATAL => 'all';
use Test::More;
use REST::Client;
use Bio::DB::NextProt;

plan tests => 5;

#connection objects
my ($np, $rest);

ok( $np = Bio::DB::NextProt->new(), "testing constructor" );
$rest = REST::Client->new({host=> "http://www.nextprot.org", timeout => 10,});

# search functionalities
my (@res_a, @res_b);
@res_a = $rest->GET('/rest/protein/list?query=kinase&format=json');
@res_b = $np->search_protein(-query => "kinase");
is( @res_a, @res_b );

# find information by protein
my (@res_c, @res_d);
@res_a = $rest->GET('/rest/cv/list?query=colon&filter=tissue&format=json');
@res_b = $np->search_cv(-query => "colon", -filter => "tissue");
is( @res_c, @res_d );

# find information by isoform
my (@res_e, @res_f);
@res_e = $rest->GET('/rest/isoform/NX_P01116-2/ptm&format=json');
@res_f = $np->get_isoform_info(-id => "NX_P01116-2");
is( @res_e, @res_f );

#find information by controlled vocabulary
my (@res_g, @res_h);
@res_g = $rest->GET('/rest/cv/PTM-0205/proteins&format=json');
@res_h = $np->get_protein_cv_info(-query => "PTM-0205", -retrieve => "proteins");
is( @res_g, @res_h );

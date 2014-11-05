# BioPerl module for Bio::DB::NextProt
#
# Please direct questions and support issues to <bioperl-l@bioperl.org>
#
# Copyright Felipe da Veiga Leprevost
#
# You may distribute this module under the same terms as perl itself.

=head1 NAME

Bio::DB::NextProt - Object interface to NextProt REST API.

=head1 SYNOPSIS

	my $np = Bio::DB::NextProt->new();

	my @result_1 = $np->search_cv(-query => "kinase#");

	my @result_2 = $np->get_isoform_info(-id => "NX_O00142-2");

	my @result_3 = $np->get_protein_cv_info(-id => "PTM-0205", -format => "html");

=head1 DESCRIPTION

The module allows the dynamic retrieval of information from the NextProt Database
through its API service. All the information below was extracted from the API webpage.
For the moment the results obtained from the API are in pure HTML, XML or JSON, so
you will have to parse them yourself. 

=head2 Search functionalities

=head3 Search Protein

Search proteins matching the query or search proteins for which the filter is true. 
Available filter values are: structure, disease, expression, mutagenesis or proteomics.
Note: only one filter parameter at a time is possible for the moment. 

	@result = $np->search_protein(-query => "kinase");
	@result = $np->search_protein(-query => "kinase", -filter => "disease");

=head3 Control Vocabulary Terms

Search control vocabulary terms matching the query or search control vocabulary terms in the category specified by the filter. 
Available filter values are: enzyme, go, mesh, cell, domain, family, tissue, metal, pathway, disease, keyword, ptm, subcell.
Note: only one category at a time is possible. 

	@result = $np->search_cv(-query => "colon");
	@result = $np->search_cv(-query => "colon", -filter => "keyword");

=head3 Format: 

Output format maybe in JSON (default), HTML or XML.	

	@result = $np->search_protein(-query => "kinase", -filter => "disease", -format => "html");


=head2 Find information by protein entry

=head3 Protein ID

ID is neXtProt identifier.
Retrieve gene name as well as main identifier and isoform sequences

	@result = $np->get_protein_info(-query => "NX_P13051");

=head3 Post-translational modifications

For each isoform of the specified entry, retrieve all post-translational modifications. 

	@result = $np->get_protein_info(-query => "NX_P13051", -retrieve => "ptm");

=head3 Variant

For each isoform of the specified entry, retrieve all variants. 

	@result = $np->get_protein_info(-query => "NX_P13051", -retrieve => "variant");

=head3 Localisation

For each isoform of the specified entry, retrieve all subcellular location. 

	@result = $np->get_protein_info(-query => "NX_P13051", -retrieve => "localisation");

=head3 Expression

Retrieve all expression information by tissue for the specified entry. 

	@result = $np->get_protein_info(-query => "NX_P13051", -retrieve => "expression");

=head3 Format: 

Output format maybe in JSON (default), HTML or XML.

	@result = $np->get_protein_info(-query => "NX_P13051", -retrieve => "expression", -format => "html");


=head2 Find information by isoform

=head3 Protein ID

ID is neXtProt identifier.
Retrieve gene name as well as main identifier and isoform sequences

	@result = $np->get_isoform_info(-query => "NX_O00142-2");

=head3 Post-translational modifications

For each isoform of the specified entry, retrieve all post-translational modifications. 

	@result = $np->get_isoform_info(-query => "NX_P01116-2", -retrieve => "ptm");

=head3 Variant

For each isoform of the specified entry, retrieve all variants. 

	@result = $np->get_isoform_info(-query => "NX_P01116-2", -retrieve => "variant");

=head3 Localisation

For each isoform of the specified entry, retrieve all subcellular location. 

	@result = $np->get_isoform_info(-query => "NX_P01116-2", -retrieve => "localisation");


=head2 Find information by controlled vocabulary term

=head3 Protein ID

ID is neXtProt identifier.
Retrieve the accession, the name and the category of the CV term.

	@result = $np->get_protein_cv_info(-query => "PTM-0205");

=head3 Protein List

List all the proteins associated with the term in neXtProt.

	@result = $np->get_protein_cv_info(-query => "PTM-0205", -retrieve => "proteins");

=head3 Format: 

Output format maybe in JSON (default), HTML or XML.

	@result = $np->get_protein_cv_info(-query => "PTM-0205", -retrieve => "proteins", -format => "html");


=head2 Retrieving Accession Lists

Allows the retrieval of all accession codes from individual chromossomes or from the entire NextProt database.

	@result = $np->get_accession_list(-chromosome => "10");

	@result = $np->get_accession_list(-chromosome => "all");

=head3 entries with a protein existence "at protein level" (PE 1)

	@result = $np->get_accession_list(-evidence => "protein_level");

=head3 entries with a protein existence "at transcript level" (PE 2)

    @result = $np->get_accession_list(-evidence => "transcript_level");

=head3 entries with a protein existence "by homology" (PE 3)

    @result = $np->get_accession_list(-evidence => "homology");

=head3 entries with a protein existence "predicted" (PE 4)

    @result = $np->get_accession_list(-evidence => "predicted");

=head3 entries with a protein existence "uncertain" (PE 5)

    @result = $np->get_accession_list(-evidence => "uncertain");


=head2 Customized Report Files for the HUPO Human Proteome Project (HPP)


=head3 Individual report files for each chromosomes (1 to 22, X, Y and MT)

	my @list = $np->get_hpp_report(-chromosome => 10);

=head3 Annotated phosphorylated residues per chromosome

	my @list = $np->get_hpp_report(-phospho => "true");

=head3 Annotated N-Acetyl residues per chromosome

	my @list = $np->get_hpp_report(-nacetyl => "true");


=head2 NextProt Mapping

Mapping of neXtProt accession numbers to external resources.

=head3 Ensembl gene identifiers

	@list = $np->get_mapping(-map => "ensembl_gene");

=head3 Ensembl protein identifiers

	@list = $np->get_mapping(-map => "ensembl_protein");

=head3 protein ids that cannot be mapped to any isoform in neXtProt

	@list = $np->get_mapping(-map => "ensembl_unmapped");

=head3 Ensembl transcript identifiers

	@list = $np->get_mapping(-map => "ensembl_transcript");

=head3 transcript is considered as coding by Ensembl that cannot be mapped to any isoform in neXtProt

	@list = $np->get_mapping(-map => "ensembl_transcript_unmapped");

=head3 NCBI GeneID gene accession numbers

	@list = $np->get_mapping(-map => "geneid");

=head3 HGNC gene accession numbers

    @list = $np->get_mapping(-map => "hgnc");

=head3 MGI mouse gene accession numbers

    @list = $np->get_mapping(-map => "mgi");

=head3 NCBI RefSeq gene accession numbers

    @list = $np->get_mapping(-map => "refseq");


=head2 Chromosome Report

The module also allows the programatic access to chromosome information by accessing and formatting the 
chr_report tables from the nextprot ftp server.
The retrieved structure is a hash of hashes, being the first key the NextProt Accession Number. 
The internal hashes have the following values:

* Gene Name
* Chromosomal position
* Start position
* Stop position 
* Protein existence
* Proteomics
* Antibody
* 3D
* Disease
* Isoforms
* Variants
* PTMs
* Description

This is how the data is representes in the hashes:

    NX_A7E2V4                   {
        antibody         "yes",
        description      "Zinc finger SWIM domain-containing protein 8",
        disease          "no",
        existence        "protein level",
        has_3d           "no",
        isoforms         5,
        gene_name        "ZSWIM8",
        position         "10q22.2",
        proteomics       "yes",
        ptms             6,
        start_position   75545340,
        stop_position    75561551,
        variants         67
    }

=head3 Loading the Chromosome table. 

Loas all the information from tha table.

	my %data = $np->get_chromosome(-chromosome => 10);


=head3 Accessing Protein information:

	say $data{ZSWIM8}->{isoforms};
	say $data{ZSWIM8}->{proteomics};
	say $data{ZSWIM8}->{description};


=head3 Counting the number of Proteins in the Chromosome

	$sum = (keys %data);
	say $sum;		 


=head3 Retrieve all Gene Names from a giving Chromosome
	
	for my $prot (keys %data) {
		say $prot;
	}


=head1 FEEDBACK

=head2 Mailing Lists

User feedback is an integral part of the evolution of this and other
Bioperl modules. Send your comments and suggestions preferably to one
of the Bioperl mailing lists. Your participation is much appreciated.

  bioperl-l@bioperl.org                  - General discussion
  http://bioperl.org/wiki/Mailing_lists  - About the mailing lists

=head2 Support

Please direct usage questions or support issues to the mailing list:

I<bioperl-l@bioperl.org>

rather than to the module maintainer directly. Many experienced and
reponsive experts will be able look at the problem and quickly
address it. Please include a thorough description of the problem
with code and data examples if at all possible.

=head2 Reporting Bugs

Report bugs to the Bioperl bug tracking system to help us keep track
the bugs and their resolution.  Bug reports can be submitted via the
web:

  https://github.com/bioperl/bioperl-live

=head1 AUTHOR - Felipe da Veiga Leprevost

Email leprevost@cpan.org

=cut

package Bio::DB::NextProt;

our $VERSION = '1.04';

use strict;
use warnings;
use REST::Client;
use Net::FTP::Tiny qw(ftp_get);


sub new {
	my ($class, @args) = @_;
	#my $self = $class->SUPER::new(@args);
	my $self = {};
	$self->{_client}		= REST::Client->new({host=> "http://www.nextprot.org", timeout => 10,});
	$self->{_query}			= undef;
	$self->{_filter}		= undef;
	$self->{_chromosome}	= undef;
	$self->{_format}		= "json";
	bless($self, $class);
	return $self;
}

sub search_protein() {
	
	my $self  = shift;
    my %param = @_;

	my $path = "/rest/protein/list";

    $self->{_format} = $param{'-format'} if defined $param{'-format'};

	if (defined $param{'-query'} && defined $param{'-filter'}) {
		
		$self->{_client}->GET($path."?query=".$param{'-query'}."&filter=".$param{'-filter'}."&format=".$self->{_format});

	} elsif (defined $param{'-query'}) {
		
		$self->{_client}->GET($path."?query=".$param{'-query'}."&format=".$self->{_format});

	} elsif (defined $param{'-filter'}) {
		
		$self->{_client}->GET($path."?filter=".$param{'-filter'}."&format=".$self->{_format});
	}

	&reset_params();

	return $self->{_client}->responseContent();

}

sub search_cv() {
	my $self  = shift;
	my %param = @_;
	
	my $path   = "/rest/cv/list";

    $self->{_format} = $param{'-format'} if defined $param{'-format'};

    if (defined $param{'-query'} && defined $param{'-filter'}) {

        $self->{_client}->GET($path."?query=".$param{'-query'}."&filter=".$param{'-filter'}."&format=".$self->{_format});

    } elsif (defined $param{'-query'}) {

        $self->{_client}->GET($path."?query=".$param{'-query'}."&format=".$self->{_format});

    } elsif (defined $param{'-filter'}) {

        $self->{_client}->GET($path."?filter=".$param{'-filter'}."&format=".$self->{_format});
    }

	&reset_params();

	return $self->{_client}->responseContent();

}

sub get_protein_info() {
	my $self  = shift;
	my %param = @_;

	my $path   = "/rest/entry/";

    $self->{_format} = $param{'-format'} if defined $param{'-format'};

	if (defined $param{'-query'} && $param{'-retrieve'}) {

		$self->{_client}->GET($path.$param{'-query'}."/".$param{'-retrieve'}."?format=".$self->{_format});

	} elsif (defined $param{'-query'}) {

		$self->{_client}->GET($path.$param{'-query'}."?format=".$self->{_format});
	}

	&reset_params();

	return $self->{_client}->responseContent();

}

sub get_isoform_info() {
	my $self  = shift;
	my %param = @_;

	my $path = "/rest/isoform/";

    $self->{_format} = $param{'-format'} if defined $param{'-format'};

    if (defined $param{'-query'} && $param{'-retrieve'}) {

        $self->{_client}->GET($path.$param{'-query'}."/".$param{'-retrieve'}."?format=".$self->{_format});

	} elsif (defined $param{'-query'}) {

	    $self->{_client}->GET($path.$param{'-query'}."?format=".$self->{_format});
	}

	&reset_params();

	return $self->{_client}->responseContent();

}

sub get_protein_cv_info() {
	my $self  = shift;
	my %param = @_;

	my $path = "/rest/cv/";

	$self->{_format} = $param{'-format'} if defined $param{'-format'};

	if (defined $param{'-query'} && $param{'-retrieve'}) {
		
		$self->{_client}->GET($path.$param{'-query'}."/".$param{'-retrieve'}."?format=".$self->{_format});

    } elsif (defined $param{'-query'}) {

        $self->{_client}->GET($path.$param{'-query'}."?format=".$self->{_format});
    }

	&reset_params();
    
	return $self->{_client}->responseContent();

}

sub get_accession_list() {
	my $self	= shift;
	my %param	= @_;

	my $path = "ftp://ftp.nextprot.org/pub/current_release/ac_lists";
	my @file = ();

	if ( defined $param{'-chromosome'} ) {

		$self->{_chromosome} = $param{'-chromosome'};
		my $chrom = $self->{_chromosome};

		if ($chrom eq "all") {
			@file = ftp_get($path."/"."nextprot_ac_list_all.txt");
		} else {
			@file = ftp_get($path."/"."nextprot_ac_list_chromosome_".$chrom.".txt");
		}

	} elsif ( defined $param{'-evidence'} ) {

		if ( $param{'-evidence'} eq "protein_level" ) {
			@file = ftp_get($path."/"."nextprot_ac_list_PE1_at_protein_level.txt");
		} elsif ( $param{'-evidence'} eq "transcript_level" ) {
			@file = ftp_get($path."/"."nextprot_ac_list_PE2_at_transcript_level.txt");
		} elsif ( $param{'-evidence'} eq "homology" ) {
			@file = ftp_get($path."/"."nextprot_ac_list_PE3_homology.txt")
		} elsif ( $param{'-evidence'} eq "predicted" ) {
			@file = ftp_get($path."/"."nextprot_ac_list_PE4_predicted.txt")
		} elsif ( $param{'-evidence'} eq "uncertain" ) {
			@file = ftp_get($path."/"."nextprot_ac_list_PE5_uncertain.txt")
		}
	}

	&reset_params();
	return @file;
}


sub get_hpp_report() {
	my $self	= shift;
	my %param	= @_;

	my $path = "ftp://ftp.nextprot.org/pub/current_release/custom/hpp";
	my @file = ();

	if ( defined $param{'-chromosome'} ) {

    	my $chrom = $param{'-chromosome'};
		@file = ftp_get($path."/"."HPP_chromosome_".$chrom.".txt");

	} elsif ( defined $param{'-phospho'} ) {
		@file = ftp_get($path."/"."HPP_entries_with_phospho_by_chromosome.txt");
	} elsif ( defined $param{'-nacetyl'} ) {
		@file = ftp_get($path."/"."HPP_entries_with_nacetyl_by_chromosome.txt");
	}

	&reset_params();
	return @file;
		
}


sub get_mapping() {
	my $self	= shift;
	my %param	= @_;

	my $path = "ftp://ftp.nextprot.org/pub/current_release/mapping";
	my @file = ();

	if ( defined $param{'-map'} ) {
		my $db = $param{'-map'};

		if ( $db eq 'ensembl_gene' ) {
			@file = ftp_get($path."/"."nextprot_ensg.txt");
		} elsif ( $db eq 'ensembl_protein' ) {
			@file = ftp_get($path."/"."nextprot_ensp.txt");
		} elsif ( $db eq 'ensembl_unmapped' ) {
			@file = ftp_get($path."/"."nextprot_ensp_unmapped.txt");
		} elsif ( $db eq 'ensembl_transcript' ) {
			@file = ftp_get($path."/"."nextprot_enst.txt");
		} elsif ( $db eq 'ensembl_transcript_unmapped' ) {
			@file = ftp_get($path."/"."nextprot_enst_unmapped.txt");
		} elsif ( $db eq 'geneid' ) {
			@file = ftp_get($path."/"."nextprot_geneid.txt");
		} elsif ( $db eq 'hgnc' ) {
			@file = ftp_get($path."/"."nextprot_hgnc.txt");
		} elsif ( $db eq 'mgi' ) {
			@file = ftp_get($path."/"."nextprot_mgi.txt");
		} elsif ( $db eq 'refseq' ) {
			@file = ftp_get($path."/"."nextprot_refseq.txt");
		}
	}
	
	&reset_params();
	return @file;

}


sub get_chromosome() {
	my $self  =	shift;
	my %param =	@_;

	my @data  = ();
	my %table = ();

	my $path = "ftp://ftp.nextprot.org/pub/current_release/chr_reports";

	if ( defined $param{'-chromosome'} ) {

		$self->{_chromosome} = $param{'-chromosome'};
		my $chrom = $self->{_chromosome};
		my $file = ftp_get($path."/"."nextprot_"."chromosome_".$chrom.".txt");
		my @data = split /^/m, $file;

		for my $prot (@data) {
			chomp $prot;

			if ($prot =~ m/^[A-Za-z|0-9\-]+\s+NX/) {
				
				$prot =~ s/\s{2,}/\t/g;
				my @temp = split(/\t/, $prot);

				#if (exists $table{$temp[1]}) {
				#	print "redundancy detected: $temp[1]\n";
				#}

				$table{$temp[1]} = {
					gene_name		=>  $temp[0],
					position        =>  $temp[2],
					start_position  =>  $temp[3],
					stop_position   =>  $temp[4],
					existence       =>  $temp[5],
					proteomics      =>  $temp[6],
					antibody        =>  $temp[7],
					has_3d          =>  $temp[8],
					disease         =>  $temp[9],
					isoforms        =>  $temp[10],
					variants        =>  $temp[11],
					ptms            =>  $temp[12],
					description     =>  $temp[13],
				}

			}
		}

	}


	&reset_params();

	return %table;
}


sub reset_params() {
	my $self = shift;

	$self->{_query}  = undef;
	$self->{_filter} = undef;
}


1;

#!/usr/bin/env perl 
#

use utf8;
use 5.010;
use strict;
use warnings;

use Data::Dumper;
use Config::Options;
use Try::Tiny;

use Log::Log4perl qw(:easy);

use Getopt::Long qw(:config);

use Dev;

my $conffile = Config::Options->new();
my $conf={};
$conf->{config} = 'config.txt';

use Rex -feature => ['1.4'];

GetOptions( 'hostname=s' => \$conf->{hostname}
          , 'username=s' => \$conf->{username}
	  , 'password=s' => \$conf->{password}
	  , 'destination_path=s' => \$conf->{destination_path}
	  , 'config=s' => \$conf->{config}
	  , 'action=s' => \$conf->{action}
	  , 'apication=s' => \$conf->{aplication}
) or die "Error in command line arguments\n";


$conffile->options("optionfile", $conf->{config});
$conffile->fromfile_perl;
$conffile->deepmerge($conf);

Log::Log4perl->easy_init( {level   => $DEBUG,
	file    => '>>'.$conffile->{logfile},
	layout   => '%d [%P] %c: %p: %m%n' } );
						       
my $dev = Dev->new(conf=>$conffile);  
			


# say  Dumper \$conffile;
print "\n\n MODULE \n\n";
my ($msg, $errormsg) = $dev->check_depend();

if ($errormsg) {
	print "\n ERROR $errormsg \n ";
} else {
	print "\n $msg \n";
};

exit 0;

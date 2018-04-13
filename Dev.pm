package Dev;

use Object::Simple -base;
 
our $VERSION = 0.01;
use Log::Log4perl qw(:easy);

use Data::Dumper;
use Try::Tiny;

use Rex -feature => ['1.4'];
use Rex::Commands::Run 

has ['conf'];

sub test {
	my $self = shift;
#	my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";
	my $message=''; my $errormsg='';
	try {
	  
		Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
		my $res=run ('uname -a');	
		$message = 'All is ok'.$self->conf->{username}."\n".$res;

	} catch {
		    $errormsg= "caught error: $_"; 
	    };
#	print Dumper \$conf;
	return ($message, $errormsg)

};



sub check_depend {

my $self = shift;
my $message=''; my $errormsg='';
#my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
	my $f=$self->conf->{source_path}.'check_depend.sh';
	upload($f, $self->conf->{destination_path});
#	upload($self->conf->{source_path}.'check_depend.sh', $self->conf->{destination_path});
	run($self->conf->{destination_path}.'check_depend.sh');
			
} catch {
	$errormsg= "caught error: $_"; 
};

};




sub install_depend {

my $self = shift;
my $message=''; my $errormsg='';
my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
	upload($self->conf->{source_path}.'install_depend.sh', $self->conf->{destination_path});
	run($self->conf->{destination_path}.'install_depend.sh');

} catch {
	$errormsg= "caught error: $_"; 
};

};



sub deploy_app {

my $self = shift;
my $message=''; my $errormsg='';
my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );

	upload($self->conf->{source_path}.$self->conf->{app}, $self->conf->{destination_path});
	run("jar -xvf ".$self->conf->{app});

} catch {
	$errormsg= "caught error: $_"; 
};

};

sub start_app {

my $self = shift;
my $message=''; my $errormsg='';
my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
	upload($self->conf->{source_path}.'start_app.sh', $self->conf->{destination_path});
	run($self->conf->{destination_path}.'start_app.sh');
} catch {
	$errormsg= "caught error: $_"; 
};

};

sub stop_app {

my $self = shift;
my $message=''; my $errormsg='';
my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
	upload($self->conf->{source_path}.'stop_app.sh', $self->conf->{destination_path});
	run($self->conf->{destination_path}.'stop_app.sh');

} catch {
	$errormsg= "caught error: $_"; 
};

};


sub check_app {

my $self = shift;
my $message=''; my $errormsg='';
my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
	upload($self->conf->{source_path}.'check_app.sh', $self->conf->{destination_path});
	run($self->conf->{destination_path}.'check_app.sh');

} catch {
	$errormsg= "caught error: $_"; 
};

};


sub undeploy_app {

my $self = shift;
my $message=''; my $errormsg='';
my $conf = $_[0] // LOGDIE "Not defined 'conf'\n";

try {
	Rex::connect( server    => $self->conf->{hostname}, user      => $self->conf->{username}, password   => $self->conf->{password} );
	upload($self->conf->{source_path}.'undeploy_app.sh', $self->conf->{destination_path});
	run($self->conf->{destination_path}.'undeploy_app.sh');

} catch {
	$errormsg= "caught error: $_"; 
};

};

#### Check if application no longer available




1;
__END__


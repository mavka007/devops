package Dev;

use Object::Simple -base;
 
our $VERSION = 0.01;
use Log::Log4perl qw(:easy);

use Data::Dumper;
use Try::Tiny;

use Rex -feature => ['1.4'];
use Rex::Commands::Run 

has ['conf'];

sub deploy {
	my $self = shift;
	my $method = $_[0] // LOGDIE "Not defined 'method'\n";
	my $message=''; my $errormsg='';
	try {
	  
		Rex::connect(
		  server    => $method->{hostname},
		  user      => $method->{username},
		  password   => $method->{password},
		  );
print	run ('uname -a');	
		$message = 'All is ok'.$method->{username};

	} catch {
		    $errormsg= "caught error: $_"; # not $@
	    };
#	print Dumper \$method;
	return ($message, $errormsg)

};


1;
__END__


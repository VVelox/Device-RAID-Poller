package Device::RAID::Poller;

use 5.006;
use strict;
use warnings;
use base 'Error::Helper';
use Module::List qw(list_modules);
use JSON;

=head1 NAME

Device::RAID::Poller - The great new Device::RAID::Poller!

=head1 VERSION

Version 0.0.0

=cut

our $VERSION = '0.0.0';


=head1 SYNOPSIS

Quick summary of what the module does.

Perhaps a little code snippet.

    use Device::RAID::Poller;

    my $drp = Device::RAID::Poller->new();
    ...

=head1 METHODS

=head2 new



=cut

sub new {
	my $self = {
				perror=>undef,
				error=>undef,
				errorString=>"",
				errorExtra=>{
							 flags=>{
									 1=>'invalidModule',
									 }
							 },
				modules=> {},
				loaded=> {},
				};
    bless $self;

    return undef;
}

=head2 modules_get

Gets the currently specified modules to run.

A return of undef means none are set and at run-time each module
will be loaded and tried.

    my @modules=$drp->modules_get;

=cut

sub modules_get {
	my $self=$_[0];

	if( ! $self->errorblank ){
		return undef;
	}

	return keys %{ $self->{modules} };
}

=head2 modules_set

This sets modules to use if one does not wish to attempt to load
them all upon load.

=cut

sub modules_set {
	my $self=$_[0];
	my @modules;
	if ( defined( $_[1] ) ){
		@modules=@{ $_[1] }
	}

	if( ! $self->errorblank ){
		return undef;
	}

	my $valid_backends=$self->list_backends;

	if (!defined( $modules[0] )){
		$self->{modules}=\@modules;
	}

	foreach my $module ( @modules ){
		if ( ! exists( $valid_backends->{'Device::RAID::Poller::Backends::'.$module} ) ){
			$self->{error}=1;
			$self->{errorString}='"'.$module.'"';
			$self->warn;
			return undef;
		}
	}

	$self->{modules}=\@modules;

	return 1;
}

=head2 list_backends

This lists the available backends. This lists the full
backends name, meaning it will return 'Device::RAID::Poller::Backends::fbsdGmiiror';

    my $backends=$drp->list_backends;

The returned value is a hashref where each key is a name
of a backend module.

If you want this as a array, you can do the following.

    my @backends=keys %{ $drp->list_backends };

=cut

sub list_backends{
	my $backends=list_modules("Device::RAID::Poller::Backends::", { list_modules => 1});

	return $backends;
}

=head2 list_loaded

This returns the list of backends that loaded
successfully.

=cut

sub list_loaded {
	my $self=$_[0];

	if( ! $self->errorblank ){
		return undef;
	}

	return keys %{ $self->{loaded} };
}

=head2 load

This loads up the modules. Each one in the list is
checked and then if started successfully, it is saved
for reuse later.

=cut

sub load {
	my $self=$_[0];

	if( ! $self->errorblank ){
		return undef;
	}

}

=head2 run

Runs the poller backend and report the results.

If nothing is nothing is loaded, load will be called.

=cut

sub run {

}

=head1 AUTHOR

Zane C. Bowers-Hadley, C<< <vvelox at vvelox.net> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-device-raid-poller at rt.cpan.org>, or through
the web interface at L<https://rt.cpan.org/NoAuth/ReportBug.html?Queue=Device-RAID-Poller>.  I will be
notified, and then you'll automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Device::RAID::Poller


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<https://rt.cpan.org/NoAuth/Bugs.html?Dist=Device-RAID-Poller>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Device-RAID-Poller>

=item * CPAN Ratings

L<https://cpanratings.perl.org/d/Device-RAID-Poller>

=item * Search CPAN

L<https://metacpan.org/release/Device-RAID-Poller>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

This software is Copyright (c) 2019 by Zane C. Bowers-Hadley.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1; # End of Device::RAID::Poller

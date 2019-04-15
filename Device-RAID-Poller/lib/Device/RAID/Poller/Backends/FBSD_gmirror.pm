package Device::RAID::Poller::Backends::FBSD_gmirror;

use 5.006;
use strict;
use warnings;
use base 'Error::Helper';

=head1 NAME

Device::RAID::Poller::Backends::FBSD_gmirror - FreeBSD GEOM mirror RAID backend.

=head1 VERSION

Version 0.0.0

=cut

our $VERSION = '0.0.0';


=head1 SYNOPSIS

    use Device::RAID::Poller::Backends::FBSD_gmirror;

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
									 }
							 },
				usable=>undef,
				};
    bless $self;

    return undef;
}

=head2 run

Runs the poller backend and report the results.

If nothing is nothing is loaded, load will be called.

=cut

sub run {
	my $self=$_[0];

	if( ! $self->errorblank ){
		return undef;
	}

}

=head2 usable

Returns a perl boolean for if it is usable or not.

=cut

sub usable {
	my $self=$_[0];

	my $bin='/sbin/gmirror';
	if (
		( $^O !~ 'freebsd' ) ||
		( -x $bin )
		){
		$self->{usable}=0;
		return 0;
	}

	$self->{usable}=1;
	return 1;
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

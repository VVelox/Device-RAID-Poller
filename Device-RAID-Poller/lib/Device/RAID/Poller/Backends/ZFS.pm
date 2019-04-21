package Device::RAID::Poller::Backends::ZFS;

use 5.006;
use strict;
use warnings;

=head1 NAME

Device::RAID::Poller::Backends::ZFS - ZFS zpool backend.

=head1 VERSION

Version 0.0.0

=cut

our $VERSION = '0.0.0';


=head1 SYNOPSIS

    use Device::RAID::Poller::Backends::ZFS;
    
    my $backend = Device::RAID::Poller::Backends::ZFS;
    
    my $usable=$backend->usable;
    my %return_hash;
    if ( $usable ){
        %return_hash=$backend->run;
    }

=head1 METHODS

=head2 new

Initiates the backend object.

    my $backend = Device::RAID::Poller::Backends::FBSD_gmirror;

=cut

sub new {
	my $self = {
				usable=>0,
				};
    bless $self;

    return undef;
}

=head2 run

Runs the poller backend and report the results.

If nothing is nothing is loaded, load will be called.

    my $usable=$backend->usable;
    

=cut

sub run {
	my $self=$_[0];

	my %return_hash;
	$return_hash{status}=0;

	# if not usable, no point in continuing
	if ( ! $self->{usable} ){
		return %return_hash;
	}

	return %return_hash;
}

=head2 usable

Returns a perl boolean for if it is usable or not.

    my $usable=$backend->usable;
    if ( ! $usable ){
        print "This backend is not usable.\n";
    }

=cut

sub usable {
	my $self=$_[0];

	# Make sure we are on a OS on which ZFS is usable on.
	if (
		( $^O !~ 'freebsd' ) &&
		( $^O !~ 'solaris' ) &&
		( $^O !~ 'netbsd' ) &&
		( $^O !~ 'linux' )
		){
		$self->{usable}=0;
		return 0;
	}

	# make sure we can locate zpool
	my $zpool_bin=`which zpool`;
	if ( $? != 0 ){
		$self->{usable}=0;
        return 0;
	}
	chomp($zpool_bin);
	$self->{zpool_bin}=$zpool_bin;

	# No zpools on this device.
	my $pool_test=`$zpool_bin list`;
	if ( $b !~ /^NAME/ ){
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

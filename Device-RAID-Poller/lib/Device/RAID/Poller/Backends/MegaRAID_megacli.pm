package Device::RAID::Poller::Backends::MegaRAID_megacli;

use 5.006;
use strict;
use warnings;

=head1 NAME

Device::RAID::Poller::Backends::MegaRAID_megacli - Handles polling using the LSI/Broadcome MegaRAID utility, megacli.

=head1 VERSION

Version 0.0.1

=cut

our $VERSION = '0.0.1';


=head1 SYNOPSIS

    use Device::RAID::Poller::Backends::MegaRAID_megacli;
    
    my $backend = Device::RAID::Poller::Backends::MegaRAID_megacli->new;
    
    my $usable=$backend->usable;
    my %return_hash;
    if ( $usable ){
        %return_hash=$backend->run;
        my %status=$backend->run;
        use Data::Dumper;
        print Dumper( \%status );
    }

=head1 METHODS

=head2 new

Initiates the backend object.

    my $backend = Device::RAID::Poller::Backends::MegaRAID_megacli->new;

=cut

sub new {
	my $self = {
				usable=>0,
				adapters=>0,
				};
    bless $self;

    return $self;
}

=head2 run

Runs the poller backend and report the results.

If nothing is nothing is loaded, load will be called.

    my %status=$backend->run;
    use Data::Dumper;
    print Dumper( \%status );

=cut

sub run {
	my $self=$_[0];

	my %return_hash=(
					 'status'=>0,
					 'devices'=>{},
					 );


	$return_hash{status}=1;
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

	if (
		( $^O !~ 'linux' ) &&
		( $^O !~ 'freebsd' )
		){
		$self->{usable}=0;
		return 0;
	}

	# make sure we can locate arcconf
	my $arcconf_bin=`/bin/sh -c 'which megacli 2> /dev/null'`;
	if ( $? != 0 ){
		$self->{usable}=0;
        return 0;
	}

	# make sure we have atleast one device
	my $raw=`megacli adpCount`;

	my @raw_split=split(/\n/, $raw);
	my @found_lines=grep(/Controller\ Count/, @raw_split);
	if (defined( $found_lines[0] )){
		# grab the first and should be online line, which should be formatted like below...
		# Controller Count: 1.
		my $found=$found_lines[0];
		chomp($found);
		$found=~s/.*\:[\t ]*//;
		$found=~s/\.//;
		if (
			( $found =~ /[0123456789]+/ ) &&
			( $found > 0 )
			){
			$self->{adapters}=$found;
		}else{
			# either contains extra characters or zero
			$self->{usable}=0;
			return 0;
		}
	}else{
		# Command errored in some way or output changed.
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

This software is Copyright (c) 2020 by Zane C. Bowers-Hadley.

This is free software, licensed under:

  The Artistic License 2.0 (GPL Compatible)


=cut

1;

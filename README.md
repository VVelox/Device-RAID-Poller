# Device-RAID-Poller

RAID status poller framework for Perl.

For the Perl documentation, please see https://metacpan.org/release/Device-RAID-Poller .

# Supported Backends

## Software

* FreeBSD GEOM
    * RAID - RAID BIOS support as seen in various cheap Intel, JMicron, NVIDIA, Promise, etc chipsets.
    * Mirror
    * RAID3
* Linux
    * mdadm
* ZFS

## Hardware

* 3ware
    * tw_cli
* Adaptec
    * arcconf

# Installing

## FreeBSD

    pkg install perl5 p5-JSON p5-Error-Helper
    # If it asks you if you want to automatically configure CPAN, it is generally safe to say yes.
    cpan Device::RAID::Poller
    
## Linux

### CentOS

Doing the following as root. When cpan asks you if you want to setup as much as possible
automatically, it is safe to answer with yes. In general select sudo as it will make it easiest
to use from multiple users, such as most configuration it will be simplest to install it globally
and not rely on local::lib.

    yum install cpan
    cpan Module::Build Module::List Device::RAID::Poller

### Debian

This has been tested as working on Debian 9 minimal.

    apt install perl perl-base perl-modules make
    cpan Module::Build Module::List Device::RAID::Poller

# Monitoring Configuration

## Nagios Style

### NRPE

First you need to add it to nrpe.conf in a manner similar to as below.

    command[check_raid]=/usr/local/bin/sudo /usr/local/bin/check_raid -n

In general this will be running as nagios and the like, possibly requiring the use of sudo, meaning adding something below
to your suders file.

    nagios ALL = NOPASSWD: /usr/local/bin/check_raid

### Icinga2 Check Command Object

Below adds the check command that checks the previously configured nrpe setup.

    object CheckCommand "rcheck_raid" {
        import "nrpe"
        vars.nrpe_command = "rcheck_raid"
    }

## SNMP

This can easily be added as a extend 

    extend check_raid /usr/local/bin/sudo /usr/local/bin/check_raid -p

The -p flag is not needed, only if you want to make debugging the output easy for debugging when polling from like LibreNMS or the like.

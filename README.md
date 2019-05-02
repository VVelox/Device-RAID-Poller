# Device-RAID-Poller
RAID status poller framework for Perl.

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

* Adaptec
    * arcconf

# Installing

## FreeBSD

    pkg install perl5 p5-JSON p5-Error-Helper
    # If it asks you if you want to automatically configure CPAN, it is generally safe to say yes.
    cpan Device::RAID::Poller
    
## Linux

### CentOS

### Debian


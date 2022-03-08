# GIMP AppImage
A script to build and install an AppImage for the latest GIMP version for GLIBC 2.27 (tested on Ubuntu 18.04 and Debian Testing/Unstable).

This repository provides the script to create and install the latest version of GIMP from https://launchpad.net/~savoury1, and an AppImage ready to be used.

This version is only a sample.

Furter versions can be easily managed by installing [AM Application Manager](https://github.com/ivan-hc/AM-application-manager).
# How to integrate GIMP AppImage into the system
### Installation
To download and install the 64 bit version (x86_64):

    wget https://raw.githubusercontent.com/ivan-hc/GIMP-x86_64.AppImage/main/gimp
    chmod a+x ./gimp
    sudo ./gimp
  To download and install the 32 bit version (i386, i486, i586, i686):

    wget https://raw.githubusercontent.com/ivan-hc/GIMP-x86_64.AppImage/main/gimp32
    chmod a+x ./gimp32
    sudo ./gimp32
### Update

    /opt/gimp/AM-updater
### Uninstall

    sudo /opt/gimp/remove
    
# EXTRA: GIMP Developer Edition AppImage
A script to build and install an AppImage for GIMP Developer Edition with support for GLIBC 2.30 (built for Ubuntu 20.04 and tested on Debian Testing/Unstable) is also available on this repository that provides the script to create and install the latest version of GIMP Developer Edition from https://launchpad.net/~mati75, and an AppImage ready to be used (check https://github.com/ivan-hc/GIMP-64bit-and-32bit.AppImage/releases).

This version is only a sample.

As already wrote above, furter versions can be easily managed by installing [AM Application Manager](https://github.com/ivan-hc/AM-application-manager).
# How to integrate GIMP Developer Edition AppImage into the system
### Installation

    wget https://raw.githubusercontent.com/ivan-hc/GIMP-x86_64.AppImage/main/gimp-dev
    chmod a+x ./gimp-dev
    sudo ./gimp-dev
### Update

    /opt/gimp-dev/AM-updater
### Uninstall

    sudo /opt/gimp-dev/remove

------------------------------------
# These and more scripts will be available on my new repository, at [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager).

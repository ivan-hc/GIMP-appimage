# GIMP-x86_64.AppImage
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


------------------------------------
# These and more scripts will be available on my new repository, at [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager).

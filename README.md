# GIMP-x86_64.AppImage
A script to build and install an AppImage for the latest GIMP version for GLIBC 2.27 (tested on Ubuntu 18.04 and Debian Testing/Unstable).

This repository provides the script to create and install the latest version of GIMP from https://launchpad.net/~savoury1, and an AppImage ready to be used.

This version is only a sample.

Furter versions can be easily managed by installing [AM Application Manager](https://github.com/ivan-hc/AM-application-manager).
# How to integrate GIMP AppImage into the system
### Installation
To download and install the standard version:

    wget https://raw.githubusercontent.com/ivan-hc/GIMP-x86_64.AppImage/main/gimp
    chmod a+x ./gimp
    sudo ./gimp
### Update

    /opt/gimp/AM-updater
### Uninstall

    sudo /opt/gimp/remove


------------------------------------
# These and more scripts will be available on my new repository, at [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager).

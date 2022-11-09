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
***These and more scripts will be available on my new repository, at [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager).***
------------------------------------
# About Rob Savoury's PPA 
SITE: https://launchpad.net/~savoury1

This is a collection of PPAs giving significant upgrades for the past 6+ years of Ubuntu (LTS) releases. Popular software here: Blender, Chromium, digiKam, FFmpeg, GIMP, GPG, Inkscape, LibreOffice, mpv, Scribus, Telegram, and VLC.

***"SavOS project 3 year milestones: 20,000 uploads and 20,000 users"***
               https://medium.com/@RobSavoury/bade09fa042e

Fun stats: Over 23,000 uploads since August 2019 of 5,100 unique packages!
(3 Nov 2022) With now 460+ unique packages published for 22.04 Jammy LTS, 1,730+ for 20.04 Focal LTS, and a whole lot extra for Xenial & Bionic LTS!

If software at this site is useful to you then please consider a donation:

***Donations: https://paypal.me/Savoury1 & https://ko-fi.com/Savoury1***

***Also https://patreon.com/Savoury1 & https://liberapay.com/Savoury1***

UPDATE (8 May 2022): See new https://twitter.com/RobSavoury for updates on the many Launchpad PPAs found here, ie. new packages built, bugfixes, etc.

***Bugs: File bug reports @ https://bugs.launchpad.net/SavOS/+filebug***

[ "SavOS" is the project heading for all packages at https://launchpad.net/~savoury1 ]

This repository provides the scripts to create the latest version of GIMP (for Ubuntu 18.04+) from https://launchpad.net/~savoury1 and the latest GIMP Developer Edition (for Ubuntu 20.04+) from https://launchpad.net/~mati75, and AppImage packages ready to be used.

Download the latest version from here:

https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous

# How to integrate GIMP AppImage into the system
The easier way is to install "AM" on your PC, see [ivan-hc/AM-application-manager](https://github.com/ivan-hc/AM-application-manager) for more.

Alternatively, you can install it this way:

    wget https://raw.githubusercontent.com/ivan-hc/AM-Application-Manager/main/programs/x86_64/gimp
    chmod a+x ./gimp
    sudo ./gimp
The AppImage will be installed in /opt/gimp as `gimp`, near other files.
### Update

    /opt/gimp/AM-updater
### Uninstall

    sudo /opt/gimp/remove
    
## GIMP Developer Edition
To install the Dev Edition, run:

    wget https://raw.githubusercontent.com/ivan-hc/AM-Application-Manager/main/programs/x86_64/gimp-dev
    chmod a+x ./gimp-dev
    sudo ./gimp-dev
### Update

    /opt/gimp-dev/AM-updater
### Uninstall

    sudo /opt/gimp-dev/remove

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

This repository provides the scripts to create the latest versions of GIMP and AppImage packages ready to be used:

- GIMP Stable is built on top of [JuNest](https://github.com/fsquillace/junest) to work on any other GNU/Linux distribution (see [ArchImage](https://github.com/ivan-hc/ArchImage));
- GIMP Developer Edition instead is built on top of Ubuntu 20.04 using a [PPA](https://launchpad.net/~mati75).

Download the latest version from here:

https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous

Browsing the repository you will find other interesting scripts you may be interested in.

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
## Transition from PPA to ArchImage
I'm planning to switch from PPA based AppImages to the new "ArchImage" model, see https://github.com/ivan-hc/GIMP-appimage/issues/10 for more details.

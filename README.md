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

## Transition from PPA to ArchImage
JuNest-based AppImages have more compatibility with much older systems. Compiling these so-called "ArchImages" is easier and the Arch Linux base is a guarantee of continuity being one of the most important GNU/Linux distributions, supported by a large community that offers more guarantees of continuity, while usually unofficial PPAs are mantained by one or two people and built as a third-party repository for Ubuntu, a distro that is more inclined to push Snaps as official packaging format instead of DEBs.

Learm more about:
- JuNest, at https://github.com/fsquillace/junest
- ArchImage, at https://github.com/ivan-hc/ArchImage

I'm switching all my PPA based AppImages to the new "ArchImage" model. (See https://github.com/ivan-hc/GIMP-appimage/issues/10 for more details).

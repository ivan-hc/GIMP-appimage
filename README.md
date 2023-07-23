This repository provides Unofficial AppImages of GIMP Stable and GIMP Developer Edition built on top of [JuNest](https://github.com/fsquillace/junest) (and other prototipes built from PPAs) and the scripts to built them.

-------------------------
### Downloads
Continuous builds based on JuNest* are released each Sunday, you can download them from:

***https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous*** 

JuNest-based AppImages have more compatibility with much older systems. 

Compiling these so-called "ArchImages" is easier and the Arch Linux base is a guarantee of continuity being one of the most important GNU/Linux distributions, supported by a large community that offers more guarantees of continuity, while usually unofficial PPAs are mantained by one or two people and built as a third-party repository for Ubuntu, a distro that is more inclined to push Snaps as official packaging format instead of DEBs.

Learn more about ArchImage packaging at https://github.com/ivan-hc/ArchImage

*****NOTE**: other pre-built Debian/Ubuntu/PPA based AppImages (released before I switched to the "ArchImage" model) are available by scrolling the page "[releases](https://github.com/ivan-hc/GIMP-appimage/releases)"***.

-------------------------
### *How to integrate GIMP AppImage into the system*
The easier way install at system level the AppImages is to use "AM", alternativelly you can use "AppMan" to install them locally and without root privileges. Learn more about:
- "AM" https://github.com/ivan-hc/AM-application-manager
- AppMan https://github.com/ivan-hc/AM-application-manager

or visit the site ***https://portable-linux-apps.github.io***

-------------------------
### *Add plugins*
For the build based on JuNest, the inbuilt command "`gimptool`" is enabled as an option. To use it:

    ./*.AppImage gimptool [options]
See "3.1 Manual installation" at https://wiki.archlinux.org/title/GIMP#Plugins

You can also manually add plugins by placing them in the appropriate directories in `$HOME/.config` and `$HOME/.local`

-------------------------
### Reduce the size of the JuNest based Appimage
You can analyze the presence of excess files inside the AppImage by extracting it:

    ./*.AppImage --appimage-extract
To start your tests, run the "AppRun" script inside the "squashfs-root" folder extracted from the AppImage:

    ./squashfs-root/AppRun

-------------------------
### *Special Credits*
- JuNest https://github.com/fsquillace/junest
- Arch Linux https://archlinux.org

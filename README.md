This repository provides Unofficial AppImages of GIMP built on top of [JuNest](https://github.com/fsquillace/junest) and the scripts to built them.

-------------------------
- [GIMP flavors: what to choose?](#gimp-flavors-what-to-choose)
  - [Stable, the one you may want the most](#stable-the-one-you-may-want-the-most)
  - [Developer Edition, for brave hearts](#developer-edition-for-brave-hearts)
  - [GIT, the daily builds](#git-the-daily-builds)
  - [Hybrid? What is this?](#hybrid-what-is-this)
- [Usage](#usage)
  - [Add plugins](#add-plugins)
- [About JuNest-based AppImages](#about-junest-based-appimages)
- [Troubleshooting](#troubleshooting)
- [About GIMP Stable for 32-bit systems](#about-gimp-stable-for-32-bit-systems)
- [Install and update them with ease](#install-and-update-them-with-ease)
- [Special credits](#special-credits)

-------------------------
# GIMP flavors: what to choose?
In this list, you will learn more about the four main builds available in this repository.

--------------------------
## Stable, the one you may want the most
GIMP "Stable" is the basic version built from the official Arch Linux repositorie (see https://archlinux.org/packages/extra/x86_64/gimp ).

If you have doubts about which one to use, I recommend you download this one.

#### Download it using the tags [continuous-stable](https://github.com/ivan-hc/GIMP-appimage/tree/continuous-stable) and [latest](https://github.com/ivan-hc/GIMP-appimage/releases/latest):
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-stable
- https://github.com/ivan-hc/GIMP-appimage/releases/latest

---------------------------

## Developer Edition, for brave hearts
GIMP "Dev" is the upcoming version with all latest features and port to the more recent technologies. 

To build this AppImage I've used the package "gimp-devel" from the Arch User Repository "AUR" (see https://aur.archlinux.org/packages/gimp-devel).

#### Download it using the tag [continuous-dev](https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-dev):
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-dev

---------------------------

## GIT, the daily builds
GIMP "GIT" is built from source using the AUR package "gimp-git" (see https://aur.archlinux.org/packages/gimp-git). Every feature, even experimental, comes from source code, which may cause instability.

#### Download it using the tag [continuous-git](https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-git):
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-git

-------------------------- 
## Hybrid? What is this?
GIMP "Hybrid" is based on the "Stable" version mentioned above, but in addition will contain support for the old Python2 and many third-party plugins. 

As it stands, now it seems to be like a more bloated build and doesn't have much to offer. In fact, it's still a work in progress.

If you are a GIMP fanatic user, you will be able to rely on this build in the future when it is ready, but until then rely on the official Flatpak which already has everything you are looking for. 

This build is extremely experimental. **USE AT YOUR OWN RISK!**

#### If you really want it, download it using the tag [continuous-hybrid](https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-hybrid)
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-hybrid

--------------------------
# Usage
Once you have downloaded the AppImage, made it executable:
```
chmod a+x ./*.AppImage
```
Now you can double-click it or run it from the terminal (which lets you use hidden options).

### Add plugins
For the **Stable** and **Dev Edition** builds based on JuNest, the inbuilt command "`gimptool`" is enabled as an option. To use it:
```
./*.AppImage gimptool [options]
```
You can also manually add plugins by placing them in the appropriate directories in `$HOME/.config/GIMP`. 

See "3.1 Manual installation" at https://wiki.archlinux.org/title/GIMP#Plugins for more details.

“**Hybrid**” on the other hand is a work in progress that will be experimentally patched to contain all available plugins.

----------------------------
# About JuNest-based AppImages
[JuNest](https://github.com/fsquillace/junest) (Jailed User Nest) is a lightweight Arch Linux based distribution that allows the creation of disposable and partially isolated GNU/Linux environments within any generic GNU/Linux host OS and without requiring root privileges to install packages.

JuNest-based AppImages have more compatibility with much older systems. 

Compiling these so-called "ArchImages" is easier and the Arch Linux base is a guarantee of continuity being it one of the most important GNU/Linux distributions, supported by a large community that offers more guarantees of continuity, as opposed to those based on PPA (which I stopped developing).

Learn more about ArchImage packaging at https://github.com/ivan-hc/ArchImage

-------------------------
# Troubleshooting
You can analyze the AppImage by extracting them:
```
./*.AppImage --appimage-extract
```
edit the file ./squashfs-root/AppRun with your favourite text editor and remove the string `2> /dev/null`. Save the file.

To start your tests, run the "AppRun" script like this:
```
./squashfs-root/AppRun
```
you can also rely on LD_DEBUG to find errors (learn more at https://www.bnikolic.co.uk/blog/linux-ld-debug.html), for example, look for missing libraries:
```
LD_DEBUG=libs ./squashfs-root/AppRun
```

---------------------------------
# About GIMP Stable for 32-bit systems
I have also developed a 32-bit version of GIMP Stable built from the official Debian Stable repositories, for the old i386 architectures, see my other repository "[ivan-hc/32-bit-AppImage-packages-database](https://github.com/ivan-hc/32-bit-AppImage-packages-database)", you can download it from [here](https://github.com/ivan-hc/32-bit-AppImage-packages-database/releases/tag/gimp).

----------------------------------
# Install and update them with ease

I wrote two bash scripts to install and manage the applications: [AM](https://github.com/ivan-hc/AM-Application-Manager) and [AppMan](https://github.com/ivan-hc/AppMan). Their dual existence is based on the needs of the end user.

| [**"AM" Application Manager**](https://github.com/ivan-hc/AM-Application-Manager) |
| -- |
| <sub>***If you want to install system-wide applications on your GNU/Linux distribution in a way that is compatible with [Linux Standard Base](https://refspecs.linuxfoundation.org/lsb.shtml) (all third-party apps must be installed in dedicated directories under `/opt` and their launchers and binaries in `/usr/local/*` ...), just use ["AM" Application Manager](https://github.com/ivan-hc/AM-Application-Manager). This app manager requires root privileges only to install / remove applications, the main advantage of this type of installation is that the same applications will be available to all users of the system.***</sub>
[![Readme](https://img.shields.io/github/stars/ivan-hc/AM-Application-Manager?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AM-Application-Manager/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AM-Application-Manager?label=&style=for-the-badge)](https://github.com/ivan-hc/AM-Application-Manager/blob/main/LICENSE)

| [**"AppMan"**](https://github.com/ivan-hc/AppMan)
| --
| <sub>***If you don't want to put your app manager in a specific path but want to use it portable and want to install / update / manage all your apps locally, download ["AppMan"](https://github.com/ivan-hc/AppMan) instead. With this script you will be able to decide where to install your applications (at the expense of a greater consumption of resources if the system is used by more users). AppMan is portable, all you have to do is write the name of a folder in your `$HOME` where you can install all the applications available in [the "AM" database](https://github.com/ivan-hc/AM-Application-Manager/tree/main/programs), and without root privileges.***</sub>
[![Readme](https://img.shields.io/github/stars/ivan-hc/AppMan?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AppMan/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AppMan?label=&style=for-the-badge)](https://github.com/ivan-hc/AppMan/blob/main/LICENSE)

-------------------------
# Special Credits
- JuNest https://github.com/fsquillace/junest
- Arch Linux https://archlinux.org

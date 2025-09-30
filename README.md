This repository provides Unofficial AppImages of GIMP built on top of [JuNest](https://github.com/fsquillace/junest) and the scripts to built them.

### If you are looking for the Official AppImage, see https://www.gimp.org/downloads

That said, consider this repository as a "fallback".

-------------------------
- [GIMP flavors: what to choose?](#gimp-flavors-what-to-choose)
  - [1. Stable, the one you may want the most](#1-stable-the-one-you-may-want-the-most)
  - [2. GIT, the daily builds](#2-git-the-daily-builds)
  - [3. Hybrid? What is this?](#3-hybrid-what-is-this)
- [Usage](#usage)
  - [Add plugins](#add-plugins)
- [About JuNest-based AppImages](#about-junest-based-appimages)
- [Troubleshooting](#troubleshooting)
- [About GIMP Stable for 32-bit systems](#about-gimp-stable-for-32-bit-systems)
- [Install and update them all with ease](#install-and-update-them-all-with-ease)
- [Special credits](#special-credits)

-------------------------
# GIMP flavors: what to choose?
In this list, you will learn more about the three kinds of builds available in this repository.

--------------------------
## 1. Stable, the one you may want the most
GIMP "Stable" is the basic version built from the official Arch Linux repositorie (see https://archlinux.org/packages/extra/x86_64/gimp ).

If you have doubts about which one to use, I recommend you download this one.

#### Download it using the tags [continuous-stable](https://github.com/ivan-hc/GIMP-appimage/tree/continuous-stable) and [latest](https://github.com/ivan-hc/GIMP-appimage/releases/latest):
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-stable
- https://github.com/ivan-hc/GIMP-appimage/releases/latest

The build is updated every Sunday.

---------------------------

## 2. GIT, the daily builds
GIMP "GIT" is built from the "gimp-git" package on repo.archlinuxcn.org (see https://repo.archlinuxcn.org/x86_64). Formerly it was compiled from source using the AUR package "gimp-git" (at https://aur.archlinux.org/packages/gimp-git), but since the latter is not constantly maintained and susceptible to failures (about 30 minutes of compilation and then failure, for weeks or months) I decided to switch to the package from the aforementioned repositories, on September 2024.

Every feature, even experimental, comes from source code, which may cause instability.

#### Download it using the tag [continuous-git](https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-git):
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-git

The build is updated every day.

-------------------------- 
## 3. Hybrid? What is this?
GIMP "Hybrid" is a snapshot of GIMP 2.10.38. In addition will contain support for the old Python2 and many third-party plugins. 

To check the patches used, see [Plugins patches for the "Hybrid" release](https://github.com/ivan-hc/GIMP-appimage/releases/tag/gimp-plugins-patches-for-the-hybrid-release).

"Hybrid" Is still a work in progress for GIMP fanatics!

This build is extremely experimental. **USE AT YOUR OWN RISK!**

#### If you really want use "Hybrid", download it using the tag [continuous-hybrid](https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-hybrid)
- https://github.com/ivan-hc/GIMP-appimage/releases/tag/continuous-hybrid

Being a release based on a specific fixed version, the (monthly) updates will be symbolic (to keep the release on top, with the others) and aimed at implementing improvements only.

--------------------------
# Usage
Once you have downloaded the AppImage, made it executable:
```
chmod a+x ./*.AppImage
```
Now you can double-click it or run it from the terminal (which lets you use hidden options).

### Add plugins
For the **Stable** and **GIT** builds based on JuNest, the inbuilt command "`gimptool`" is enabled as an option. To use it:
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

------------------------------------------------------------------------

## Install and update them all with ease

### *"*AM*" Application Manager* 
#### *Package manager, database & solutions for all AppImages and portable apps for GNU/Linux!*

[![Istantanea_2024-06-26_17-00-46 png](https://github.com/ivan-hc/AM/assets/88724353/671f5eb0-6fb6-4392-b45e-af0ea9271d9b)](https://github.com/ivan-hc/AM)

[![Readme](https://img.shields.io/github/stars/ivan-hc/AM?label=%E2%AD%90&style=for-the-badge)](https://github.com/ivan-hc/AM/stargazers) [![Readme](https://img.shields.io/github/license/ivan-hc/AM?label=&style=for-the-badge)](https://github.com/ivan-hc/AM/blob/main/LICENSE)

*"AM"/"AppMan" is a set of scripts and modules for installing, updating, and managing AppImage packages and other portable formats, in the same way that APT manages DEBs packages, DNF the RPMs, and so on... using a large database of Shell scripts inspired by the Arch User Repository, each dedicated to an app or set of applications.*

*The engine of "AM"/"AppMan" is the "APP-MANAGER" script which, depending on how you install or rename it, allows you to install apps system-wide (for a single system administrator) or locally (for each user).*

*"AM"/"AppMan" aims to be the default package manager for all AppImage packages, giving them a home to stay.*

*You can consult the entire **list of managed apps** at [**portable-linux-apps.github.io/apps**](https://portable-linux-apps.github.io/apps).*

## *Go to *https://github.com/ivan-hc/AM* for more!*

------------------------------------------------------------------------

| [***Install "AM"***](https://github.com/ivan-hc/AM) | [***See all available apps***](https://portable-linux-apps.github.io) | [***Support me on ko-fi.com***](https://ko-fi.com/IvanAlexHC) | [***Support me on PayPal.me***](https://paypal.me/IvanAlexHC) |
| - | - | - | - |

------------------------------------------------------------------------
# Special Credits
- JuNest https://github.com/fsquillace/junest
- Arch Linux https://archlinux.org

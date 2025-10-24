#!/usr/bin/env bash

APP=gimp
BIN="$APP" #CHANGE THIS IF THE NAME OF THE BINARY IS DIFFERENT FROM "$APP" (for example, the binary of "obs-studio" is "obs")
DEPENDENCES="adwaita-icon-theme ffmpeg graphviz mypaint mypaint-brushes python python-cairo python-gobject sdl2" #SYNTAX: "APP1 APP2 APP3 APP4...", LEAVE BLANK IF NO OTHER DEPENDENCIES ARE NEEDED
#BASICSTUFF="binutils debugedit gzip"
#COMPILERS="base-devel"

#############################################################################
#	KEYWORDS TO FIND AND SAVE WHEN COMPILING THE APPIMAGE
#############################################################################

BINSAVED="fc- gdb mypaint"
SHARESAVED="xml mypaint"
#lib_audio_keywords="alsa jack pipewire pulse"
lib_browser_launcher="gio-launch-desktop libasound.so libatk-bridge libatspi libcloudproviders libdb- libdl.so libedit libepoxy libgtk-3.so.0 libjson-glib libnssutil libpthread.so librt.so libtinysparql libwayland-cursor libX11-xcb.so libxapp-gtk3-module.so libXcursor libXdamage libXi.so libxkbfile.so libXrandr p11 pk"
LIBSAVED="gdk-pixbuf libjson libsoxr.so libuuid.so libSDL libsodium.so pixmap tinysparql girepository mypaint \
libpulsecommon libnsl libFLAC libutil.so \
$lib_audio_keywords $lib_browser_launcher"

[ -n "$lib_browser_launcher" ] && DEPENDENCES="$DEPENDENCES xapp hicolor-icon-theme"

#############################################################################
#	SETUP THE ENVIRONMENT
#############################################################################

# Download appimagetool
if [ ! -f ./appimagetool ]; then
	echo "-----------------------------------------------------------------------------"
	echo "◆ Downloading \"appimagetool\" from https://github.com/AppImage/appimagetool"
	echo "-----------------------------------------------------------------------------"
	curl -#Lo appimagetool https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-x86_64.AppImage && chmod a+x appimagetool
fi

# Create and enter the AppDir
mkdir -p "$APP".AppDir archlinux && cd archlinux || exit 1

# Set archlinux as a temporary $HOME directory
HOME="$(dirname "$(readlink -f "$0")")"

#############################################################################
#	DOWNLOAD, INSTALL AND CONFIGURE JUNEST
#############################################################################

_enable_multilib() {
	printf "\n[multilib]\nInclude = /etc/pacman.d/mirrorlist" >> ./.junest/etc/pacman.conf
}

_enable_chaoticaur() {
	# This function is ment to be used during the installation of JuNest, see "_pacman_patches"
	./.local/share/junest/bin/junest -- sudo pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
	./.local/share/junest/bin/junest -- sudo pacman-key --lsign-key 3056513887B78AEB
	./.local/share/junest/bin/junest -- sudo pacman-key --populate chaotic
	./.local/share/junest/bin/junest -- sudo pacman --noconfirm -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
	printf "\n[chaotic-aur]\nInclude = /etc/pacman.d/chaotic-mirrorlist" >> ./.junest/etc/pacman.conf
}

_custom_mirrorlist() {
	echo "Server=https://archive.archlinux.org/repos/2025/03/17/\$repo/os/\$arch" > ./.junest/etc/pacman.d/mirrorlist
}

_bypass_signature_check_level() {
	sed -i 's/#SigLevel/SigLevel/g; s/Required DatabaseOptional/Never/g' ./.junest/etc/pacman.conf
}

_install_junest() {
	echo "-----------------------------------------------------------------------------"
	echo "◆ Clone JuNest from https://github.com/ivan-hc/junest"
	echo "-----------------------------------------------------------------------------"
	git clone https://github.com/ivan-hc/junest.git ./.local/share/junest
	echo "-----------------------------------------------------------------------------"
	echo "◆ Downloading JuNest archive from https://github.com/ivan-hc/junest"
	echo "-----------------------------------------------------------------------------"
	curl -#Lo junest-x86_64.tar.gz https://github.com/ivan-hc/junest/releases/download/20250317/junest-x86_64.tar.gz
	./.local/share/junest/bin/junest setup -i junest-x86_64.tar.gz
	rm -f junest-x86_64.tar.gz
	echo " Apply patches to PacMan..."
	#_enable_multilib
	#_enable_chaoticaur
	_custom_mirrorlist
	_bypass_signature_check_level

	# Update arch linux in junest
	./.local/share/junest/bin/junest -- sudo pacman -Syy
	./.local/share/junest/bin/junest -- sudo pacman --noconfirm -Syu
}

if ! test -d "$HOME/.local/share/junest"; then
	echo "-----------------------------------------------------------------------------"
	echo " DOWNLOAD, INSTALL AND CONFIGURE JUNEST"
	echo "-----------------------------------------------------------------------------"
	_install_junest
else
	echo "-----------------------------------------------------------------------------"
	echo " RESTART JUNEST"
	echo "-----------------------------------------------------------------------------"
fi

#############################################################################
#	INSTALL PROGRAMS USING YAY
#############################################################################

./.local/share/junest/bin/junest -- yay -Syy
#./.local/share/junest/bin/junest -- gpg --keyserver keyserver.ubuntu.com --recv-key C01E1CAD5EA2C4F0B8E3571504C367C218ADD4FF # UNCOMMENT IF YOU USE THE AUR
if [ -n "$BASICSTUFF" ]; then
	./.local/share/junest/bin/junest -- yay --noconfirm -S "$BASICSTUFF"
fi
if [ -n "$COMPILERS" ]; then
	./.local/share/junest/bin/junest -- yay --noconfirm -S "$COMPILERS"
fi
if [ -n "$DEPENDENCES" ]; then
	./.local/share/junest/bin/junest -- yay --noconfirm -S $DEPENDENCES
fi
if [ -n "$APP" ]; then
	./.local/share/junest/bin/junest -- yay --noconfirm -S alsa-lib gtk3 xapp
	./.local/share/junest/bin/junest -- yay --noconfirm -S "$APP"
	./.local/share/junest/bin/junest -- glib-compile-schemas /usr/share/glib-2.0/schemas/
else
	echo "No app found, exiting"; exit 1
fi

cd ..

echo ""
echo "-----------------------------------------------------------------------------"
echo " CREATING THE APPDIR"
echo "-----------------------------------------------------------------------------"
echo ""

# Set locale
rm -f archlinux/.junest/etc/locale.conf
sed -i 's/LANG=${LANG:-C}/LANG=$LANG/g' archlinux/.junest/etc/profile.d/locale.sh

# Add launcher and icon
rm -f ./*.desktop
LAUNCHER=$(grep -iRl "$BIN" archlinux/.junest/usr/share/applications/* | grep ".desktop" | head -1)
cp -r "$LAUNCHER" "$APP".AppDir/
ICON=$(cat "$LAUNCHER" | grep "Icon=" | cut -c 6-)
[ -z "$ICON" ] && ICON="$BIN"
cp -r archlinux/.junest/usr/share/icons/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/22x22/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/24x24/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/32x32/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/48x48/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/64x64/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/128x128/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/192x192/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/256x256/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/512x512/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/icons/hicolor/scalable/apps/*"$ICON"* "$APP".AppDir/ 2>/dev/null
cp -r archlinux/.junest/usr/share/pixmaps/*"$ICON"* "$APP".AppDir/ 2>/dev/null

# Test if the desktop file and the icon are in the root of the future appimage (./*appdir/*)
if test -f "$APP".AppDir/*.desktop; then
	echo "◆ The .desktop file is available in $APP.AppDir/"
elif test -f archlinux/.junest/usr/bin/"$BIN"; then
 	echo "◆ No .desktop file available for $APP, creating a new one"
 	cat <<-HEREDOC >> "$APP".AppDir/"$APP".desktop
	[Desktop Entry]
	Version=1.0
	Type=Application
	Name=$(echo "$APP" | tr '[:lower:]' '[:upper:]')
	Comment=
	Exec=$BIN
	Icon=tux
	Categories=Utility;
	Terminal=true
	StartupNotify=true
	HEREDOC
	curl -Lo "$APP".AppDir/tux.png https://raw.githubusercontent.com/Portable-Linux-Apps/Portable-Linux-Apps.github.io/main/favicon.ico 2>/dev/null
else
	echo "No binary in path... aborting all the processes."
	exit 0
fi

if [ ! -d "$APP".AppDir/.local ]; then
	mkdir -p "$APP".AppDir/.local
	rsync -av archlinux/.local/ "$APP".AppDir/.local/ | echo "◆ Rsync .local directory to the AppDir"
	cat "$APP".AppDir/.local/share/junest/lib/core/wrappers.patch > "$APP".AppDir/.local/share/junest/lib/core/wrappers.sh
	cat "$APP".AppDir/.local/share/junest/lib/core/namespace.patch > "$APP".AppDir/.local/share/junest/lib/core/namespace.sh
fi

echo "◆ Rsync .junest directories structure to the AppDir"
rm -Rf "$APP".AppDir/.junest/*
archdirs=$(find archlinux/.junest -type d | sed 's/^archlinux\///g')
for d in $archdirs; do
	mkdir -p "$APP".AppDir/"$d"
done
symlink_dirs=" bin sbin lib lib64 usr/sbin usr/lib64"
for l in $symlink_dirs; do
	cp -r archlinux/.junest/"$l" "$APP".AppDir/.junest/"$l"
done

rsync -av archlinux/.junest/usr/bin_wrappers/ "$APP".AppDir/.junest/usr/bin_wrappers/ | echo "◆ Rsync bin_wrappers to the AppDir"
rsync -av archlinux/.junest/etc/* "$APP".AppDir/.junest/etc/ | echo "◆ Rsync /etc"

#############################################################################
#	APPRUN
#############################################################################

rm -f "$APP".AppDir/AppRun
cat <<-'HEREDOC' >> "$APP".AppDir/AppRun
#!/bin/sh
HERE="$(dirname "$(readlink -f "$0")")"
export JUNEST_HOME="$HERE"/.junest

CACHEDIR="${XDG_CACHE_HOME:-$HOME/.cache}"
mkdir -p "$CACHEDIR" || exit 1

if command -v unshare >/dev/null 2>&1 && ! unshare --user -p /bin/true >/dev/null 2>&1; then
   PROOT_ON=1 && export PATH="$HERE"/.local/share/junest/bin/:"$PATH"
else
   export PATH="$PATH":"$HERE"/.local/share/junest/bin
fi

[ -z "$NVIDIA_ON" ] && NVIDIA_ON=0
if [ -f /sys/module/nvidia/version ] && [ "$NVIDIA_ON" = 1 ]; then
   nvidia_driver_version="$(cat /sys/module/nvidia/version)"
   JUNEST_DIRS="${CACHEDIR}/junest_shared/usr" JUNEST_LIBS="${JUNEST_DIRS}/lib" JUNEST_NVIDIA_DATA="${JUNEST_DIRS}/share/nvidia"
   mkdir -p "${JUNEST_LIBS}" "${JUNEST_NVIDIA_DATA}" || exit 1
   [ ! -f "${JUNEST_NVIDIA_DATA}"/current-nvidia-version ] && echo "${nvidia_driver_version}" > "${JUNEST_NVIDIA_DATA}"/current-nvidia-version
   [ -f "${JUNEST_NVIDIA_DATA}"/current-nvidia-version ] && nvidia_driver_conty=$(cat "${JUNEST_NVIDIA_DATA}"/current-nvidia-version)
   if [ "${nvidia_driver_version}" != "${nvidia_driver_conty}" ]; then
      rm -f "${JUNEST_LIBS}"/*; echo "${nvidia_driver_version}" > "${JUNEST_NVIDIA_DATA}"/current-nvidia-version
   fi
   HOST_LIBS=$(/sbin/ldconfig -p)
   libnvidia_libs=$(echo "$HOST_LIBS" | grep -i "nvidia\|libcuda" | cut -d ">" -f 2)
   libvdpau_nvidia=$(find /usr/lib -type f -name 'libvdpau_nvidia.so*' -print -quit 2>/dev/null | head -1)
   libnv_paths=$(echo "$HOST_LIBS" | grep "libnv" | cut -d ">" -f 2)
   for f in $libnv_paths; do strings "${f}" | grep -qi -m 1 "nvidia" && libnv_libs="$libnv_libs ${f}"; done
   host_nvidia_libs=$(echo "$libnv_libs $libnvidia_libs $libvdpau_nvidia" | sed 's/ /\n/g' | sort | grep .)
   for n in $host_nvidia_libs; do libname=$(echo "$n" | sed 's:.*/::') && [ ! -f "${JUNEST_LIBS}"/"$libname" ] && cp "$n" "${JUNEST_LIBS}"/; done
   libvdpau="${JUNEST_LIBS}/libvdpau_nvidia.so"
   [ -f "${libvdpau}"."${nvidia_driver_version}" ] && [ ! -f "${libvdpau}" ] && ln -s "${libvdpau}"."${nvidia_driver_version}" "${libvdpau}"
   export LD_LIBRARY_PATH="${LD_LIBRARY_PATH}":"${JUNEST_LIBS}":"${LD_LIBRARY_PATH}"
fi

bind_files="/etc/resolv.conf /etc/hosts /etc/nsswitch.conf /etc/passwd /etc/group /etc/machine-id /etc/asound.conf /etc/localtime "
bind_nvidia_data_dirs="/usr/share/egl /usr/share/glvnd /usr/share/nvidia /usr/share/vulkan"
bind_dirs=" /media /mnt /opt /run/media /usr/lib/locale /usr/share/fonts /usr/share/themes /var $bind_nvidia_data_dirs"
if [ "$PROOT_ON" = 1 ]; then
   for f in $bind_files; do [ -f "$f" ] && BINDINGS=" $BINDINGS --bind=$f"; done
   for d in $bind_dirs; do [ -d "$d" ] && BINDINGS=" $BINDINGS --bind=$d"; done
   junest_options="proot -n -b"
   junest_bindings=" --bind=/dev --bind=/sys --bind=/tmp --bind=/proc $BINDINGS --bind=/home --bind=/home/$USER "
else
   for f in $bind_files; do [ -f "$f" ] && BINDINGS=" $BINDINGS --ro-bind-try $f $f"; done
   for d in $bind_dirs; do [ -d "$d" ] && BINDINGS=" $BINDINGS --bind-try $d $d"; done
   junest_options="-n -b"
   junest_bindings=" --dev-bind /dev /dev --ro-bind /sys /sys --bind-try /tmp /tmp --proc /proc $BINDINGS --cap-add CAP_SYS_ADMIN "
fi

_JUNEST_CMD() {
   "$HERE"/.local/share/junest/bin/junest $junest_options "$junest_bindings" "$@"
}

EXEC=$(grep -e '^Exec=.*' "${HERE}"/*.desktop | head -n 1 | cut -d "=" -f 2- | sed -e 's|%.||g')

case "$1" in
	gimptool) _JUNEST_CMD -- /usr/bin/gimptool "$@";;
	*) _JUNEST_CMD -- /usr/bin/gimp "$@";;
esac

HEREDOC
chmod a+x "$APP".AppDir/AppRun

#############################################################################
#	EXTRACT PACKAGES
#############################################################################

[ -z "$extraction_count" ] && extraction_count=0
[ ! -f ./autodeps ] && echo "$extraction_count" > ./autodeps
[ -f ./autodeps ] && autodeps=$(cat ./autodeps)
[ "$autodeps" != "$extraction_count" ] && rm -Rf ./deps ./packages && echo "$extraction_count" > ./autodeps

[ ! -f ./userdeps ] && echo "$DEPENDENCES" > ./userdeps
[ -f ./userdeps ] && userdeps=$(cat ./userdeps)
[ "$userdeps" != "$DEPENDENCES" ] && rm -Rf ./deps ./packages && echo "$DEPENDENCES" > ./userdeps

_extract_main_package() {
	mkdir -p base
	rm -Rf ./base/*
	pkg_full_path=$(find ./archlinux -type f -name "$APP-*zst")
	if [ "$(echo "$pkg_full_path" | wc -l)" = 1 ]; then
		pkg_full_path=$(find ./archlinux -type f -name "$APP-*zst")
	else
		for p in $pkg_full_path; do
			if tar fx "$p" .PKGINFO -O | grep -q "pkgname = $APP$"; then
				pkg_full_path="$p"
			fi
		done
	fi
	[ -z "$pkg_full_path" ] && echo "💀 ERROR: no package found for \"$APP\", operation aborted!" && exit 0
	tar fx "$pkg_full_path" -C ./base/
	VERSION=$(cat ./base/.PKGINFO | grep pkgver | cut -c 10- | sed 's@.*:@@')
	mkdir -p deps
}

_download_missing_packages() {
	localpackage=$(find ./archlinux -name "$arg-[0-9]*zst")
	if ! test -f "$localpackage"; then
		./archlinux/.local/share/junest/bin/junest -- yay --noconfirm -Sw "$arg"
	fi
}

_extract_package() {
	_download_missing_packages &> /dev/null
	pkg_full_path=$(find ./archlinux -name "$arg-[0-9]*zst")
	pkgname=$(echo "$pkg_full_path" | sed 's:.*/::')
	[ ! -f ./packages ] && rm -Rf ./deps/* && touch ./packages
	if [ -z "$( ls -A './deps' )" ]; then
		rm -f ./packages
		echo ""
		echo "-----------------------------------------------------------------------------"
		echo " EXTRACTING PACKAGES"
		echo "-----------------------------------------------------------------------------"
		echo ""
	fi
	if test -f "$pkg_full_path"; then
		if ! grep -q "$pkgname" ./packages 2>/dev/null;then
			echo "◆ Extracting $pkgname"
			tar fx "$pkg_full_path" -C ./deps/ --warning=no-unknown-keyword
			echo "$pkgname" >> ./packages
		fi
		[ -n "$lib_browser_launcher" ] && [[ "$arg" =~ (adwaita-icon-theme|babl|cairo|gegl|gjs|hicolor-icon-theme|python|python-cairo|python-gobject|xapp) ]] && tar fx "$pkg_full_path" -C ./base/ --warning=no-unknown-keyword --exclude='.PKGINFO'
	fi
}

_determine_packages_and_libraries() {
	if echo "$arg" | grep -q "\.so"; then
		LIBSAVED="$LIBSAVED $arg"
	elif [[ "$arg" != fuse* ]] && [ "$arg" != autoconf ] && [ "$arg" != autoconf ] && [ "$arg" != automake ] && [ "$arg" != bison ] && [ "$arg" != debugedit ] && [ "$arg" != dkms ] && [ "$arg" != fakeroot ] && [ "$arg" != flatpak ] && [ "$arg" != linux ] && [ "$arg" != gcc ] && [ "$arg" != make ] && [ "$arg" != pacman ] && [ "$arg" != patch ] && [ "$arg" != systemd ]; then
		_extract_package
		cat ./deps/.PKGINFO 2>/dev/null | grep "^depend = " | cut -c 10- | sed 's/=.*//' >> depdeps
		rm -f ./deps/.*
	fi
}

_extract_deps() {
	DEPS=$(sort -u ./depdeps)
	for arg in $DEPS; do
		_determine_packages_and_libraries
	done
}

_extract_all_dependences() {
	rm -f ./depdeps

	OPTDEPS=$(cat ./base/.PKGINFO 2>/dev/null | grep "^optdepend = " | sed 's/optdepend = //g' | sed 's/=.*//' | sed 's/:.*//')
	for arg in $OPTDEPS; do
		_determine_packages_and_libraries
	done
	[ -f ./depdeps ] && _extract_deps
	rm -f ./depdeps

	ARGS=$(echo "$DEPENDENCES" | tr " " "\n")
	for arg in $ARGS; do
		_determine_packages_and_libraries
	done

	DEPS=$(cat ./base/.PKGINFO 2>/dev/null | grep "^depend = " | sed 's/depend = //g' | sed 's/=.*//')
	for arg in $DEPS; do
		_determine_packages_and_libraries
	done

	# Set the level of sub-dependencies extraction, the higher the number, the bigger the AppImage will be
	if [ "$extraction_count" != 0 ]; then
		for e in $(seq "$extraction_count"); do _extract_deps; done
	fi
}

_extract_main_package
_extract_all_dependences

echo ""
echo "-----------------------------------------------------------------------------"
echo " IMPLEMENTING NECESSARY LIBRARIES (MAY TAKE SEVERAL MINUTES)"
echo "-----------------------------------------------------------------------------"
echo ""

# Save files in /usr/bin
_savebins() {
	echo "◆ Saving files in /usr/bin"
	cp -r ./archlinux/.junest/usr/bin/bwrap ./"$APP".AppDir/.junest/usr/bin/
	cp -r ./archlinux/.junest/usr/bin/proot* ./"$APP".AppDir/.junest/usr/bin/
	cp -r ./archlinux/.junest/usr/bin/*$BIN* ./"$APP".AppDir/.junest/usr/bin/
	coreutils="[ basename cat chmod chown cp cut dir dirname du echo env expand expr fold head id ln ls mkdir mv readlink realpath rm rmdir seq sleep sort stty sum sync tac tail tee test timeout touch tr true tty uname uniq wc who whoami yes"
	utils_bin="awk bash $coreutils gawk gio grep ld ldd sed sh strings xdg-open"
	for b in $utils_bin; do
 		cp -r ./archlinux/.junest/usr/bin/"$b" ./"$APP".AppDir/.junest/usr/bin/
   	done
	for arg in $BINSAVED; do
		cp -r ./archlinux/.junest/usr/bin/*"$arg"* ./"$APP".AppDir/.junest/usr/bin/
	done
}

# Save files in /usr/lib
_savelibs() {
	echo "◆ Detect libraries related to /usr/bin files"
	libs4bin=$(readelf -d ./"$APP".AppDir/.junest/usr/bin/* 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so")

	echo "◆ Saving JuNest core libraries"
	cp -r ./archlinux/.junest/usr/lib/ld-linux-x86-64.so* ./"$APP".AppDir/.junest/usr/lib/
	lib_preset="$APP $BIN gconv libdw libelf libresolv.so libtinfo.so $libs4bin"
	LIBSAVED="$lib_preset $LIBSAVED $SHARESAVED"
	for arg in $LIBSAVED; do
		LIBPATHS="$LIBPATHS $(find ./archlinux/.junest/usr/lib -maxdepth 20 -wholename "*$arg*" | sed 's/\.\/archlinux\///g')"
	done
	for arg in $LIBPATHS; do
		[ ! -d "$APP".AppDir/"$arg" ] && cp -r ./archlinux/"$arg" "$APP".AppDir/"$arg" &
	done
	wait
	core_libs=$(find ./"$APP".AppDir -type f)
	lib_core=$(for c in $core_libs; do readelf -d "$c" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)

	echo "◆ Detect libraries of the main package"
	base_libs=$(find ./base -type f | uniq)
	lib_base_0=$(for b in $base_libs; do readelf -d "$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)

	echo "◆ Detect libraries of the dependencies"
	dep_libs=$(find ./deps -executable -name "*.so*")
	lib_deps=$(for d in $dep_libs; do readelf -d "$d" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)

	echo "◆ Detect and copy base libs"
	basebin_libs=$(find ./base -executable -name "*.so*")
	lib_base_1=$(for b in $basebin_libs; do readelf -d "$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_1=$(echo "$lib_base_1" | tr ' ' '\n' | sort -u | xargs)
	lib_base_2=$(for b in $lib_base_1; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_2=$(echo "$lib_base_2" | tr ' ' '\n' | sort -u | xargs)
	lib_base_3=$(for b in $lib_base_2; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_3=$(echo "$lib_base_3" | tr ' ' '\n' | sort -u | xargs)
	lib_base_4=$(for b in $lib_base_3; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_4=$(echo "$lib_base_4" | tr ' ' '\n' | sort -u | xargs)
	lib_base_5=$(for b in $lib_base_4; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_5=$(echo "$lib_base_5" | tr ' ' '\n' | sort -u | xargs)
	lib_base_6=$(for b in $lib_base_5; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_6=$(echo "$lib_base_6" | tr ' ' '\n' | sort -u | xargs)
	lib_base_7=$(for b in $lib_base_6; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_7=$(echo "$lib_base_7" | tr ' ' '\n' | sort -u | xargs)
	lib_base_8=$(for b in $lib_base_7; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_8=$(echo "$lib_base_8" | tr ' ' '\n' | sort -u | xargs)
	lib_base_9=$(for b in $lib_base_8; do readelf -d ./archlinux/.junest/usr/lib/"$b" 2>/dev/null | grep NEEDED | tr '[] ' '\n' | grep ".so"; done)
	lib_base_9=$(echo "$lib_base_9" | tr ' ' '\n' | sort -u | xargs)
	lib_base_libs="$lib_core $lib_base_0 $lib_base_1 $lib_base_2 $lib_base_3 $lib_base_4 $lib_base_5 $lib_base_6 $lib_base_7 $lib_base_8 $lib_base_9 $lib_deps"
	lib_base_libs=$(echo "$lib_base_libs" | tr ' ' '\n' | sort -u | sed 's/.so.*/.so/' | xargs)
	for l in $lib_base_libs; do
		rsync -av ./archlinux/.junest/usr/lib/"$l"* ./"$APP".AppDir/.junest/usr/lib/ &
	done
	wait
	for l in $lib_base_libs; do
		rsync -av ./deps/usr/lib/"$l"* ./"$APP".AppDir/.junest/usr/lib/ &
	done
	wait
}

# Save files in /usr/share
_saveshare() {
	echo "◆ Saving directories in /usr/share"
	SHARESAVED="$SHARESAVED $APP $BIN fontconfig glib- locale mime wayland X11"
	for arg in $SHARESAVED; do
		cp -r ./archlinux/.junest/usr/share/*"$arg"* ./"$APP".AppDir/.junest/usr/share/
 	done
}

_savebins 2>/dev/null
_savelibs 2>/dev/null
_saveshare 2>/dev/null

echo ""
echo "-----------------------------------------------------------------------------"
echo " ASSEMBLING THE APPIMAGE"
echo "-----------------------------------------------------------------------------"
echo ""

_rsync_main_package() {
	rm -Rf ./base/.*
	rsync -av ./base/ ./"$APP".AppDir/.junest/ | echo "◆ Rsync the content of the \"$APP\" package"
}

_rsync_dependences() {
	rm -Rf ./deps/.*
	chmod -R 777 ./deps/*
	#rsync -av ./deps/ ./"$APP".AppDir/.junest/ | echo "◆ Rsync all dependencies, please wait"
}

_rsync_main_package
_rsync_dependences

#############################################################################
#	REMOVE BLOATWARES, ENABLE MOUNTPOINTS
#############################################################################

_remove_more_bloatwares() {
	etc_remove="makepkg.conf pacman"
	for r in $etc_remove; do
		rm -Rf ./"$APP".AppDir/.junest/etc/"$r"*
	done
	bin_remove="gcc"
	for r in $bin_remove; do
		rm -Rf ./"$APP".AppDir/.junest/usr/bin/"$r"*
	done
	lib_remove="gcc"
	for r in $lib_remove; do
		rm -Rf ./"$APP".AppDir/.junest/usr/lib/"$r"*
	done
	share_remove="gcc"
	for r in $share_remove; do
		rm -Rf ./"$APP".AppDir/.junest/usr/share/"$r"*
	done
	echo Y | rm -Rf ./"$APP".AppDir/.cache/yay/*
	find ./"$APP".AppDir/.junest/usr/share/doc/* -not -iname "*$BIN*" -a -not -name "." -delete 2> /dev/null #REMOVE ALL DOCUMENTATION NOT RELATED TO THE APP
	find ./"$APP".AppDir/.junest/usr/share/locale/*/*/* -not -iname "*$BIN*" -a -not -name "." -delete 2> /dev/null #REMOVE ALL ADDITIONAL LOCALE FILES
	rm -Rf ./"$APP".AppDir/.junest/home # remove the inbuilt home
	rm -Rf ./"$APP".AppDir/.junest/usr/include # files related to the compiler
	rm -Rf ./"$APP".AppDir/.junest/usr/share/man # AppImages are not ment to have man command
	rm -Rf ./"$APP".AppDir/.junest/usr/lib/python*/__pycache__/* # if python is installed, removing this directory can save several megabytes
	#rm -Rf ./"$APP".AppDir/.junest/usr/lib/gegl*/ff-*
	rm -Rf ./"$APP".AppDir/.junest/usr/lib/libgallium*
	rm -Rf ./"$APP".AppDir/.junest/usr/lib/libgo.so*
	rm -Rf ./"$APP".AppDir/.junest/usr/lib/libLLVM* # included in the compilation phase, can sometimes be excluded for daily use
	rm -Rf ./"$APP".AppDir/.junest/var/* # remove all packages downloaded with the package manager
}

_enable_mountpoints_for_the_inbuilt_bubblewrap() {
	mkdir -p ./"$APP".AppDir/.junest/home
	bind_dirs=$(grep "_dirs=" ./"$APP".AppDir/AppRun | tr '" ' '\n' | grep "/" | sort | xargs)
	for d in $bind_dirs; do mkdir -p ./"$APP".AppDir/.junest"$d"; done
	mkdir -p ./"$APP".AppDir/.junest/run/user
	rm -f ./"$APP".AppDir/.junest/etc/localtime && touch ./"$APP".AppDir/.junest/etc/localtime
	[ ! -f ./"$APP".AppDir/.junest/etc/asound.conf ] && touch ./"$APP".AppDir/.junest/etc/asound.conf
	[ ! -e ./"$APP".AppDir/.junest/usr/share/X11/xkb ] && rm -f ./"$APP".AppDir/.junest/usr/share/X11/xkb && mkdir -p ./"$APP".AppDir/.junest/usr/share/X11/xkb && sed -i -- 's# /var"$# /usr/share/X11/xkb /var"#g' ./"$APP"./AppRun
}

_remove_more_bloatwares
find ./"$APP".AppDir/.junest/usr/lib ./"$APP".AppDir/.junest/usr/lib32 -type f -regex '.*\.a' -exec rm -f {} \; 2>/dev/null
find ./"$APP".AppDir/.junest/usr -type f -regex '.*\.so.*' -exec strip --strip-debug {} \;
find ./"$APP".AppDir/.junest/usr/bin -type f ! -regex '.*\.so.*' -exec strip --strip-unneeded {} \;
find ./"$APP".AppDir/.junest/usr -type d -empty -delete

# DOWNLOAD AND EXTRACT PYTHON2 FROM DEBIAN BUSTER
if [ ! -d ./gimp-python-patch ]; then
	mkdir gimp-python-patch
	curl -#Lo gimp-python-patch.tar.xz https://github.com/ivan-hc/GIMP-appimage/releases/download/gimp-plugins-patches-for-the-hybrid-release/gimp-python-patch.tar.xz || exit 1
	tar fx ./gimp-python-patch.tar.xz -C ./gimp-python-patch/
fi

# PATCH GIMP WITH GIMP-PYTHON FROM DEBIAN 10 "BUSTER"
rsync --ignore-existing -raz --progress ./gimp-python-patch/usr/* ./"$APP".AppDir/.junest/usr/
rm -f ./"$APP".AppDir/.junest/usr/lib/gegl*/pixbuf-*.so

gimpdirs=$(find archlinux/.junest/usr/share/gimp -type d | sed 's/^archlinux\///g')
for d in $gimpdirs; do mkdir -p "$APP".AppDir/"$d"; done
gimplibs=$(find archlinux/.junest/usr/lib/gimp -type d | sed 's/^archlinux\///g')
for d in $gimplibs; do mkdir -p "$APP".AppDir/"$d"; done
_enable_mountpoints_for_the_inbuilt_bubblewrap

#############################################################################
#	CREATE THE APPIMAGE
#############################################################################

if test -f ./*.AppImage; then rm -Rf ./*archimage*.AppImage; fi

APPNAME=$(cat ./"$APP".AppDir/*.desktop | grep 'Name=' | head -1 | cut -c 6- | sed 's/ /-/g')
REPO="GIMP-appimage"
TAG="continuous-hybrid"
VERSION="$VERSION"
UPINFO="gh-releases-zsync|$GITHUB_REPOSITORY_OWNER|$REPO|$TAG|*x86_64.AppImage.zsync"

#ARCH=x86_64 ./appimagetool --comp zstd --mksquashfs-opt -Xcompression-level --mksquashfs-opt 20 \
ARCH=x86_64 ./appimagetool \
	-u "$UPINFO" \
	./"$APP".AppDir "$APPNAME"_"$VERSION"-Hybrid-with-python2-from-Debian-Buster-archimage4.9-x86_64.AppImage

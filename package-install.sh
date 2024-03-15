#!/bin/bash

if [ $UID != 0 ]; then
    echo "Script must be run as root"
    exit 1
fi

# Install Packman repository and switch some stuff to it
zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' 'Packman Repository'
zypper --gpg-auto-import-keys ref
zypper -n dup --from 'Packman Repository' --allow-vendor-change

# Install all media codecs for games, online, etc
zypper -n in gstreamer-plugins-{bad,base,good,libav,ugly}{,-32bit} gstreamer-plugins-good-extra{,-32bit}
#zypper -n in gstreamer-plugins-{bad,ugly}-codecs{,-32bit}
zypper -n in gstreamer-plugins-ugly-codecs{,-32bit} gstreamer-plugins-bad-codecs
## Currently gstreamer-plugins-bad-codecs-32bit is broken because libmodplug.so.1 can't be found
## so we have to break the install. This requires user interventions
zypper in gstreamer-plugins-bad-codecs-32bit

# Install web and comms packages
## Remove unneccessary stuff
zypper -n rm MozillaFirefox MozillaFirefox-branding-openSUSE konversation tigervnc

zypper ar 'https://packages.microsoft.com/yumrepos/edge' microsoft-edge
rpm --import https://packages.microsoft.com/keys/microsoft.asc
zypper -n in microsoft-edge-stable

# Install .NET sdk/runtime
wget https://packages.microsoft.com/config/opensuse/15/prod.repo
mv prod.repo /etc/zypp/repos.d/microsoft-prod.repo
zypper -n in libicu dotnet-sdk-8.0

# Install game related packages
zypper -n in wine{,tricks} steam libgudev-1_0-0{,-32bit} libSDL2-2_0-0 libjpeg-turbo mangohud{,-32bit} gamemode libgamemode0-32bit

# Necessary for GTK loading with Rider
zypper -n in libgthread-2_0-0

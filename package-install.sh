#!/bin/bash

if [ $UID != 0 ]; then
    echo "Script must be run as root"
    exit 1
fi

# Install Packman repository and switch some stuff to it
zypper ar -cfp 90 'https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/' 'Packman Repository'
zypper ref --gpg-auto-import-keys
zypper -n dup --from 'Packman Repository' --allow-vendor-change

# Install all media codecs for games, online, etc
zypper -n in gstreamer-plugins-{bad,base,good,libav,ugly}{,-32bit}
#zypper -n in gstreamer-plugins-{bad,ugly}-codecs{,-32bit}
## Currently gstreamer-plugins-bad-codecs-32bit is broken because libmodplug.so.1 can't be found
## so we have to try and break the install
zypper -n in gstreamer-plugins-ugly-codecs{,-32bit} gstreamer-plugins-bad-codecs
zypper in -y gstreamer-plugins-bad-codecs-32bit | echo '2'

# Install web and comms packages
## Remove unneccessary stuff
zypper -n rm firefox konversation tigervnc

zypper ar 'https://packages.microsoft.com/yumrepos/edge' microsoft-edge
rpm --import https://packages.microsof.com/keys/microsoft.asc
zypper -n in microsoft-edge-stable discord

# Install game related packages
zypper -n in wine{,tricks} steam libgudev-1_0-0{,-32bit} libSDL2-2_0-0 libjpeg-turbo mangohud{,-32bit} gamemode libgamemode0-32bit

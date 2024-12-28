#!/bin/bash

if [ $UID != 0 ]; then
    echo "Script must be run as root"
    exit 1
fi

# Install open kernel modules
zypper -n in nvidia-open-driver-G06-signed-kmp-default kernel-firmware-nvidia-gspx-G06

# Make sure modules get loaded
dracut -f

# Install display drivers
zypper ar -p 99 https://download.nvidia.com/opensuse/tumbleweed/ NVIDIA
zypper --gpg-auto-import-keys ref
zypper -n in nvidia-video-G06 nvidia-gl-G06 nvidia-compute-G06

# Additional utils
zypper -n in nvidia-utils-G06 nvidia-compute-utils-G06

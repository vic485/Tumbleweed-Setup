#!/bin/bash

# Remove localized user directories
LC_ALL=C xdg-user-dirs-update --force
echo "User dirs changed, you may now delete the old directories"

# Make ibus icon white to match breeze dark icons
gsettings set org.freedesktop.ibus.panel xkb-icon-rgba '#ffffff'

# Install discord
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install -y flathub dev.vencord.Vesktop

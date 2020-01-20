#!/bin/bash
# Version: Fedora 31

# Update System
sudo dnf update -y

# Enable RPM Fusion
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Dependencies
sudo dnf install curl wget newt xterm -y
sudo dnf -y groupinstall "Development Tools"

# Reyce Battery Use
sudo dnf install tlp tlp-rdw -y
sudo systemctl enable tlp

# Fonts
sudo dnf install powerline powerline-fonts google-roboto-fonts -y
sudo fc-cache -v

# Compressing Files
sudo dnf install unace unrar p7zip p7zip-plugins unzip -y

# # Gnome tweak, themes and extensions
# sudo dnf install gnome-tweak-tool -y
# sudo dnf install arc-theme -y
# sudo dnf install gnome-shell-extension-alternate-tab \
# gnome-shell-extension-dash-to-dock \
# gnome-shell-extension-topicons-plus -y

# Multimidia
sudo dnf install vlc -y
sudo dnf install \
gstreamer-plugins-base \
gstreamer1-plugins-base \
gstreamer-plugins-bad \
gstreamer-plugins-ugly \
gstreamer1-plugins-ugly \
gstreamer1-plugins-good \
gstreamer1-plugins-good-extras \
gstreamer1-plugins-bad-freeworld \
gstreamer-plugins-bad-nonfree
gstreamer1-libav
gstreamer1-plugins-bad-nonfree \
ffmpeg \
gstreamer-ffmpeg -y

# Utils
sudo dnf install nano git flatpak htop copyq -y

# Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Spotify
flatpak install flathub com.spotify.Client -y

# Slack
flatpak install flathub com.slack.Slack -y

# Postman
flatpak install flathub com.getpostman.Postman -y

# DBeaver Community
flatpak install flathub io.dbeaver.DBeaverCommunity -y

# Meld
flatpak install flathub org.gnome.meld -y

# Skype
flatpak install flathub com.skype.Client -y

# Telegram
flatpak install flathub org.telegram.desktop -y

# Zoom
flatpak install flathub us.zoom.Zoom -y

# Inkscape
flatpak install flathub org.inkscape.Inkscape -y

# Gimp
flatpak install flathub org.gimp.GIMP -y

# Bitwarden
flatpak install flathub com.bitwarden.desktop -y

# VSCode
cd ~/Downloads
wget "https://go.microsoft.com/fwlink/?LinkID=760867" -O vscode.rpm
sudo dnf localinstall vscode.rpm

# # Nvidia (without Bumblebee) - Wayland (intel) | Xorg (nvidia)
# sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-nvidia.repo
# sudo dnf install nvidia-driver akmod-nvidia kernel-devel nvidia-driver-libs.i686 vulkan.i686 cuda nvidia-driver-cuda cuda-devel nvidia-driver-NVML-devel -y

# # Nvidia (with Bumblebee)
# sudo dnf -y --nogpgcheck install http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee/fedora$(rpm -E %fedora)/noarch/bumblebee-release-1.2-1.noarch.rpm
# sudo dnf -y --nogpgcheck install http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee-nonfree/fedora$(rpm -E %fedora)/noarch/bumblebee-nonfree-release-1.2-1.noarch.rpm
# sudo dnf install bumblebee-nvidia bbswitch-dkms VirtualGL.x86_64 VirtualGL.i686 primus.x86_64 primus.i686 kernel-devel -y

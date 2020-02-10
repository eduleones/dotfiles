#!/bin/bash
# Version: Fedora 31

# Update System
sudo dnf -y update

# Enable RPM Fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Dependencies
sudo dnf -y install curl wget newt xterm
sudo dnf -y groupinstall "Development Tools"

# Reyce Battery Use
sudo dnf -y install tlp tlp-rdw
sudo systemctl enable tlp

# Fonts
sudo dnf -y install powerline powerline-fonts google-roboto-fonts
sudo fc-cache -v

# Compressing Files
sudo dnf -y install unace unrar p7zip p7zip-plugins unzip

# Terminal
sudo dnf -y install terminator screenfetch sl

# Gnome tweak, themes and extensions
sudo dnf -y install gnome-tweak-tool
sudo dnf -y install arc-theme
sudo dnf -y install gnome-shell-extension-dash-to-dock \
gnome-shell-extension-appindicator \
gnome-shell-extension-topicons-plus

# Multimidia
sudo dnf -y install vlc
sudo dnf -y install \
gstreamer-plugins-base \
gstreamer1-plugins-base \
gstreamer1-plugins-ugly \
gstreamer1-plugins-good \
gstreamer1-plugins-good-extras \
gstreamer1-plugins-bad-freeworld \
gstreamer1-libav \
ffmpeg \
gstreamer-ffmpeg

# Utils
sudo dnf -y install nano git flatpak htop copyq
 
# Flatpak Repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y

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
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760867" -O vscode.rpm && sudo dnf localinstall vscode.rpm -y

# # Nvidia (without Bumblebee) - Wayland (intel) | Xorg (nvidia)
# sudo dnf config-manager --add-repo=http://negativo17.org/repos/fedora-nvidia.repo
# sudo dnf install nvidia-driver akmod-nvidia kernel-devel nvidia-driver-libs.i686 vulkan.i686 cuda nvidia-driver-cuda cuda-devel nvidia-driver-NVML-devel -y

# # Nvidia (with Bumblebee)
# sudo dnf -y --nogpgcheck install http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee/fedora$(rpm -E %fedora)/noarch/bumblebee-release-1.2-1.noarch.rpm
# sudo dnf -y --nogpgcheck install http://install.linux.ncsu.edu/pub/yum/itecs/public/bumblebee-nonfree/fedora$(rpm -E %fedora)/noarch/bumblebee-nonfree-release-1.2-1.noarch.rpm
# sudo dnf install bumblebee-nvidia bbswitch-dkms VirtualGL.x86_64 VirtualGL.i686 primus.x86_64 primus.i686 kernel-devel -y

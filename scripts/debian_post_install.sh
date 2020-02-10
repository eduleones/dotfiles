#!/bin/bash

## Post Install Debian
## version: 10.2


# Update
sudo apt -y update && sudo apt -y upgrade

# Base
sudo apt -y install nano wget make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git

# Ufw (Firewall)
sudo apt -y install ufw && sudo ufw enable

# Multimidia
sudo apt -y install vlc ffmpeg
sudo apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly \
gstreamer1.0-plugins-bad ffmpeg sox twolame vorbis-tools lame faad mencoder

# Fonts
sudo apt -y install fonts-powerline fonts-roboto fonts-ubuntu

# Utils
sudo apt -y install terminator arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip \
meld htop iotop bash-completion

# Google Chrome
cd /tmp && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb && sudo dpkg -i chrome.deb && sudo apt -y install -f

# Vscode
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb && sudo dpkg -i vscode.deb && sudo apt -y install -f

# Zoom
cd /tmp && wget "https://zoom.us/client/latest/zoom_amd64.deb" -O zoom.deb && sudo dpkg -i zoom.deb && sudo apt -y install -f

# Spotify
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client

# Docker
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update && sudo apt -y install docker-ce && sudo apt -y install docker-compose
sudo systemctl enable docker
sudo usermod -aG docker ${USER}

# i3
sudo apt -y install i3 i3blocks i3lock feh


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

# Google Chrome
cd /tmp && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb && sudo dpkg -i chrome.deb && sudo apt -y install -f

# Vscode
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb && sudo dpkg -i vscode.deb && sudo apt -y install -f

# Snap
sudo apt install snapd

# Snap apps
sudo snap install spotify
sudo snap install postman
sudo snap install slack --classic

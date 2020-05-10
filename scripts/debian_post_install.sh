#!/bin/bash

## Post Install Debian
## version: 10.2

cd ~/

echo -e ">>>> Software Update <<<<"
sudo apt -y update && sudo apt -y upgrade

echo -e ">>>> Remove Gnome Games <<<<"
sudo apt purge gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno \
gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row \
gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex
sudo apt autoremove

echo -e ">>>> Install Essential <<<<"
sudo apt -y install nano wget make build-essential dkms linux-headers-$(uname -r) libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev mesa-utils \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git intel-microcode

echo -e ">>>> Install Nvidia <<<<"
sudo apt -y install nvidia-detect
sudo apt -y install firmware-linux firmware-linux-nonfree 
sudo apt -y install bumblebee-nvidia primus libgl1-nvidia-glx
sudo adduser ${USER} bumblebee 

echo -e ">>>> Enable Firewall <<<<"
sudo apt -y install ufw && sudo ufw enable

echo -e ">>>> Install Multimidia <<<<"
sudo apt -y install vlc ffmpeg
sudo apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly \
gstreamer1.0-plugins-bad ffmpeg sox twolame vorbis-tools lame faad mencoder

echo -e ">>>> Install Fonts <<<<"
sudo apt -y install fonts-powerline fonts-roboto fonts-ubuntu msttcorefonts

echo -e ">>>> Install Utils <<<<"
sudo apt -y install terminator arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip \
meld htop iotop bash-completion screenfetch flameshot vim

echo -e ">>>> Gnome Themes and Configs <<<<"
sudo apt -y install moka-icon-theme papirus-icon-theme

# Gnome extensions
# https://extensions.gnome.org/extension/615/appindicator-support/

# Gnome - Mudando de Fahrenheit para Celsius no Weather Dash Plugin
gsettings set org.gnome.GWeather temperature-unit "'centigrade'"


echo -e ">>>> Install Bluetooth and Sound <<<<"
sudo apt install pulseaudio pulseaudio-module-bluetooth bluez-firmware
# sudo apt install blueman pavucontrol

echo -e ">>>> Install Google Chrome <<<<"
cd /tmp && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb
sudo dpkg -i chrome.deb && sudo apt -y install -f

echo -e ">>>> Install VSCode <<<<"
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
sudo dpkg -i vscode.deb && sudo apt -y install -f

echo -e ">>>> Install Zoom <<<<"
cd /tmp && wget "https://zoom.us/client/latest/zoom_amd64.deb" -O zoom.deb
sudo dpkg -i zoom.deb && sudo apt -y install -f

echo -e ">>>> Install Spotify <<<<"
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt -y install spotify-client

echo -e ">>>> Install Docker <<<<"
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update && sudo apt -y install docker-ce && sudo apt -y install docker-compose
sudo systemctl enable docker
sudo usermod -aG docker ${USER}

echo -e ">>>> Install i3 <<<<"
sudo apt -y install i3 i3blocks i3lock feh

echo -e ">>>> Install Pyenv <<<<"
curl https://pyenv.run | bash
echo '# Pyenv config' >> ~/.bashrc
echo 'export PATH="${HOME}/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

echo -e ">>>> Install Zsh (Oh My Zsh) <<<<"
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


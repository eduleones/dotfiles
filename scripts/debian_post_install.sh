#!/bin/bash

## Post Install Debian
## version: 10.2

cd ~/


echo "################################################################"
echo "###################   Software Update     ######################"
echo "################################################################"
sudo apt -y update && sudo apt -y upgrade


echo "################################################################"
echo "###################   Remove Gnome Games  ######################"
echo "################################################################"
sudo apt -y purge gnome-2048 aisleriot atomix gnome-chess five-or-more hitori iagno \
gnome-klotski lightsoff gnome-mahjongg gnome-mines gnome-nibbles quadrapassel four-in-a-row \
gnome-robots gnome-sudoku swell-foop tali gnome-taquin gnome-tetravex
sudo apt -y autoremove


echo "################################################################"
echo "###################   Install Essentials  ######################"
echo "################################################################"
sudo apt -y install nano wget make build-essential dkms linux-headers-$(uname -r) libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev mesa-utils \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git intel-microcode


echo "################################################################"
echo "###################   Install Nvidia      ######################"
echo "################################################################"
sudo apt -y install nvidia-detect
sudo apt -y install firmware-linux firmware-linux-nonfree 
sudo apt -y install bumblebee-nvidia primus libgl1-nvidia-glx
sudo adduser ${USER} bumblebee 


echo "################################################################"
echo "###################   Enable Firewall     ######################"
echo "################################################################"
sudo apt -y install ufw && sudo ufw enable


echo "################################################################"
echo "###################   Install Multimidia  ######################"
echo "################################################################"
sudo apt -y install vlc ffmpeg
sudo apt -y install gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly \
gstreamer1.0-plugins-bad ffmpeg sox twolame vorbis-tools lame faad mencoder


echo "################################################################"
echo "###################   Install Fonts       ######################"
echo "################################################################"
sudo apt -y install fonts-powerline fonts-roboto fonts-ubuntu msttcorefonts


echo "################################################################"
echo "###################   Install Utilities   ######################"
echo "################################################################"
sudo apt -y install terminator arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip \
meld htop iotop bash-completion screenfetch flameshot vim



echo "################################################################"
echo "###################   Gnome Themes and Configs #################"
echo "################################################################"
# Gnome extensions
# https://extensions.gnome.org/extension/615/appindicator-support/
sudo apt -y install moka-icon-theme papirus-icon-theme
gsettings set org.gnome.GWeather temperature-unit "'centigrade'"


echo -e ">>>> Install Bluetooth and Sound <<<<"
echo "################################################################"
echo "###################   Install Bluetooth Firmware ###############"
echo "################################################################"
# sudo apt install blueman pavucontrol pulseaudio pulseaudio-module-bluetooth
sudo apt install  bluez-firmware


echo "################################################################"
echo "###################   Install Chrome      ######################"
echo "################################################################"
cd /tmp && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb
sudo dpkg -i chrome.deb || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install VSCode      ######################"
echo "################################################################"
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
sudo dpkg -i vscode.deb || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install Zoom        ######################"
echo "################################################################"
cd /tmp && wget "https://zoom.us/client/latest/zoom_amd64.deb" -O zoom.deb
sudo dpkg -i zoom.deb || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install Spotify     ######################"
echo "################################################################"
curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update && sudo apt -y install spotify-client || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install Slack       ######################"
echo "################################################################"
cd /tmp && wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb -O slack.deb
sudo dpkg -i slack.deb || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install Docker      ######################"
echo "################################################################"
sudo apt -y install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update -y && sudo apt -y install docker-ce docker-compose || true
sudo apt -y install -f
sudo systemctl enable docker
sudo usermod -aG docker ${USER}


echo "################################################################"
echo "###################   Install i3          ######################"
echo "################################################################"
sudo apt -y install i3 i3blocks i3lock feh


echo "################################################################"
echo "###################   Install PyENV       ######################"
echo "################################################################"
curl https://pyenv.run | bash
echo '# PyENV ' >> ~/.bashrc
echo 'export PATH="${HOME}/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc


echo "################################################################"
echo "###################   Install nvm / node  ######################"
echo "################################################################"
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash


echo "################################################################"
echo "###################   Install golang      ######################"
echo "################################################################"
cd /tmp && wget https://dl.google.com/go/go1.14.3.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.14.3.linux-amd64.tar.gz
echo '# Golang ' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc


echo "################################################################"
echo "###################   Install Zsh (Oh My Zsh)  #################"
echo "################################################################"
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


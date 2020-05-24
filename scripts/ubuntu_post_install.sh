#!/bin/bash

## Ubuntu Post Install
## version: 20.04


cd ~/

echo "################################################################"
echo "###################    Software Update    ######################"
echo "################################################################"
sudo apt -y update && sudo apt -y upgrade


echo "################################################################"
echo "###################    Install Essential  ######################"
echo "################################################################"
sudo apt -y install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git


echo "################################################################"
echo "###################    Enable Firewall    ######################"
echo "################################################################"
sudo ufw enable

echo "################################################################"
echo "###################   Install Multimidia  ######################"
echo "################################################################"
sudo apt -y install ubuntu-restricted-extras
sudo apt -y install vlc


echo -e ">>>> Install Fonts <<<<"
echo "################################################################"
echo "###################   Install Fonts       ######################"
echo "################################################################"
sudo apt -y install fonts-powerline fonts-roboto


echo "################################################################"
echo "###################   Install Utils       ######################"
echo "################################################################"
sudo apt -y install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip
sudo apt -y install meld htop iotop bash-completion screenfetch flameshot vim terminator


echo "################################################################"
echo "###################   Gnome Confs         ######################"
echo "################################################################"
#gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.GWeather temperature-unit "'centigrade'"


echo "################################################################"
echo "###################   Install Docker      ######################"
echo "################################################################"
sudo apt -y install docker.io docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker ${USER}


echo "################################################################"
echo "###################   Install VSCode      ######################"
echo "################################################################"
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb
sudo dpkg -i vscode.deb || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install Chrome      ######################"
echo "################################################################"
cd /tmp && wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" -O chrome.deb
sudo dpkg -i chrome.deb || true
sudo apt install -f


echo "################################################################"
echo "###################   Install Slack       ######################"
echo "################################################################"
cd /tmp && wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.4.3-amd64.deb -O slack.deb
sudo dpkg -i slack.deb || true
sudo apt -y install -f


echo "################################################################"
echo "###################   Install Snap Apps   ######################"
echo "################################################################"
sudo snap install spotify
sudo snap install zoom-client
sudo snap install redis-desktop-manager
sudo snap install dbeaver-ce
sudo snap install postman
sudo snap install bitwarden


echo "################################################################"
echo "###################   Install Golang      ######################"
echo "################################################################"
sudo apt -y install golang


echo "################################################################"
echo "###################   Install i3 WM       ######################"
echo "################################################################"
sudo apt -y install i3 i3blocks i3lock feh

echo "################################################################"
echo "###################   Install Pyenv       ######################"
echo "################################################################"
curl https://pyenv.run | bash
echo '' >> ~/.bashrc
echo "# Pyenv config" >> ~/.bashrc
echo 'export PATH="${HOME}/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc


echo "################################################################"
echo "###################   Install Oh My Zsh   ######################"
echo "################################################################"
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"

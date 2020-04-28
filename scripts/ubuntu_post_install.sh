#!/bin/bash

## Ubuntu Post Install
## version: 20.04


cd ~/

echo -e ">>>> Software Update <<<<"
sudo apt -y update && sudo apt -y upgrade


echo -e ">>>> Install Essential <<<<"
sudo apt -y install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git


echo -e ">>>> Github configure <<<<"
git config --global user.name "Eduardo Leones"
git config --global user.email eduleones@gmail.com


echo -e ">>>> Enable Firewall <<<<"
sudo ufw enable

echo -e ">>>> Install Multimidia <<<<"
sudo apt -y install ubuntu-restricted-extras
sudo apt -y install vlc


echo -e ">>>> Install Fonts <<<<"
sudo apt -y install fonts-powerline fonts-roboto


echo -e ">>>> Install Utils <<<<"
sudo apt -y install arc arj cabextract lhasa p7zip p7zip-full p7zip-rar rar unrar unace unzip xz-utils zip
sudo apt -y install meld htop iotop bash-completion screenfetch flameshot vim terminator


echo -e ">>>> Config Gnome <<<<"
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
gsettings set org.gnome.desktop.interface show-battery-percentage true


echo -e ">>>> Docker <<<<"
sudo apt -y install docker.io docker-compose
sudo systemctl enable --now docker
sudo usermod -aG docker ${USER} 


echo -e ">>>> Install VSCode <<<<"
cd /tmp && wget "https://go.microsoft.com/fwlink/?LinkID=760868" -O vscode.deb && sudo dpkg -i vscode.deb
sudo apt install -f


echo -e ">>>> Install Snap Softwares <<<<"
sudo snap install spotify
sudo snap install zoom-client
sudo snap install slack --classic
sudo snap install redis-desktop-manager
sudo snap install dbeaver-ce
sudo snap install postman
sudo snap install bitwarden

echo -e ">>>> Install Pyenv <<<<"
curl https://pyenv.run | bash
echo '' >> ~/.bashrc
echo "# Pyenv config" >> ~/.bashrc
echo 'export PATH="${HOME}/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc


echo -e ">>>> Install Oh My Zsh <<<<"
sudo apt -y install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


echo -e ">>>> Finish <<<<"

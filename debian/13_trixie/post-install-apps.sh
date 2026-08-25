#!/usr/bin/env bash
# Post-install script - Debian 13 (Trixie) + KDE Plasma
# Parte 2/2: instalacao e remocao de aplicativos
# Requer que post-install-configs.sh ja tenha rodado antes (contrib, flatpak, debconf)
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Nao rode como root. Rode como seu usuario normal (o script usa sudo onde precisa)."
  exit 1
fi

log() { echo -e "\n\033[1;32m==> $*\033[0m"; }

# ---------------------------------------------------------------------------
# 1. Remover apps KDE que vieram por padrao e nao sao usados
# ---------------------------------------------------------------------------
log "Removendo apps KDE nao usados (akregator, kmail, konqueror, kaddressbook, dragonplayer, kwalletmanager, juk, korganizer, libreoffice)"
sudo apt purge -y akregator kmail konqueror kaddressbook dragonplayer kwalletmanager juk korganizer 'libreoffice*'
sudo apt autoremove -y

# ---------------------------------------------------------------------------
# 2. Utilitarios do sistema
# ---------------------------------------------------------------------------
log "Utilitarios"
sudo apt install -y \
  htop ncdu synaptic iotop \
  python-is-python3 python3-pip \
  fastfetch \
  qbittorrent \
  intel-microcode \
  p7zip-full unrar unzip zip \
  meld bash-completion \
  fonts-powerline

# ---------------------------------------------------------------------------
# 3. Multimidia / codecs / thumbnails
# ---------------------------------------------------------------------------
log "Multimidia e codecs"
sudo apt install -y \
  vlc kdeconnect \
  ffmpeg libavcodec-extra \
  ffmpegthumbnailer ffmpegthumbs kdegraphics-thumbnailers tumbler-plugins-extra \
  gstreamer1.0-nice gstreamer1.0-plugins-good gstreamer1.0-plugins-base \
  gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly \
  gstreamer1.0-libav gstreamer1.0-tools gstreamer1.0-vaapi

# ---------------------------------------------------------------------------
# 4. Reproducao de DVD (precisa de contrib - habilitado no post-install-configs.sh)
# ---------------------------------------------------------------------------
log "Suporte a DVD (libdvd-pkg)"
sudo apt install -y libdvd-pkg
sudo dpkg-reconfigure libdvd-pkg

# ---------------------------------------------------------------------------
# 5. Fontes (precisa de contrib; EULA ja aceita no post-install-configs.sh)
# ---------------------------------------------------------------------------
log "Fontes Microsoft + substitutas metricamente compativeis"
sudo apt install -y ttf-mscorefonts-installer fonts-crosextra-caladea fonts-crosextra-carlito

# ---------------------------------------------------------------------------
# 6. Google Chrome (repo ja configurado nesta maquina; deixa reprodutivel)
# ---------------------------------------------------------------------------
log "Google Chrome"
if [[ ! -f /etc/apt/sources.list.d/google-chrome.sources ]] && [[ ! -f /etc/apt/sources.list.d/google-chrome.list ]]; then
  wget -qO /tmp/google-chrome-stable_current_amd64.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo apt install -y /tmp/google-chrome-stable_current_amd64.deb
  rm -f /tmp/google-chrome-stable_current_amd64.deb
else
  sudo apt install -y google-chrome-stable
fi

# ---------------------------------------------------------------------------
# 7. Visual Studio Code (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Visual Studio Code"
flatpak install -y --user flathub com.visualstudio.code

# ---------------------------------------------------------------------------
# 8. Brave Browser (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Brave Browser"
flatpak install -y --user flathub com.brave.Browser

# ---------------------------------------------------------------------------
# 9. Bitwarden (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Bitwarden"
flatpak install -y --user flathub com.bitwarden.desktop

# ---------------------------------------------------------------------------
# 10. Video Downloader (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Video Downloader"
flatpak install -y --user flathub com.github.unrud.VideoDownloader

# ---------------------------------------------------------------------------
# 11. Anki (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Anki"
flatpak install -y --user flathub net.ankiweb.Anki

# ---------------------------------------------------------------------------
# 12. Spotify (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Spotify"
flatpak install -y --user flathub com.spotify.Client

# ---------------------------------------------------------------------------
# 13. Flatseal (via Flatpak/Flathub)
# ---------------------------------------------------------------------------
log "Flatseal"
flatpak install -y --user flathub com.github.tchx84.Flatseal

# ---------------------------------------------------------------------------
# 14. Docker (repo configurado no post-install-configs.sh)
# ---------------------------------------------------------------------------
log "Docker"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl enable --now docker
sudo usermod -aG docker "$USER"

# ---------------------------------------------------------------------------
# 15. Claude Code CLI
# ---------------------------------------------------------------------------
log "Claude Code CLI"
if [[ ! -x "$HOME/.local/bin/claude" ]]; then
  curl -fsSL https://claude.ai/install.sh | bash
fi

# ---------------------------------------------------------------------------
# 16. Zsh + Oh My Zsh
# ---------------------------------------------------------------------------
log "Zsh + Oh My Zsh"
sudo apt install -y zsh
KEEP_ZSHRC=yes CHSH=no RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo chsh -s "$(command -v zsh)" "$USER"

# Oh My Zsh gera um .zshrc que so comenta o export de ~/.local/bin no PATH
# (onde ficam claude, pipx, etc) - sem isso, comandos instalados la somem no zsh
sed -i 's|^# export PATH=\$HOME/bin:\$HOME/.local/bin:/usr/local/bin:\$PATH|export PATH="$HOME/.local/bin:$PATH"|' "$HOME/.zshrc"

log "post-install-apps.sh concluido."
echo "Pacotes que existiam no seu historico mas NAO existem mais no Trixie (Plasma 6 os fundiu/descontinuou): breeze-gtk, kde-gtk-config, neofetch (substituido por fastfetch), stacer (nao empacotado no Debian)."

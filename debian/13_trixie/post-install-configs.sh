#!/usr/bin/env bash
# Post-install script - Debian 13 (Trixie) + KDE Plasma
# Parte 1/2: fontes do apt e configuracoes de sistema
# Rode este script ANTES do post-install-apps.sh
set -euo pipefail

if [[ $EUID -eq 0 ]]; then
  echo "Nao rode como root. Rode como seu usuario normal (o script usa sudo onde precisa)."
  exit 1
fi

log() { echo -e "\n\033[1;32m==> $*\033[0m"; }

# ---------------------------------------------------------------------------
# 1. Habilitar contrib (faltava - por isso mscorefonts e libdvd-pkg falhavam)
# ---------------------------------------------------------------------------
log "Habilitando componente 'contrib' no sources.list"
sudo sed -i -E 's/^(deb(-src)? http:\/\/(deb|security)\.debian\.org\/[^ ]+ [a-z-]+ main )non-free-firmware/\1contrib non-free-firmware/' /etc/apt/sources.list
grep -q '^deb .*trixie main.*contrib' /etc/apt/sources.list && echo "contrib OK" || echo "AVISO: confira /etc/apt/sources.list manualmente"

log "Atualizando indices e pacotes"
sudo apt update
sudo apt full-upgrade -y

# ---------------------------------------------------------------------------
# 2. Locales
# ---------------------------------------------------------------------------
sudo apt install -y locales

# ---------------------------------------------------------------------------
# 3. Flatpak (infraestrutura - remote ja existe, mas nao faz mal repetir)
# ---------------------------------------------------------------------------
log "Flatpak + Flathub"
sudo apt install -y flatpak plasma-discover-backend-flatpak
flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo

# ---------------------------------------------------------------------------
# 4. Integracao GTK/KDE
# ---------------------------------------------------------------------------
log "Integracao de tema GTK no KDE"
sudo apt install -y kde-config-gtk-style kde-config-gtk-style-preview

# ---------------------------------------------------------------------------
# 5. Aceite de EULA (mscorefonts) via debconf - instalacao fica no outro script
# ---------------------------------------------------------------------------
log "Configurando aceite de licenca das fontes Microsoft"
echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true" | sudo debconf-set-selections

# ---------------------------------------------------------------------------
# 6. Docker (repo oficial - keyring moderno, sem apt-key)
# ---------------------------------------------------------------------------
log "Configurando repo oficial do Docker"
sudo apt install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
if [[ ! -f /etc/apt/keyrings/docker.asc ]]; then
  sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc
fi
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# ---------------------------------------------------------------------------
# 7. SSH + chave para o GitHub
# ---------------------------------------------------------------------------
log "SSH"
sudo apt install -y openssh-client

SSH_KEY="$HOME/.ssh/id_ed25519"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [[ ! -f "$SSH_KEY" ]]; then
  log "Gerando chave SSH (ed25519) para o GitHub"
  ssh-keygen -t ed25519 -C "eduleones@gmail.com" -f "$SSH_KEY" -N ""
else
  echo "Chave SSH ja existe em $SSH_KEY, pulando geracao."
fi

ssh-add "$SSH_KEY" 2>/dev/null || echo "AVISO: nao consegui adicionar a chave ao ssh-agent (verifique se ha um agent rodando)"

if [[ ! -f "$HOME/.ssh/config" ]] || ! grep -q "^Host github.com" "$HOME/.ssh/config" 2>/dev/null; then
  cat >> "$HOME/.ssh/config" <<EOF
Host github.com
  HostName github.com
  User git
  IdentityFile $SSH_KEY
  IdentitiesOnly yes
EOF
  chmod 600 "$HOME/.ssh/config"
fi

# ---------------------------------------------------------------------------
# 8. Git - identidade global
# ---------------------------------------------------------------------------
log "Configurando identidade do Git"
git config --global user.name "Eduardo Leones"
git config --global user.email "eduleones@gmail.com"

# ---------------------------------------------------------------------------
# 9. Desabilitar suspensao/hibernacao
# ---------------------------------------------------------------------------
log "Desabilitando suspend/hibernate/hybrid-sleep (efeito somente apos reiniciar o sistema)"
sudo mkdir -p /etc/systemd/sleep.conf.d
cat <<EOF | sudo tee /etc/systemd/sleep.conf.d/disable-sleep.conf > /dev/null
[Sleep]
AllowSuspend=no
AllowHibernation=no
AllowSuspendThenHibernate=no
AllowHybridSleep=no
EOF
echo "Config gravada em /etc/systemd/sleep.conf.d/disable-sleep.conf - so tem efeito depois de REINICIAR o sistema."

log "post-install-configs.sh concluido. Agora rode post-install-apps.sh"

echo
echo "==================================================================="
echo " CHAVE PUBLICA SSH - cole em https://github.com/settings/ssh/new"
echo "==================================================================="
cat "$SSH_KEY.pub"
echo "==================================================================="
echo "Depois de cadastrar no GitHub, teste com: ssh -T git@github.com"

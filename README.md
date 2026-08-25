# dotfiles

My dotfiles.

## debian/13_trixie

Post-install scripts for Debian 13 (Trixie) + KDE Plasma.

- `post-install-configs.sh` — apt sources (contrib, Docker repo), locales, Flatpak/Flathub setup, GTK/KDE integration, SSH key + GitHub, Git identity. Run this first.
- `post-install-apps.sh` — removes unused default KDE apps, installs utilities, multimedia/codecs, DVD support, fonts, Docker, zsh + Oh My Zsh, browsers and other apps (apt + Flatpak).

```
bash debian/13_trixie/post-install-configs.sh
bash debian/13_trixie/post-install-apps.sh
```

## wallpapers

Wallpaper backups.

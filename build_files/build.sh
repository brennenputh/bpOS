#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable atim/starship
dnf5 -y copr enable che/nerd-fonts
dnf5 -y copr enable trs-sod/swaylock-effects

# Base System Packages
dnf5 install -y \
  alacritty \
  bootc \
  fastfetch \
  fira-code-fonts \
  fish \
  fontawesome-fonts \
  gcc \
  htop \
  kitty \
  make \
  neovim \
  network-manager-applet \
  NetworkManager-tui \
  papirus-icon-theme \
  nerd-fonts \
  playerctl \
  python3 \
  python3-pip \
  rofi-wayland \
  rustup \
  starship \
  sway \
  tailscale \
  ublue-brew \
  uupd \
  wl-clipboard \
  zoxide

dnf5 remove -y \
  swaylock

dnf5 install -y \
  swaylock-effects

dnf5 -y copr disable ublue-os/packages
dnf5 -y copr disable atim/starship
dnf5 -y copr disable che/nerd-fonts

systemctl enable uupd.timer
systemctl enable brew-setup.service
systemctl enable podman.socket

# Copy system files to container
rsync -rvK /ctx/system_files/ /

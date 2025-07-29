#!/bin/bash

set -ouex pipefail

### Add OS info to image.

/ctx/build_files/image-info.sh

### Install packages
dnf5 -y copr enable ublue-os/packages
dnf5 -y copr enable atim/starship
dnf5 -y copr enable che/nerd-fonts
dnf5 -y copr enable trs-sod/swaylock-effects

# Base System Packages
dnf5 install -y \
  alacritty \
  bootc \
  dunst \
  fastfetch \
  fira-code-fonts \
  fish \
  fontawesome-fonts \
  gcc \
  gcc-c++ \
  git \
  grim \
  htop \
  java-21-openjdk \
  kitty \
  lua \
  make \
  neovim \
  nerd-fonts \
  network-manager-applet \
  NetworkManager-tui \
  openssl-devel \
  papirus-icon-theme \
  pavucontrol \
  playerctl \
  python3 \
  python3-pip \
  rofi-wayland \
  slurp \
  starship \
  sway \
  tailscale \
  ublue-brew \
  uupd \
  waybar \
  wl-clipboard \
  zoxide

dnf5 remove -y \
  swaylock

dnf5 install -y \
  swaylock-effects

/ctx/build_files/virtualization.sh

dnf5 -y copr disable ublue-os/packages
dnf5 -y copr disable atim/starship
dnf5 -y copr disable che/nerd-fonts
dnf5 -y copr disable trs-sod/swaylock-effects

systemctl enable uupd.timer
systemctl enable brew-setup.service
systemctl enable podman.socket
systemctl enable tailscaled.service

# Copy system files to container
rsync -rvK /ctx/system_files/ /

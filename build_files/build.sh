#!/bin/bash

set -ouex pipefail

### Add OS info to image.

IMAGE_PRETTY_NAME="bpOS"
IMAGE_NAME="bpos"
IMAGE_LIKE="fedora"

sed -i "s|^VARIANT_ID=.*|VARIANT_ID=$IMAGE_NAME|" /usr/lib/os-release
sed -i "s|^PRETTY_NAME=.*|PRETTY_NAME=\"${IMAGE_PRETTY_NAME}\"|" /usr/lib/os-release
sed -i "s|^NAME=.*|NAME=\"$IMAGE_PRETTY_NAME\"|" /usr/lib/os-release
sed -i "s|^ID=fedora|ID=${IMAGE_PRETTY_NAME,}\nID_LIKE=\"${IMAGE_LIKE}\"|" /usr/lib/os-release

# Added in systemd 249.
# https://www.freedesktop.org/software/systemd/man/latest/os-release.html#IMAGE_ID=
echo "IMAGE_ID=\"${IMAGE_NAME}\"" >> /usr/lib/os-release

# Fix issues caused by ID no longer being fedora
sed -i "s|^EFIDIR=.*|EFIDIR=\"fedora\"|" /usr/sbin/grub2-switch-to-blscfg

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

sudo dnf5 install -y \
  libvirt \
  libvirt-nss \
  qemu \
  qemu-char-spice \
  qemu-device-display-virtio-gpu \
  qemu-device-display-virtio-vga \
  qemu-img \
  qemu-system-x86-core \
  qemu-user-binfmt \
  qemu-user-static \
  ublue-os-libvirt-workarounds \
  virt-manager \
  virt-v2v \
  virt-viewer

dnf5 remove -y \
  swaylock

dnf5 install -y \
  swaylock-effects

dnf5 -y copr disable ublue-os/packages
dnf5 -y copr disable atim/starship
dnf5 -y copr disable che/nerd-fonts
dnf5 -y copr disable trs-sod/swaylock-effects

systemctl enable uupd.timer
systemctl enable brew-setup.service
systemctl enable podman.socket
systemctl enable tailscaled.service
systemctl enable ublue-os-libvirt-workarounds.service

# Copy system files to container
# rsync -rvK /ctx/system_files/ /

#!/bin/bash

# Libraries for virtualization
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

systemctl enable ublue-os-libvirt-workarounds.service

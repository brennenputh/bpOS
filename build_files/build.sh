#!/bin/bash

set -ouex pipefail

# Base System Packages
dnf5 install -y \
  alacritty

# Brother Printer Drivers
echo "%_pkgverify_level none" >/etc/rpm/macros.verify
dnf5 install -y \
  http://download.brother.com/welcome/dlf103563/hll2395dwpdrv-4.0.0-1.i386.rpm
rm /etc/rpm/macros.verify

# GlobalProtect
dnf5 copr enable -y yuezk/globalprotect-openconnect
dnf5 install -y globalprotect-openconnect
dnf5 copr disable -y yuezk/globalprotect-openconnect

# Copy system files to container
rsync -rvK /ctx/system_files/ /

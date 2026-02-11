#!/bin/bash

set -ouex pipefail

# Base System Packages
dnf5 install -y \
  alacritty

# GlobalProtect
dnf5 copr enable -y yuezk/globalprotect-openconnect
dnf5 install -y globalprotect-openconnect
dnf5 copr disable -y yuezk/globalprotect-openconnect

# Copy system files to container
rsync -rvK /ctx/system_files/ /

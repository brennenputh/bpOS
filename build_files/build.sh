#!/bin/bash

set -ouex pipefail

# Base System Packages
dnf5 install -y \
  alacritty

# Copy system files to container
rsync -rvK /ctx/system_files/ /

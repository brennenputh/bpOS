#!/bin/bash

set -ouex pipefail

# Base System Packages
dnf5 install -y \
  alacritty

# Brother Printer Drivers
dnf5 install -y \
  /rpms/hll2395dwpdrv-4.0.0-1.i386.rpm

# Copy system files to container
rsync -rvK /ctx/system_files/ /

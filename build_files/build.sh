#!/bin/bash

set -ouex pipefail

# usbip
sudo dnf install -y usbip-devel

# GlobalProtect
dnf copr enable -y yuezk/globalprotect-openconnect
dnf install -y globalprotect-openconnect
dnf copr disable -y yuezk/globalprotect-openconnect

# Copy system files to container
rsync -rvK /ctx/system_files/ /

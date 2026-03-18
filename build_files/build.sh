#!/bin/bash

set -ouex pipefail

dnf install -y dnf5-plugins

# GlobalProtect
dnf copr enable -y yuezk/globalprotect-openconnect
dnf install -y globalprotect-openconnect
dnf copr disable -y yuezk/globalprotect-openconnect

# Copy system files to container
rsync -rvK /ctx/system_files/ /

# Allow build scripts to be referenced without being copied into the final image
ARG FEDORA_VERSION=44
FROM scratch AS ctx
COPY build_files /build_files
COPY system_files /system_files

# Base Image

FROM ghcr.io/ublue-os/akmods:coreos-stable-"${FEDORA_VERSION}" AS akmods
FROM ghcr.io/ublue-os/akmods-zfs:coreos-stable-"${FEDORA_VERSION}" AS akmods-zfs

FROM ghcr.io/zirconium-dev/zirconium@sha256:a6dc5dad2f2a7f2ded4f324d1a3c1ccd882f43f466be16ad16dc11a51e0b6e69 AS base

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:latest
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
# 
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build_files/build.sh
    
### LINTING
## Verify final image and contents are correct.
RUN bootc container lint

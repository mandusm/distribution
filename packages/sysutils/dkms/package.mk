# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2023-present Team RockNix

PKG_NAME="dkms"
PKG_VERSION="3.1.4"
PKG_LICENSE="GPL-2.0-or-later"
PKG_SITE="dell/dkms"
PKG_URL="https://github.com/dell/dkms/archive/refs/tags/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain systemd linux"
PKG_LONGDESC="Dynamic Kernel Module Support (DKMS) is a framework that allows kernel drivers to be dynamically built for each kernel version installed on the system."

make_target() {
  # DKMS uses a simple make system
  make
}

makeinstall_target() {
  # Install DKMS
  make install DESTDIR=${INSTALL}
}

post_install() {
  # Create necessary directories if they don't exist
  mkdir -p ${INSTALL}/var/lib/dkms
  mkdir -p ${INSTALL}/usr/src
}
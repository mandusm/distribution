# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2023-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="bcmdhd"
PKG_VERSION="101.10.591.52.27-1"  # Replace with actual commit hash
PKG_LICENSE="GPL-2.0"
PKG_SITE="https://github.com/Joshua-Riek/bcmdhd-dkms/"
PKG_URL="https://github.com/Joshua-Riek/bcmdhd-dkms/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="$LINUX_DEPENDS"
PKG_LONGDESC="Broadcom FullMAC wireless driver (DKMS version from Armbian)"
PKG_IS_KERNEL_PKG="yes"
PKG_TOOLCHAIN="manual"

make_target() {
  cd $PKG_BUILD/src
  export LINUX_DIR=$(get_build_dir linux) 
  make -C ${LINUX_DIR} M=${PKG_BUILD}/src ARCH=${TARGET_KERNEL_ARCH} CROSS_COMPILE=${TARGET_KERNEL_PREFIX} CONFIG_BCMDHD_SDIO=y CONFIG_BCMDHD_PCIE= CONFIG_BCMDHD_USB= 
}

makeinstall_target() {
  mkdir -p $INSTALL/$(get_full_module_dir)/bcmdhd
  cp $PKG_BUILD/src/*.ko $INSTALL/$(get_full_module_dir)/bcmdhd

  mkdir -p ${INSTALL}/usr/lib/modprobe.d
  echo "blacklist bcmdhd" > "${INSTALL}/usr/lib/modprobe.d/bcmdhd.conf"
  echo "blacklist dhd_static_buf" >> "${INSTALL}/usr/lib/modprobe.d/bcmdhd.conf"

  mkdir -p ${INSTALL}/usr/lib/modules-load.d/
  echo "bcmdhd_sdio.ko" > "${INSTALL}/usr/lib/modules-load.d/bcmdhd.conf"
  echo "dhd_static_buf_sdio.ko" >> "${INSTALL}/usr/lib/modules-load.d//bcmdhd.conf"

  mkdir -p ${INSTALL}/usr/config/system/vendor/etc/wifi/
  cp ${PKG_DIR}/firmware/* ${INSTALL}/usr/config/system/vendor/etc/wifi/

}


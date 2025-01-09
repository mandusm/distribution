PKG_NAME="ap6611-bluetooth"
PKG_VERSION="0.1.0"
PKG_LICENSE="BSD"
PKG_LONGDESC="Device Tree Blob Overlay Configuration File System"
PKG_DEPENDS_TARGET="toolchain linux"
PKG_NEED_UNPACK="${LINUX_DEPENDS}"
PKG_TOOLCHAIN="manual"

makeinstall_target() {

  mkdir -p ${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/ap6611s/
  cp ${PKG_DIR}/firmware/* ${INSTALL}/$(get_kernel_overlay_dir)/lib/firmware/ap6611s/

  mkdir -p ${INSTALL}/usr/bin
  cp ${PKG_DIR}/bin/* ${INSTALL}/usr/bin/brcm_patchram_plus
  chmod +x ${INSTALL}/usr/bin/brcm_patchram_plus

  mkdir -p ${INSTALL}/usr/lib/systemd/system/
  cp ${PKG_DIR}/ap6611s-bluetooth.service ${INSTALL}/usr/lib/systemd/system/

  

}

post_install() {
  enable_service ap6611s-bluetooth.service
}

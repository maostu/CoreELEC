# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)
# Copyright (C) 2018-present Team CoreELEC (https://coreelec.org)

PKG_NAME="sispmctl"
PKG_VERSION="4.2"
PKG_SHA256="300adc32ab35a4f9260705f8f57ccd83c3c6601fc493dbe7d259335938819aaf"
PKG_VERSION_NUMBER="4.2"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="http://sispmctl.sourceforge.net/"
PKG_URL="https://sourceforge.net/projects/sispmctl/files/$PKG_NAME/$PKG_NAME-$PKG_VERSION/$PKG_NAME-$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain libusb"
PKG_SECTION="tools"
PKG_SHORTDESC="SiS-PM  (Silver Shield PM) Control for Linux"
PKG_LONGDESC="SiS-PM  (Silver Shield PM) Control for Linux ($PKG_VERSION_NUMBER): is a command line tool that activates or deactivates distinct power sockets of a gembird multiple socket outlet"

PKG_IS_ADDON="yes"
PKG_ADDON_NAME="SiS-PM  (Silver Shield PM) Control for Linux"
PKG_ADDON_TYPE="xbmc.service"

post_unpack() {
  echo "Operating in directory:"
  pwd
}

pre_configure_target() {
  PKG_CONFIGURE_OPTS_TARGET="--prefix=/usr"
# fails to build in subdirs
  cd $PKG_BUILD
  rm -rf .$TARGET_NAME
  export CROSS_COMPILE="$TARGET_PREFIX"
  export CFLAGS="$CFLAGS -I$SYSROOT_PREFIX/usr/include/iconv -L$SYSROOT_PREFIX/usr/lib/iconv"
}

#post_make_target() {
#
#}

#makeinstall_target() {
#  :
#}

addon() {
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin/
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/lib/
  cp -L $(get_build_dir sispmctl)/.install_pkg/usr/bin/* $ADDON_BUILD/$PKG_ADDON_ID/bin
  cp -L $(get_build_dir sispmctl)/.install_pkg/usr/lib/* $ADDON_BUILD/$PKG_ADDON_ID/lib
}

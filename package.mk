PKG_NAME="open-zwave.switchall"
PKG_VERSION="1.4"
PKG_REV="0"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/OpenZWave/open-zwave"
PKG_URL="https://github.com/OpenZWave/open-zwave/archive/v$PKG_VERSION.tar.gz"
PKG_NEED_UNPACK="yes"
PKG_DEPENDS_TARGET="gcc"
PKG_PRIORITY="optional"
PKG_SECTION="script"
PKG_SHORTDESC="Switches all Z-Wave nodes off/on"
PKG_LONGDESC="Simple script to switch all Z-Wave nodes off/on. Based on free software library that interfaces with selected Z-Wave PC controllers, allowing anyone to create applications that manipulate and respond to devices on a Z-Wave network, without requiring in-depth knowledge of the Z-Wave protocol."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="xbmc.python.script"
ADDON_PKG_PROVIDES=""
PKG_ADDON_REPOVERSION="6.0"

PKG_AUTORECONF="no"

unpack() {
  echo 'Unpacking files...'
  tar -xvzf $ROOT/$SOURCES/$PKG_NAME/v$PKG_VERSION.tar.gz -C $ROOT/$BUILD 
  mv $ROOT/$BUILD/open-zwave-1.4 $ROOT/$BUILD/$PKG_NAME-$PKG_VERSION

  cp -r $PKG_DIR/app/ $PKG_BUILD
}

pre_configure_target() {
  echo 'pre_configure_target()'
  # fails to build in subdirs
  # cd $ROOT/$PKG_BUILD
  # rm -rf .$TARGET_NAME
}

make_target() {
  echo 'make_target()'
  echo 'Building openzwave lib...'
  make ARCH=$TARGET_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX

  echo 'Building the app...'  
  cd app
  make ARCH=$TARGET_ARCH \
       CROSS_COMPILE=$TARGET_PREFIX \
       SRC_DIR=$ROOT/$PKG_BUILD

}

makeinstall_target() {
  echo 'makeinstall_target()'
  # echo $INSTALL # /home/osboxes/OpenELEC.tv/build.OpenELEC-RPi2.arm-8.0-devel/open-zwave-1.4/.install_pkg
  # mkdir -p $INSTALL/usr/lib
  # cp -P $ROOT/$PKG_BUILD/libopenzwave.so.1.4 $INSTALL/usr/lib
}

addon() {
  echo 'addon()'
  #pwd
  #echo $ADDON_BUILD # build.OpenELEC-RPi2.arm-8.0-devel/addons/open-zwave
  echo $PKG_ADDON_ID # service.multimedia.open-zwave
  echo $PKG_BUILD # build.OpenELEC-RPi2.arm-8.0-devel/open-zwave-1.4
  mkdir -p $ADDON_BUILD/$PKG_ADDON_ID/bin
  echo 'Copying additional files...'
  cp -P $PKG_BUILD/libopenzwave.so.1.4 $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/libopenzwave.so $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/libopenzwave.a $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -r $PKG_BUILD/config/ $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/.lib/* $ADDON_BUILD/$PKG_ADDON_ID/bin/
  cp -P $PKG_BUILD/app/ozw-power-on-off.* $ADDON_BUILD/$PKG_ADDON_ID/bin/
  echo 'Removing unused files...'
  find $ADDON_BUILD/$PKG_ADDON_ID -name "~*" -delete
}

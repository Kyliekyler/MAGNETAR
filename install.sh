#   _____ __________ _____ ____ _____ _________
#  |     | _  |   __|   | |  __|_   _| _  | __ |
#  | | | |    |  |  | | | |  __| | | |    |   -|
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__|
#                      by Kyliekyler © 2019-2023

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//

print_modname() { :; }

require_new_magisk() {
  ui_print "- PLEASE INSTALL MAGISK VERSION 23 OR NEWER!"
  exit 1
}

require_new_ksu() {
  ui_print "- PLEASE INSTALL KERNELSU VERSION 10575 OR NEWER!"
  exit 1
}

on_install() {
  if ! $BOOTMODE; then
    recovery_actions > /dev/null 2>&1
    abort "- INSTALLATION FROM RECOVERY NOT SUPPORTED!"
  fi

  if [ -n "$KSU_KERNEL_VER_CODE" ] && [ "$KSU_KERNEL_VER_CODE" -lt "10575" ]; then
    require_new_ksu
  elif [ "$MAGISK_VER_CODE" -lt "23000" ]; then
    require_new_magisk
  fi

  [ "$ARCH" = "arm64" ] || abort "- $(awk -v var="$ARCH" 'BEGIN{print toupper(var)}') NOT SUPPORTED!"

  rm -rf $TMPDIR
  mkdir -p $TMPDIR
  chcon u:object_r:system_file:s0 $TMPDIR
  cd $TMPDIR || abort "- UNABLE TO CHANGE DIRECTORY"

  ensure_bb
  mount_partitions > /dev/null 2>&1
  boot_actions

  unzip -o "$ZIPFILE" module.prop -d $TMPDIR >&2
  [ ! -f $TMPDIR/module.prop ] && abort "- UNABLE TO EXTRACT ZIP FILE!"

  rm -rf $MODPATH

  RDM=$(tr < /dev/urandom -cd 'A-F0-9' | head -c 8)
  sed -i "s/.*id=.*/id=$RDM/" $TMPDIR/module.prop

  MODID=$(grep_prop id $TMPDIR/module.prop)
  MODPATH=$MODULEROOT/$MODID

  mkdir -p $MODPATH

  unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >&2

  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/install 0 0 0755 0755

  [ -f "$MODPATH/install" ] && $MODPATH/install "$MODPATH"

  rm -rf \
    $MODPATH/LICENSE $MODPATH/install* \
    $MODPATH/*.json $MODPATH/*.md \
    $MODPATH/.git* $MODPATH/resources* \
    $MODPATH/dependencies* 2> /dev/null

  cd /
  rm -rf $TMPDIR

  exit 0
}

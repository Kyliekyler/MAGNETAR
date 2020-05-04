#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2020

#==========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#==========================================================================//

# FUNCTIONS ===============================================================//
abort() {
  ui_print "$1"
  rm -rf $MODPATH 2>/dev/null
  cleanup
  rm -rf $TMPDIR 2>/dev/null
  exit 1
}

cleanup() {
  rm -rf $MODPATH/.M4GN3T4R 2>/dev/null
  rm -rf $MODPATH/M4GN3T00L 2>/dev/null
  rm -f $MODPATH/$UID 2>/dev/null
}

install_script() {
  case "$1" in
    -l) 
      shift; local INPATH=$NVBASE/service.d
    ;;
    *) 
      local INPATH=$NVBASE/service.d
    ;;
  esac
  [ "$(grep "#!/system/bin/sh" $1)" ] || sed -i "1i #!/system/bin/sh" $1
  local i; for i in "MODPATH" "LIBDIR" "MODID" "INFO" "MODDIR"; do
    case $i in
      "MODPATH")
        sed -i "1a $i=$NVBASE/modules/$MODID" $1
      ;;
      "MODDIR")
        sed -i "1a $i=\${0%/*}" $1
      ;;
      *) 
        sed -i "1a $i=$(eval echo \$$i)" $1
      ;;
    esac
  done
  [ "$1" == "$MODPATH/uninstall.sh" ] && return 0
  case $(basename $1) in
    service.sh) 
    ;;
    *)
      cp -n $1 $INPATH/$(basename $1) 0755
    ;;
  esac
}

magnevars() {
  UID=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 8)
  VER=$(grep_prop version $MODPATH/module.prop)
  REL=$(grep_prop versionCode $MODPATH/module.prop)
  TAG=$(grep_prop tag $MODPATH/module.prop)
  ABILONG=$(grep_prop ro.product.cpu.abi)
  ABI64=$(echo $ABILONG | grep arm64)
  ABI32=$(echo $ABILONG | grep armeabi)
  SYS=/system
}

magneprint() {
  ui_print " "
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××" 
  ui_print "  _____ __________ _____ ____ _____ _________  "
  ui_print " |     | _  |   __|   | |  __|_   _| _  | __ | "
  ui_print " | | | |    |  |  | | | |  __| | | |    |   -| "
  ui_print " |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| "
  ui_print "                          by Kyliekyler © 2020 "     
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
  ui_print "  MODULE VER  | $VER"
  ui_print "  MODULE ID   | $REL$TAG"
  ui_print "  DEVICE SDK  | $API"
  ui_print "  DEVICE ABI  | $(echo $ABILONG | tr a-z A-Z)"
  ui_print "  UNIQUE ID   | $UID"
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××" 
  ui_print " "
  ui_print "- INSTALLING..."
}

magnetar() {
  magneprint
  ui_print " "
  ui_print "- COPYING FILES..."  
  mkdir -p $MODPATH$SYS/etc/$UID $MODPATH$SYS/etc/$UID/FILES $MODPATH$SYS/lib/egl $MODPATH$SYS/lib64/egl $MODPATH$SYS/vendor/bin $MODPATH$SYS/vendor/etc $MODPATH$SYS/etc/.tp
  mv -f $MODPATH/.M4GN3T4R/.M4GN3T4RA $MODPATH$SYS/etc/$UID/"$UID"a
  mv -f $MODPATH/.M4GN3T4R/.M4GN3T4RB $MODPATH$SYS/etc/$UID/"$UID"b
  mv -f $MODPATH/.M4GN3T4R/.M4GN3T4R1 $MODPATH$SYS/etc/$UID/FILES/"$UID"1
  mv -f $MODPATH/.M4GN3T4R/.M4GN3T4R2 $MODPATH$SYS/etc/$UID/FILES/"$UID"2
  mv -f $MODPATH/.M4GN3T4R/.M4GN3T4R3 $MODPATH$SYS/etc/$UID/FILES/"$UID"3
  mv -f $MODPATH/.M4GN3T4R/.M4GN3T4R4 $MODPATH$SYS/etc/$UID/FILES/"$UID"4  
  echo "$UID" > $MODPATH/$UID
  if [ -e $SYS/vendor/bin/thermal-engine ]; then
    cp -rf $MODPATH/$UID $MODPATH$SYS/vendor/bin/thermal-engine
  fi  
  for i in $SYS/vendor/etc/thermal*; do
    cp -rf $MODPATH/$UID $MODPATH$i
  done  
  for i in $SYS/etc/.tp/thermal*; do
    cp -rf $MODPATH/$UID $MODPATH$i
  done  
  if [ -e $SYS/lib/egl/egl.cfg ] || [ -e $SYS/lib64/egl/egl.cfg ]; then
    cp -rf $MODPATH/$UID $MODPATH$SYS/lib/egl/egl.cfg
    cp -rf $MODPATH/$UID $MODPATH$SYS/lib64/egl/egl.cfg
  fi
  case $ABILONG in
    $ABI64) 
      mkdir -p $MODPATH$SYS/bin
      mv -f $MODPATH/M4GN3T00L/M4GN3T00L64 $MODPATH$SYS/bin/aapt
      rm -f $MODPATH/M4GN3T00L/M4GN3T00L32
    ;;
    $ABI32)
      mkdir -p $MODPATH$SYS/bin
      mv -f $MODPATH/M4GN3T00L/M4GN3T00L32 $MODPATH$SYS/bin/aapt
      rm -f $MODPATH/M4GN3T00L/M4GN3T00L64
    ;;
  esac  
  for i in "UID"; do
    if [ -e $MODPATH/module.prop ]; then
      sed -i "8i $i=$(eval echo \$$i)" $MODPATH/module.prop
    fi
    if [ -e $MODPATH/uninstall.sh ]; then
      sed -i "11i $i=$(eval echo \$$i)" $MODPATH/uninstall.sh
    fi
    if [ -e $MODPATH/service.sh ]; then
      sed -i "11i $i=$(eval echo \$$i)" $MODPATH/service.sh
    fi
  done  
  ui_print " "
  ui_print "- CREATING LOG DIR..."
  i=0
  if [ -d /storage/emulated/0/MAGNETAR ]; then
    ui_print "  DONE, LOG DIR ALREADY EXISTING"
    rm -f /storage/emulated/0/MAGNETAR/magne.log
    rm -f /storage/emulated/0/MAGNETAR/mode.txt
  else
    if [ ! -d /storage/emulated/0/MAGNETAR ]; then
      while [ ! -d /storage/emulated/0/MAGNETAR ]; do
        if [ ! -d /storage/emulated/0/MAGNETAR ]; then
           mkdir -p /storage/emulated/0/MAGNETAR
           if [ -d /storage/emulated/0/MAGNETAR ]; then
             ui_print "  DONE"
             break
          fi 
        fi
        i=$(($i+1))  
        if [ $i -gt "10" ]; then
          ui_print "  FAILED TO CREATE LOG DIR"
          ui_print "  CREATE MAGNETAR FOLDER ON INTERNAL BEFORE REBOOTING"
          break
        fi   
      done
    fi
  fi
}

# SET VARIABLES ===========================================================//
INFO=$NVBASE/modules/.$MODID-files
LIBDIR=/system

if ! $BOOTMODE; then
  ui_print "- ONLY UNINSTALL IS SUPPORTED IN RECOVERY"
  ui_print "  UNINSTALLING..."
  touch $MODPATH/remove
  [ -s $INFO ] && install_script $MODPATH/uninstall.sh || rm -f $INFO $MODPATH/uninstall.sh
  recovery_cleanup
  cleanup
  rm -rf $NVBASE/modules_update/$MODID $TMPDIR 2>/dev/null
  exit 0
fi

# EXTRACT FILES ===========================================================//
ui_print " "
ui_print "- EXTRACTING MODULE FILES..."
unzip -o "$ZIPFILE" -x 'META-INF/*' '.M4GN3T4R/M4GN3T4R_functions.sh' -d $MODPATH >&2
[ -f "$MODPATH/.M4GN3T4R/.m4gn3.tar.xz" ] && tar -xf $MODPATH/.M4GN3T4R/.m4gn3.tar.xz -C $MODPATH 2>/dev/null

# REMOVE FILES OUTSIDE MODULE DIRECTORY ===================================//
if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi

# INSTALL =================================================================//
magnevars
[ -f "$MODPATH/.M4GN3T4R/M4GN3T4R_INSTALL.sh" ] && . $MODPATH/.M4GN3T4R/M4GN3T4R_INSTALL.sh

# REMOVE COMMENTS ADD BLANK LINE IN THE END ===============================//
for i in $(find $MODPATH -type f -name "*.sh" -o -name "*.prop" -o -name "*.rule"); do
  [ -f $i ] && { sed -i -e "/^#/d" -e "/^ *$/d" $i; [ "$(tail -1 $i)" ] && echo "" >> $i; } || continue
  case $i in
    "$MODPATH/service.sh") 
      install_script -l $i
    ;;
    "$MODPATH/uninstall.sh") 
      if [ -s $INFO ] || [ "$(head -n1 $MODPATH/uninstall.sh)" != "# Don't modify anything after this" ]; then
        install_script $MODPATH/uninstall.sh
      else
        rm -f $INFO $MODPATH/uninstall.sh
      fi
    ;;
  esac
done

# SET PERMISSIONS =========================================================//
ui_print "- SETTING PERMISSIONS..."
set_perm_recursive $MODPATH 0 0 0755 0644
set_perm_recursive $MODPATH/service.sh 0 0 0755 0777
set_perm_recursive $MODPATH/system/bin/aapt 0 2000 0755 0777
set_perm_recursive $MODPATH/system/etc/$UID/"$UID"a 0 0 0755 0755
set_perm_recursive $MODPATH/system/etc/$UID/"$UID"b 0 0 0755 0755
set_perm_recursive $MODPATH/system/etc/$UID/FILES/"$UID"1 0 0 0755 0755
set_perm_recursive $MODPATH/system/etc/$UID/FILES/"$UID"2 0 0 0755 0755
set_perm_recursive $MODPATH/system/etc/$UID/FILES/"$UID"3 0 0 0755 0755
set_perm_recursive $MODPATH/system/etc/$UID/FILES/"$UID"4 0 0 0755 0755
ui_print "  DONE"

# COMPLETE INSTALL ========================================================//
ui_print " "
ui_print "- MAGNETAR INSTALLATION COMPLETE!"
cleanup

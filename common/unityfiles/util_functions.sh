#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019    

#==========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#==========================================================================//

# HELPER FUNCTIONS ========================================================//
ui_print() {
  $BOOTMODE && echo "$1" || echo -e "ui_print $1\nui_print" >> /proc/self/fd/$OUTFD
}

toupper() {
  echo "$@" | tr '[:lower:]' '[:upper:]'
}

grep_cmdline() {
  local REGEX="s/^$1=//p"
  cat /proc/cmdline | tr '[:space:]' '\n' | sed -n "$REGEX" 2>/dev/null
}

grep_prop() {
  local REGEX="s/^$1=//p"
  shift
  local FILES=$@
  [ -z "$FILES" ] && FILES='/system/build.prop'
  sed -n "$REGEX" $FILES 2>/dev/null | head -n 1
}

is_mounted() {
  grep -q " `readlink -f $1` " /proc/mounts 2>/dev/null
  return $?
}

abort() {
  ui_print "$1"
  $MAGISK && ! imageless_magisk && is_mounted $MOUNTPATH && unmount_magisk_img
  $BOOTMODE || recovery_cleanup
  $DEBUG && debug_log
  exit 1
}

# ENVIRONMENT RELATED =====================================================//
setup_flashable() {
  # PRESERVE ENVIRONMENT VARIBLES =========================================//
  OLD_PATH=$PATH
  ensure_bb
  $BOOTMODE && return
  if [ -z $OUTFD ] || readlink /proc/$$/fd/$OUTFD | grep -q /tmp; then
    # WE WILL HAVE TO MANUALLY FIND OUT OUTFD =============================//
    for FD in `ls /proc/$$/fd`; do
      if readlink /proc/$$/fd/$FD | grep -q pipe; then
        if ps | grep -v grep | grep -q " 3 $FD "; then
          OUTFD=$FD
          break
        fi
      fi
    done
  fi
}

ensure_bb() {
  ARCH32=`getprop ro.product.cpu.abi | cut -c-3`
  [ -z $ARCH32 ] && ARCH32=`getprop ro.product.cpu.abi2 | cut -c-3`
  [ -z $ARCH32 ] && ARCH32=arm
  if [ -x $MAGISKTMP/busybox/busybox ]; then
    [ -z $BBDIR ] && BBDIR=$MAGISKTMP/busybox
  elif [ -x $TMPDIR/bin/busybox ]; then
    [ -z $BBDIR ] && BBDIR=$TMPDIR/bin
  else
    [ -z $BBDIR ] && BBDIR=$TMPDIR/bin
    mkdir -p $BBDIR 2>/dev/null
    cp -f $UF/tools/$ARCH32/busybox $BBDIR/busybox 2>/dev/null
    chmod 755 $BBDIR/busybox
    $BBDIR/busybox --install -s $BBDIR
  fi
  echo $PATH | grep -q "^$BBDIR" || export PATH=$BBDIR:$PATH
}

recovery_actions() {
  # MAKE SURE RANDOM DON'T GET BLOCKED ====================================//
  mount -o bind /dev/urandom /dev/random
  # UNSET LIBRARY PATHS ===================================================//
  OLD_LD_LIB=$LD_LIBRARY_PATH
  OLD_LD_PRE=$LD_PRELOAD
  OLD_LD_CFG=$LD_CONFIG_FILE
  unset LD_LIBRARY_PATH
  unset LD_PRELOAD
  unset LD_CONFIG_FILE
  # FORCE OUR OWN BUSYBOX PATH TO BE IN THE FRONT =========================//
  # AND DO NOT USE ANYTHING IN RECOVERY'S SBIN ============================//
  export PATH=$BBDIR:/system/bin:/vendor/bin
}

recovery_cleanup() {
  [ -z $OLD_PATH ] || export PATH=$OLD_PATH
  [ -z $OLD_LD_LIB ] || export LD_LIBRARY_PATH=$OLD_LD_LIB
  [ -z $OLD_LD_PRE ] || export LD_PRELOAD=$OLD_LD_PRE
  [ -z $OLD_LD_CFG ] || export LD_CONFIG_FILE=$OLD_LD_CFG
  ui_print "- UNMOUNTING PARTITIONS"
  [ "$supersuimg" -o -d /su ] && umount /su 2>/dev/null
  umount -l /system_root 2>/dev/null
  umount -l /system 2>/dev/null
  umount -l /vendor 2>/dev/null
  umount -l /dev/random 2>/dev/null
}

debug_log() {
  set +x
  echo -e "***---Device Info---***" > /sdcard/$MODID-debug-tmp.log
  echo -e "\n---Props---\n" >> /sdcard/$MODID-debug-tmp.log
  getprop >> /sdcard/$MODID-debug-tmp.log
  if $MAGISK; then
    echo -e "\n\n***---Magisk Info---***" >> /sdcard/$MODID-debug-tmp.log
    echo -e "\n---Magisk Version---\n\n$MAGISK_VER_CODE" >> /sdcard/$MODID-debug-tmp.log
    imageless_magisk && { echo -e "\n---Installed Modules---\n" >> /sdcard/$MODID-debug-tmp.log;
                                        ls $NVBASE/modules >> /sdcard/$MODID-debug-tmp.log; }
    echo -e "\n---Last Magisk Log---\n" >> /sdcard/$MODID-debug-tmp.log
    [ -d /cache ] && cat /cache/magisk.log >> /sdcard/$MODID-debug-tmp.log || cat /data/cache/magisk.log >> /sdcard/$MODID-debug-tmp.log
  fi
  echo -e "\n\n***---Unity Debug Info---***" >> /sdcard/$MODID-debug-tmp.log
  echo -e "\n---Installed Files---\n" >> /sdcard/$MODID-debug-tmp.log
  grep "^+* cp_ch" /sdcard/$MODID-debug.log | sed 's/.* //g' >> /sdcard/$MODID-debug-tmp.log
  sed -i "\|$TMPDIR/|d" /sdcard/$MODID-debug-tmp.log
  echo -e "\n---Installed Boot Scripts---\n" >> /sdcard/$MODID-debug-tmp.log
  grep "^+* install_script" /sdcard/$MODID-debug.log | sed -e 's/.* //g' -e 's/^-.* //g' >> /sdcard/$MODID-debug-tmp.log
  echo -e "\n---Installed Prop Files---\n" >> /sdcard/$MODID-debug-tmp.log
  grep "^+* prop_process" /sdcard/$MODID-debug.log | sed 's/.* //g' >> /sdcard/$MODID-debug-tmp.log
  echo -e "\n---Shell & Unity Variables---\n" >> /sdcard/$MODID-debug-tmp.log
  (set) >> /sdcard/$MODID-debug-tmp.log
  echo -e "\n---(Un)Install Log---\n" >> /sdcard/$MODID-debug-tmp.log
  echo "$(cat /sdcard/$MODID-debug.log)" >> /sdcard/$MODID-debug-tmp.log
  mv -f /sdcard/$MODID-debug-tmp.log /sdcard/$MODID-debug.log
}

cleanup() {
  cd /
  [ -d "$RD" ] && repack_ramdisk
  if $MAGISK; then
    imageless_magisk || unmount_magisk_img
    
  fi
  $BOOTMODE || recovery_cleanup
  
  $DEBUG && debug_log
  [ -d "$TMPDIR/addon/Aroma-Installer" ] && { rm -rf $TMPDIR; sleep 3; reboot recovery; } || { rm -rf $TMPDIR; exit 0; }
}

find_block() {
  for BLOCK in "$@"; do
    DEVICE=`find /dev/block -type l -iname $BLOCK | head -n 1` 2>/dev/null
    if [ ! -z $DEVICE ]; then
      readlink -f $DEVICE
      return 0
    fi
  done
  # FALLBACK BY PARSING SYSFS UEVENTS =====================================//
  for uevent in /sys/dev/block/*/uevent; do
    local DEVNAME=`grep_prop DEVNAME $uevent`
    local PARTNAME=`grep_prop PARTNAME $uevent`
    for BLOCK in "$@"; do
      if [ "`toupper $BLOCK`" = "`toupper $PARTNAME`" ]; then
        echo /dev/block/$DEVNAME
        return 0
      fi
    done
  done
  return 1
}

mount_part() {
  local PART=$1
  local POINT=/${PART}
  [ -L $POINT ] && rm -f $POINT
  mkdir $POINT 2>/dev/null
  is_mounted $POINT && return
  ui_print "- MOUNTING $PART"
  mount -o rw $POINT 2>/dev/null
  if ! is_mounted $POINT; then
    local BLOCK=`find_block $PART$SLOT`
    mount -o rw $BLOCK $POINT
  fi
  is_mounted $POINT || abort "- CANNOT MOUNT $POINT"
}

mount_partitions() {
  # CHECK A/B SLOT ========================================================//
  SLOT=grep_cmdline androidboot.slot_suffix
  if [ -z $SLOT ]; then
    SLOT=grep_cmdline androidboot.slot
    [ -z $SLOT ] || SLOT=_${SLOT}
  fi
  [ -z $SLOT ] || ui_print "- CURRENT BOOT SLOT: $SLOT"

  mount_part system
  if [ -f /system/init.rc ]; then
    SYSTEM_ROOT=true
    [ -L /system_root ] && rm -f /system_root
    mkdir /system_root 2>/dev/null
    mount --move /system /system_root
    mount -o bind /system_root/system /system
  else
    grep -qE '/dev/root|/system_root' /proc/mounts && SYSTEM_ROOT=true || SYSTEM_ROOT=false
  fi
  [ -L /system/vendor ] && mount_part vendor
  $SYSTEM_ROOT && ui_print "- DEVICE IS SYSTEM-AS-ROOT"
}

api_level_arch_detect() {
  API=`grep_prop ro.build.version.sdk`
  ABI=`grep_prop ro.product.cpu.abi | cut -c-3`
  ABI2=`grep_prop ro.product.cpu.abi2 | cut -c-3`
  ABILONG=`grep_prop ro.product.cpu.abi`

  ARCH=arm 
  ARCH32=arm
  IS64BIT=false
  if [ "$ABI" = "x86" ]; then ARCH=x86; ARCH32=x86; fi;
  if [ "$ABI2" = "x86" ]; then ARCH=x86; ARCH32=x86; fi;
  if [ "$ABILONG" = "arm64-v8a" ]; then ARCH=arm64; ARCH32=arm; IS64BIT=true; fi;
  if [ "$ABILONG" = "x86_64" ]; then ARCH=x64; ARCH32=x86; IS64BIT=true; fi;
}

supersuimg_mount() {
  supersuimg=$(ls /cache/su.img /data/su.img 2>/dev/null)
  if [ "$supersuimg" ]; then
    if ! is_mounted /su; then
      ui_print "- MOUNTING /SU"
      [ -d /su ] || mkdir /su 2>/dev/null
      mount -t ext4 -o rw,noatime $supersuimg /su 2>/dev/null
      for i in 0 1 2 3 4 5 6 7; do
        is_mounted /su && break
        local loop=/dev/block/loop$i
        mknod $loop b 7 $i
        losetup $loop $supersuimg
        mount -t ext4 -o loop $loop /su 2>/dev/null
      done
    fi
  fi
}

device_check() {
  local PROP=$(echo "$1" | tr '[:upper:]' '[:lower:]')
  for i in "ro.product.device" "ro.build.product"; do
    [ "$(sed -n "s/^$i=//p" /system/build.prop 2>/dev/null | head -n 1 | tr '[:upper:]' '[:lower:]')" == "$PROP" -o "$(sed -n "s/^$i=//p" $VEN/build.prop 2>/dev/null | head -n 1 | tr '[:upper:]' '[:lower:]')" == "$PROP" ] && return 0
  done
  return 1
}

api_check() {
  local OPT=`getopt -o nx -- "$@"` TAPI=$2
  eval set -- "$OPT"
  while true; do
    case "$1" in
      -n) [ $API -lt $TAPI ] && abort "- YOUR SYSTEM API OF $API IS LESS THAN THE MINIMUM API OF $2! ABORTING!"; shift;;
      -x) [ $API -gt $TAPI ] && abort "- YOUR SYSTEM API OF $API IS GREATER than thE MAXIMUM API OF $2! ABORTING!"; shift;;
      --) shift; break;;
    esac
  done
}

set_vars() {
  echo $PATH | grep -q "^$UF/tools/$ARCH32" || export PATH=$UF/tools/$ARCH32:$PATH
  if $MAGISK; then
    imageless_magisk && MOUNTEDROOT=$NVBASE/modules || MOUNTEDROOT=$MAGISKTMP/img
    if $BOOTMODE; then
      MOD_VER="$MOUNTEDROOT/$MODID/module.prop"
      ORIGDIR="$MAGISKTMP/mirror"
    else
      MOD_VER="$MODPATH/module.prop"
    fi
    INFO="$MODPATH/$MODID-files"; PROP=$MODPATH/system.prop; UNITY="$MODPATH"
    local ROOTTYPE="MAGISKSU"
  fi
  if $SYSTEM_ROOT && [ ! -L /system/vendor ]; then
    ORIGVEN=$ORIGDIR/system_root/system/vendor
  else
    ORIGVEN=$ORIGDIR/vendor
  fi
  SYS=/system; VEN=/system/vendor; RD=$UF/boot/ramdisk; INFORD="$RD/$MODID-files"; SHEBANG="#!/system/bin/sh"
  [ $API -lt 26 ] && DYNLIB=false
  $DYNLIB && { LIBPATCH="\/vendor"; LIBDIR=$VEN; } || { LIBPATCH="\/system"; LIBDIR=/system; }  
  if ! $MAGISK || $SYSOVER; then
    UNITY=""
    [ -d /system/addon.d ] && INFO=/system/addon.d/$MODID-files || INFO=/system/etc/$MODID-files
    [ -L /system/vendor ] && { VEN=/vendor; $BOOTMODE && ORIGVEN=$ORIGDIR/vendor; }
    if ! $MAGISK; then
      # DETERMINE SYSTEM BOOT SCRIPT TYPE =================================//
      supersuimg_mount
      MOD_VER="/system/etc/$MODID-module.prop"; NVBASE=/system/etc/init.d; ROOTTYPE="Rootless/other root"
      if [ "$supersuimg" ] || [ -d /su ]; then
        SHEBANG="#!/su/bin/sush"; ROOTTYPE="SYSTEMLESS SUPERSU"; NVBASE=/su/su.d
      elif [ -e "$(find /data /cache -name supersu_is_here | head -n1)" ]; then
        SHEBANG="#!/su/bin/sush"; ROOTTYPE="SYSTEMLESS SUPERSU"
        NVBASE=$(dirname `find /data /cache -name supersu_is_here | head -n1` 2>/dev/null)/su.d
      elif [ -d /system/su ] || [ -f /system/xbin/daemonsu ] || [ -f /system/xbin/sugote ]; then
        NVBASE=/system/su.d; ROOTTYPE="SYSTEM SUPERSU"
      elif [ -f /system/xbin/su ]; then
        [ "$(grep SuperSU /system/xbin/su)" ] && { NVBASE=/system/su.d; ROOTTYPE="SYSTEM SUPERSU"; } || ROOTTYPE="LINEAGEOS SU"
      fi
      PROP=$NVBASE/$MODID-props
    fi
  fi
  ui_print "- $ROOTTYPE DETECTED"
}

# Module Related ==========================================================//
set_perm() {
  chown $2:$3 $1 || return 1
  chmod $4 $1 || return 1
  local CON=$5
  [ -z $CON ] && local CON=u:object_r:system_file:s0
  chcon $CON $1 || return 1
}

set_perm_recursive() {
  find $1 -type d 2>/dev/null | while read dir; do
    set_perm $dir $2 $3 $4 $6
  done
  find $1 -type f -o -type l 2>/dev/null | while read file; do
    set_perm $file $2 $3 $5 $6
  done
}

mktouch() {
  mkdir -p ${1%/*} 2>/dev/null
  [ -z $2 ] && touch $1 || echo $2 > $1
  chmod 644 $1
}

run_addons() {
  local OPT=`getopt -o mhiuv -- "$@"` NAME PNAME
  eval set -- "$OPT"
  while true; do
    case "$1" in
      -m) NAME=main; shift;;
      -h) NAME=preinstall; PNAME="PREINSTALL"; shift;;
      -i) NAME=install; PNAME="INSTALL"; shift;;
      -u) NAME=uninstall; PNAME="UNINSTALL"; shift;;
      -v) NAME=postuninstall; PNAME="POSTUNINSTALL"; shift;;
      --) shift; break;;
    esac
  done
  if [ "$(ls -A $TMPDIR/addon/*/$NAME.sh 2>/dev/null)" ]; then
    [ -z $PNAME ] || { ui_print " "; ui_print "- RUNNING $PNAME ADDONS..."; }
    for i in $TMPDIR/addon/*/$NAME.sh; do
      ui_print " "
      ui_print "- RUNNING $(echo $i | sed -r "s|$TMPDIR/addon/(.*)/$NAME.sh|\1|" | tr a-z A-Z)..."
      . $i
    done
    [ -z $PNAME ] || { ui_print " "; ui_print "- `echo $PNAME`ING..."; }
  fi
}

cp_ch() {
  local OPT=`getopt -o inr -- "$@"` BAK=true UBAK=true REST=true BAKFILE=$INFO FOL=false
  eval set -- "$OPT"
  while true; do
    case "$1" in
      -i) UBAK=false; REST=false; shift;;
      -n) UBAK=false; shift;;
      -r) FOL=true; shift;;
      --) shift; break;;
    esac
  done
  local SRC="$1" DEST="$2" OFILES="$1"
  $FOL && OFILES=$(find $SRC -type f 2>/dev/null)
  [ -z $3 ] && PERM=0644 || PERM=$3
  case "$DEST" in
    $RD/*) BAKFILE=$INFORD;;
    $TMPDIR/*|/data/adb/*|$MODULEROOT/*|/sbin/.magisk/img/*) BAK=false;;
  esac
  for OFILE in ${OFILES}; do
    if $FOL; then
      if [ "$(basename $SRC)" == "$(basename $DEST)" ]; then
        local FILE=$(echo $OFILE | sed "s|$SRC|$DEST|")
      else
        local FILE=$(echo $OFILE | sed "s|$SRC|$DEST/$(basename $SRC)|")
      fi
    else
      [ -d "$DEST" ] && local FILE="$DEST/$(basename $SRC)" || local FILE="$DEST"
    fi
    if $BAK; then
      if $UBAK && $REST; then
        [ ! "$(grep "$FILE$" $BAKFILE 2>/dev/null)" ] && echo "$FILE" >> $BAKFILE
        [ -f "$FILE" -a ! -f "$FILE~" ] && { cp -af $FILE $FILE~; echo "$FILE~" >> $BAKFILE; }
      elif ! $UBAK && $REST; then
        [ ! "$(grep "$FILE$" $BAKFILE 2>/dev/null)" ] && echo "$FILE" >> $BAKFILE
      elif ! $UBAK && ! $REST; then
        [ ! "$(grep "$FILE\NORESTORE$" $BAKFILE 2>/dev/null)" ] && echo "$FILE\NORESTORE" >> $BAKFILE
      fi
    fi
    install -D -m $PERM "$OFILE" "$FILE"
    case $FILE in
      */vendor/*.apk) chcon u:object_r:vendor_app_file:s0 $FILE;;
      */vendor/etc/*) chcon u:object_r:vendor_configs_file:s0 $FILE;;
      */vendor/*) chcon u:object_r:vendor_file:s0 $FILE;;
      */system/*) chcon u:object_r:system_file:s0 $FILE;;
    esac
  done
}

patch_script() {
  [ -L /system/vendor ] && local VEN=/vendor
  sed -i -e "1i $SHEBANG" -e "1i SYS=$ROOT/system" -e "1i VEN=$ROOT$VEN" $1
  for i in "ROOT" "MAGISK" "LIBDIR" "SYSOVER" "DIRSEPOL" "MODID" "MOUNTEDROOT" "NVBASE"; do
    sed -i "4i $i=$(eval echo \$$i)" $1
  done
  if $MAGISK; then
    sed -i -e "s|\$MODPATH|$MOUNTEDROOT/$MODID|g" -e "s|\$MOUNTPATH|$MOUNTEDROOT|g" -e "s|\$MODULEROOT|$MOUNTEDROOT|g" -e "12i INFO=$MOUNTEDROOT/$MODID/$MODID-files" $1
  else
    sed -i -e "s|\$MODPATH||g" -e "s|\$MOUNTPATH||g" -e "s|\$MODULEROOT||g" -e "12i INFO=$INFO" $1
  fi
}

install_script() {
  case "$1" in
    -l) shift; $MAGISK && local INPATH=$NVBASE/service.d; local EXT="-ls";;
    -p) shift; $MAGISK && local INPATH=$NVBASE/post-fs-data.d; local EXT="";;
    *) local $MAGISK && local INPATH=$(dirname $2); local EXT="";;
  esac
  patch_script "$1"
  if $MAGISK; then
    case $(basename $1) in
      post-fs-data.sh|service.sh) cp_ch -n $1 $MODULEROOT/$MODID/$(basename $1);;
      *) cp_ch -n $1 $INPATH/$(basename $1) 0755;;
    esac
  else
    cp_ch -n $1 $NVBASE/$MODID-$(basename $1 | sed 's/.sh$//')$EXT 0700
  fi
}

prop_process() {
  sed -i -e "/^#/d" -e "/^ *$/d" $1
  if $MAGISK; then
    [ -f $PROP ] || mktouch $PROP
  else
    [ -f $PROP ] || mktouch $PROP "$SHEBANG"
    sed -ri "s|^(.*)=(.*)|setprop \1 \2|g" $1
  fi
  while read LINE; do
    echo "$LINE" >> $PROP
  done < $1
  $MAGISK || chmod 0700 $PROP
}

uninstall_files() {
  local FILE
  if [ -z "$1" ] || [ "$1" == "$INFO" ]; then
    FILE=$INFO
    $BOOTMODE && [ -f $MODULEROOT/$MODID/$MODID-files ] && FILE=$MODULEROOT/$MODID/$MODID-files
    $MAGISK || [ -f $FILE ] || abort "- MODULE NOT DETECTED!"
  else
    FILE="$1"
  fi
  if [ -f $FILE ]; then
    while read LINE; do
      if [ "$(echo -n $LINE | tail -c 1)" == "~" ] || [ "$(echo -n $LINE | tail -c 9)" == "NORESTORE" ]; then
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
    done < $FILE
    rm -f $FILE
  fi
}

magnevars() {
  SYS=$SYS
  VEN=$VEN
  VER=$(grep_prop version $TMPDIR/module.prop)
  REL=$(grep_prop versionCode $TMPDIR/module.prop)
  TAG=$(grep_prop tag $TMPDIR/module.prop)
  GPU=$(cat /sys/kernel/gpu/gpu_model)
  SOCV=$(cat /sys/devices/soc0/vendor)
  ABI64=$(echo $ABILONG | grep arm64)
  ABI32=$(echo $ABILONG | grep armeabi)
  MODID=$MODID
  MAGNEPATH=$SYS/etc/.$MODID
  
  if [ $(echo $SOCV | tr '[:lower:]' '[:upper:]') == "QUALCOMM" ]; then
    SOCM=$(cat /sys/devices/soc0/machine)
  else
    SOCM=$(getprop ro.board.platform)
  fi

  case $API in
    27|28|29)
      MODEL=$(getprop ro.product.vendor.model)
      CODENAME=$(getprop ro.product.vendor.device)
    ;;
    
    25|26)
      MODEL=$(getprop ro.product.model)
      CODENAME=$(getprop ro.product.device)
    ;;
  esac
}

magneprint() {
  magnevars
  ui_print " "
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"                                                 
  ui_print "  _____ __________ _____ ____ _____ _________  "
  ui_print " |     | _  |   __|   | |  __|_   _| _  | __ | "
  ui_print " | | | |    |  |  | | | |  __| | | |    |   -| "
  ui_print " |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| "
  ui_print "                          by Kyliekyler © 2019 "                                             
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
  ui_print "  MODULE ID  | $VER ($REL$TAG)"
  ui_print "  DEV MODEL  | $(echo $MODEL | tr '[:lower:]' '[:upper:]') - $(echo $CODENAME | tr '[:lower:]' '[:upper:]')"
  ui_print "  CPU MODEL  | $(echo $SOCM | tr '[:lower:]' '[:upper:]') - $(echo $ABILONG | tr '[:lower:]' '[:upper:]')"
  ui_print "  GPU MODEL  | $(echo $GPU | tr '[:lower:]' '[:upper:]')"
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"  
  sleep 0.5
}

# MAIN ====================================================================//
unity_install() {
  ui_print "- INSTALLING..."
  ui_print " "
  
  # SET VARS ==============================================================//
  magnevars
  
  # API CHECK =============================================================//
  if [ $API -lt "24" ]; then
    abort "ANDROID 6 AND LOWER DEVICE NOT SUPPORTED"
  fi

  # PREINSTALL ADDONS =====================================================//
  run_addons -h

  # MAKE INFO FILE ========================================================//
  rm -f $INFO
  mktouch $INFO

  # RUN USER INSTALL SCRIPT ===============================================//
  [ -f "$TMPDIR/common/unity_install.sh" ] && . $TMPDIR/common/unity_install.sh
  
  # INSTALL ADDONS ========================================================//
  run_addons -i
  
  # CHECK SIZES IN CASE COMPRESSION WAS USED ANYWHERE IN ZIP ==============//
  if $MAGISK && ! $SYSOVER; then
    if ! imageless_magisk; then
      request_size_check "$TMPDIR/system"
      check_filesystem $IMG $MODULEROOT
      if [ $reqSizeM -gt $curFreeM ]; then
        newSizeM=$(((curSizeM + reqSizeM - curFreeM) / 32 * 32 + 64))
        ui_print "- RESIZING $IMG TO ${newSizeM}MB"
        $MAGISKBIN/magisk imgtool umount $MODULEROOT $MAGISKLOOP
        $MAGISKBIN/magisk imgtool resize $IMG $newSizeM >&2
        mount_snippet
      fi
    fi
  fi
 
  # LOAD VARS =============================================================//
  for i in "MOUNTEDROOT" "MAGNEPATH" "ABILONG" "ABI32" "ABI64" "MODID" "SYS"; do
    if [ -e $TMPDIR$SYS/etc/.$MODID/.MAGNE.BIN ]; then
      sed -i "14i $i=$(eval echo \$$i)" $TMPDIR$SYS/etc/.$MODID/.MAGNE.BIN
    fi
  done
  
  # REMOVE COMMENTS FROM FILES ============================================//
  for i in $TMPDIR/common/sepolicy.sh $TMPDIR/common/system.prop $TMPDIR/common/service.sh $TMPDIR/common/post-fs-data.sh; do
    [ -f $i ] && sed -i -e "/^#/d" -e "/^ *$/d" $i
  done
  
  # SEPOLICY ==============================================================//
  $DIRSEPOL && [ ! -d $TMPDIR/addon/Ramdisk-Patcher ] && { ui_print "- RAMDISK-PATCHER REQUIRED BUT NOT FOUND!"; ui_print "- IT'S REQUIRED FOR DIRECT SEPOLICY PATCHING"; ui_print "  WILL USE BOOT SCRIPT INSTEAD"; DIRSEPOL=false; }
  
  if ! $DIRSEPOL && [ -s $TMPDIR/common/sepolicy.sh ]; then
    [ "$NVBASE" == "/system/etc/init.d" -o "$MAGISK" == "true" ] && echo -n "magiskpolicy --live" >> $TMPDIR/common/service.sh || echo -n "supolicy --live" >> $TMPDIR/common/service.sh
    sed -i -e '/^#.*/d' -e '/^$/d' $TMPDIR/common/sepolicy.sh
    while read LINE; do
      case $LINE in
        \"*\") echo -n " $LINE" >> $TMPDIR/common/service.sh;;
        \"*) echo -n " $LINE\"" >> $TMPDIR/common/service.sh;;
        *\") echo -n " \"$LINE" >> $TMPDIR/common/service.sh;;
        *) echo -n " \"$LINE\"" >> $TMPDIR/common/service.sh;;
      esac
    done < $TMPDIR/common/sepolicy.sh
  fi
  
  # CUSTOM UNINSTALLER ====================================================//
  $MAGISK && [ -f $TMPDIR/uninstall.sh ] && install_script $TMPDIR/uninstall.sh $MODPATH/uninstall.sh

  # HANDLE REPLACE FOLDERS ================================================//
  for TARGET in $REPLACE; do
    if $MAGISK; then mktouch $MODPATH$TARGET/.replace; else rm -rf $TARGET; fi
  done

  # PROP FILES ============================================================//
  [ -s $TMPDIR/common/.magne.prop ] && { prop_process $TMPDIR/common/.magne.prop; $MAGISK || echo $PROP >> $INFO; }

  # INSTALL POST-FS-DATA MODE SCRIPTS =====================================//
  [ -s $TMPDIR/common/post-fs-data.sh ] && install_script -p $TMPDIR/common/post-fs-data.sh

  # SERVICE MODE SCRIPTS ==================================================//
  [ -s $TMPDIR/common/service.sh ] && install_script -l $TMPDIR/common/service.sh
  
  # INSTALL FILES =========================================================//
  $IS64BIT || rm -rf $TMPDIR/system/lib64 $TMPDIR/system/vendor/lib64
  [ -d "/system/priv-app" ] || mv -f $TMPDIR/system/priv-app $TMPDIR/system/app 
  [ -d "/system/xbin" ] || mv -f $TMPDIR/system/xbin $TMPDIR/system/bin
  if $DYNLIB; then
    for FILE in $(find $TMPDIR/system/lib*/* -maxdepth 0 -type d 2>/dev/null | sed -e "s|$TMPDIR/system/lib.*/modules||" -e "s|$TMPDIR/system/||"); do
      mkdir -p $(dirname $TMPDIR/system/vendor/$FILE)
      mv -f $TMPDIR/system/$FILE $TMPDIR/system/vendor/$FILE
    done
  fi
  rm -f $TMPDIR/system/placeholder
  cp_ch -r $TMPDIR/system $UNITY/system
  # INSTALL ROM BACKUP SCRIPT =============================================//
  if [ "$INFO" == "/system/addon.d/$MODID-files" ]; then
    ui_print "- INSTALLING ADDON.D BACKUP SCRIPT..."
    sed -i "s/MODID=.*/MODID=$MODID/" $TMPDIR/common/unityfiles/addon.sh
    cp_ch -n $TMPDIR/common/unityfiles/addon.sh $UNITY/system/addon.d/98-$MODID-unity.sh 0755
  fi
  
  # INSTALL SCRIPTS AND MODULE INFO =======================================//
  cp_ch -n $TMPDIR/module.prop $MOD_VER
  if $MAGISK; then
    # AUTO MOUNT ==========================================================//
    if [ -d $MODPATH/system ] && ! $SYSOVER; then
      if imageless_magisk; then
        if $SKIPMOUNT || [ ! -d $MODPATH/system ]; then touch $MODPATH/skip_mount; fi
      else
        $SKIPMOUNT || touch $MODPATH/auto_mount
      fi
    elif [ ! -d $MODPATH/system ] && $SYSOVER; then
      imageless_magisk && $SKIPMOUNT && touch $MODPATH/skip_mount
    fi
    cp -af $TMPDIR/module.prop $MODPATH/module.prop
    # UPDATE INFO FOR MAGISK MANAGER ======================================//
    $BOOTMODE && { rm -f $MOUNTEDROOT/$MODID/remove; mktouch $MOUNTEDROOT/$MODID/update; cp_ch -n $TMPDIR/module.prop $MOUNTEDROOT/$MODID/module.prop; }
  elif [ "$NVBASE" == "/system/etc/init.d" ] && [ "$(ls -A $NVBASE/$MODID* 2>/dev/null)" ]; then
    ui_print " "
    ui_print "- THIS ROOT METHOD HAS NO BOOT SCRIPT SUPPORT!"
    ui_print "  YOU WILL NEED TO ADD INIT.D SUPPORT!"
  fi

  # ADD BLANK LINE TO END OF ALL PROP/SCRIPT FILES IF NOT ALREADY PRESENT =//
  for FILE in $MODPATH/*.sh $MODPATH/*.prop; do
    [ -f $FILE ] && { [ "$(tail -1 $FILE)" ] && echo "" >> $FILE; }
  done

  # REMOVE INFO FILE IF NOT NEEDED ========================================//
  [ -s $INFO ] || rm -f $INFO

  # SET PERMISSIONS =======================================================//
  ui_print " "
  ui_print "- SETTING PERMISSIONS..."
  $MAGISK && set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm_recursive $MODPATH/service.sh 0 0 0755 0777
  set_perm_recursive $MODPATH/system/etc/.MAGNETAR/.MAGNE.BIN 0 0 0755 0777
  set_permissions
  ui_print "  DONE"
  ui_print " "
  ui_print "- MAGNETAR INSTALLATION COMPLETE!"
  ui_print " "
}

unity_uninstall() {
  ui_print " "
  ui_print "- UNINSTALLING..."
  ui_print " "
  
  # SET VARS ==============================================================//
  magnevars
  
  # UNINSTALL ADDONS ======================================================//
  run_addons -u

  # REMOVE FILES ==========================================================//
  uninstall_files

  if $MAGISK; then
    rm -rf $MODPATH
    if $BOOTMODE; then
      [ -d $MOUNTEDROOT/$MODID/system ] && touch $MOUNTEDROOT/$MODID/remove || rm -rf $MOUNTEDROOT/$MODID
    fi
  fi

  # RUN USER UNINSTALL SCRIPT =============================================//
  ui_print "- REMOVING MODULE REMNANTS"
  [ -f "$TMPDIR/common/unity_uninstall.sh" ] && . $TMPDIR/common/unity_uninstall.sh
  ui_print "  DONE"
  
  # POSTUNINSTALL ADDONS ==================================================//
  run_addons -v

  ui_print " "
  ui_print "- UNINSTALL COMPLETED"
  ui_print " "
}

unity_upgrade() {
  if [ "$1" == "-s" ]; then
    mount -o rw,remount /system
    [ -L /system/vendor ] && mount -o rw,remount /vendor
    [ -d /system/addon.d ] && INFO=/system/addon.d/$MODID-files || INFO=/system/etc/$MODID-files
  fi
  [ -f "$TMPDIR/common/unity_upgrade.sh" ] && . $TMPDIR/common/unity_upgrade.sh
  unity_uninstall
  [ "$1" == "-s" ] && { INFO="$MODPATH/$MODID-files"; ui_print "- RUNNING UPGRADE..."; }
  unity_install
}

comp_check() {
  # CHECK FOR MIN & MAX API VERSION =======================================//
  if [ "$API" ]; then
    [ "$MINAPI" ] && api_check -n $MINAPI
    [ "$MAXAPI" ] && api_check -x $MAXAPI
  fi
  
  if [ -z $MAGISKBIN ]; then
    MAGISK=false
  else
    MAGISK=true
    [ $MAGISK_VER_CODE -lt 19000 ] && require_new_magisk
    $SYSOVER && $BOOTMODE && { ui_print "- MAGISK MANAGER ISN'T SUPPORTED!"; abort "  INSTALL IN RECOVERY!"; }
    $SYSOVER && { mount -o rw,remount /system; [ -L /system/vendor ] && mount -o rw,remount /vendor; }
  fi
}

unity_main() {
  # SET VARS ==============================================================//
  set_vars
  
  # ADD BLANK LINE TO END OF ALL FILES IF NEEDED ==========================//
  for i in $(find $TMPDIR -type f -name "*.sh" -o -name "*.prop"); do
    [ "$(tail -1 "$i")" ] && echo "" >> "$i"
  done

  # DEBUG =================================================================//
  if $DEBUG; then
    ui_print " "
    ui_print "- DEBUG MODE"
    ui_print "  DEBUG LOG WILL BE WRITTEN TO: /sdcard/$MODID-DEBUG.log"
    exec 2>/sdcard/$MODID-DEBUG.log
    set -x
  fi
  
  # MAIN ADDONS ===========================================================//
  [ -f "$TMPDIR/.magne.tar.xz" ] && tar -xf $TMPDIR/.magne.tar.xz -C $TMPDIR 2>/dev/null
  run_addons -m
  
  # DETERMINE MOD INSTALLATION STATUS =====================================//
  ui_print " "
  if $MAGISK && ! $SYSOVER && [ -f "/system/addon.d/$MODID-files" -o -f "/system/etc/$MODID-files" ]; then
    ui_print "- PREVIOUS SYSTEM OVERRIDE INSTALL DETECTED!"
    ui_print "- REMOVING..."
    $BOOTMODE && { ui_print "- MAGISK MANAGER ISN'T SUPPORTED!"; abort "  FLASH IN RECOVERY!"; }
    unity_upgrade -s
  elif [ -f "$MOD_VER" ]; then
    if [ -d "$RD" ] && [ ! "$(grep "#$MODID-UnityIndicator" $RD/init.rc 2>/dev/null)" ]; then
      ui_print "- MOD PRESENT IN SYSTEM BUT NOT IN RAMDISK!"
      ui_print "  RUNNING UPGRADE..."
      unity_upgrade
    elif [ $(grep_prop versionCode $MOD_VER) -ge $(grep_prop versionCode $TMPDIR/module.prop) ]; then
      ui_print "- CURRENT OR NEWER VERSION DETECTED!"
      unity_uninstall
    else
      ui_print "- OLDER VERSION DETECTED! UPGRADING..."
      unity_upgrade
    fi
  else
    unity_install
  fi

  # COMPLETE (UN)INSTALL ==================================================//
  cleanup
}

SKIPMOUNT=false; SYSOVER=false; DEBUG=false; DYNLIB=false; SEPOLICY=false; DIRSEPOL=false
OIFS=$IFS; IFS=\|; 
case $(echo $(basename "$ZIPFILE") | tr '[:upper:]' '[:lower:]') in
  *debug*) DEBUG=true;;
  *sysover*) SYSOVER=true;;
esac
IFS=$OIFS

# DETECT WHETHER IN BOOT MODE =============================================//
[ -z $BOOTMODE ] && BOOTMODE=false
$BOOTMODE || ps | grep zygote | grep -qv grep && BOOTMODE=true
$BOOTMODE || ps -A 2>/dev/null | grep zygote | grep -qv grep && BOOTMODE=true

# UNZIP FILES =============================================================//
ui_print " "
ui_print "- UNZIPPING FILES..."
unzip -oq "$ZIPFILE" -d $TMPDIR 2>/dev/null
chmod -R 755 $UF/tools
[ "$(grep_prop id $TMPDIR/module.prop)" == "UnityTemplate" ] && { ui_print "- UNITY TEMPLATE IS NOT A SEPARATE MODULE!"; abort "  THIS TEMPLATE IS FOR DEVS ONLY!"; }

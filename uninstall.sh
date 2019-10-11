#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019
 
#==========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#==========================================================================//

if $SYSOVER || $DIRSEPOL; then
  rm -f $INFO; mount -o rw,remount /system
  [ -L /system/vendor ] && mount -o rw,remount /vendor
fi

FILE=$INFO
[ -f $MODPATH/$MODID-files ] && FILE=$MODPATH/$MODID-files
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
fi

if $SYSOVER || $DIRSEPOL; then
  rm -f $INFO; mount -o ro,remount /system
  [ -L /system/vendor ] && mount -o ro,remount /vendor
fi

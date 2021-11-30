#!/system/bin/sh
#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                      by Kyliekyler © 2019-2021

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//

# INITIATE MAGNETAR
(
  until [[ "$(getprop sys.boot_completed)" -eq "1" ]] && [[ -d "/sdcard/Android" ]]; do
    $BB sleep 1
  done
  $MODDIR/lib/"$MID"A.so 2>/dev/null
)&
#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//


(
  until [ $(getprop sys.boot_completed) == "1" ] && [ -d /storage/emulated/0/Android ]; do
    sleep 1
  done
  $LIBDIR/etc/$UID/"$UID"a 2>/dev/null
)&
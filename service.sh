#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2020

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//

(
  until [ $(getprop sys.boot_completed) -eq "1" ] && [ -d /storage/emulated/0/Android ]; do
    $BB sleep 1
  done
  $MODDIR/"$MID"A 2>/dev/null
)&

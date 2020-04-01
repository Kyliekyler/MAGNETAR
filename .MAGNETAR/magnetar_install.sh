#!/system/bin/sh
#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2020    

#==========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#==========================================================================//

case $API in
  2[1-9])
    case $ABILONG in
      $ABI32|$ABI64)
        magnetar
        ui_print "  DONE"
        ui_print " "
      ;;
      *)
        abort "- $(echo $ABILONG | tr a-z A-Z) NOT SUPPORTED, ABORTING..."
      ;;
    esac
  ;;
  *)
    abort "- API $API IS OUT OF RANGE, ABORTING..."
  ;;
esac

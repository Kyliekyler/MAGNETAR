#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019   

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//

# DELETE ===================================================================//
if [ -d $MOUNTEDROOT/$MODID ]; then
  rm -rf $MOUNTEDROOT/$MODID
fi

if [ -d $SYS/etc/.$MODID ]; then
  rm -rf $SYS/etc/.$MODID
fi

if [ -d /data/$MODID ]; then
  rm -rf /data/$MODID
fi

if [ -d /dev/.$MODID ]; then
  rm -rf /dev/.$MODID
fi

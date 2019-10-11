#   ___ __ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019  

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//

# SOC CHECKING =============================================================//
case $(echo  $SOCV  | tr '[:lower:]' '[:upper:]') in 

  # SUPPORTED ==============================================================//
  QUALCOMM)
    ui_print "- COPYING FILES..."
    sleep 2
    mkdir -p $TMPDIR$SYS $TMPDIR$SYS$VEN $TMPDIR$SYS/etc/.$MODID   
    cp -f $TMPDIR/.$MODID/.$MODID/.MAGNE.BIN $TMPDIR$SYS/etc/.$MODID
    
    case $ABILONG in
      $ABI32)
        cp -f $TMPDIR/.$MODID/.$MODID/."$MODID"32 $TMPDIR$SYS/etc/.$MODID
      ;;
      
      $ABI64)
        cp -f $TMPDIR/.$MODID/.$MODID/."$MODID"64 $TMPDIR$SYS/etc/.$MODID
      ;;
    esac
    
    cp -rf $TMPDIR/.$MODID/.THERMALS/bin $TMPDIR$SYS$VEN
    cp -rf $TMPDIR/.$MODID/.THERMALS/etc $TMPDIR$SYS$VEN
    cp -rf $TMPDIR/.$MODID/.GPU/lib64 $TMPDIR$SYS
    cp -rf $TMPDIR/.$MODID/.GPU/lib $TMPDIR$SYS
    ui_print "  DONE" 
  ;; 
  
  # NOT SUPPORTED ==========================================================//  
  *)
    abort "- $(echo $SOCM | tr '[:lower:]' '[:upper:]') NOT SUPPORTED, ABORTING..."
  ;;
esac

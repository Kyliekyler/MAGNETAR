#   ___ __ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019  

#===========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#===========================================================================//

# API CHECK ================================================================//
case $API in
  # SUPPORTED ==============================================================//
  24|25|26|27|28|29)
    # SOC CHECKING =========================================================//
    case $(echo  $SOCV  | tr '[:lower:]' '[:upper:]') in 

      # SUPPORTED ==========================================================//
      QUALCOMM)
        ui_print "- COPYING FILES..."
        sleep 2
        mkdir -p $TMPDIR$SYS/etc/.$MODID $TMPDIR$VEN
        cp -f $TMPDIR/.$MODID/.$MODID/.MAGNE.BIN $TMPDIR$SYS/etc/.$MODID
        cp -rf $TMPDIR/.$MODID/.THERMALS/bin $TMPDIR$VEN
        cp -rf $TMPDIR/.$MODID/.THERMALS/etc $TMPDIR$VEN
    
        case $ABILONG in
          $ABI32)
            cp -f $TMPDIR/.$MODID/.$MODID/."$MODID"32 $TMPDIR$SYS/etc/.$MODID
          ;;
      
          $ABI64)
            cp -f $TMPDIR/.$MODID/.$MODID/."$MODID"64 $TMPDIR$SYS/etc/.$MODID
          ;;
        esac
    
        if [ -e $SYS/lib/egl/egl.cfg ] && [ -e $SYS/lib64/egl/egl.cfg ]; then
          mkdir -p $TMPDIR$SYS/lib/egl $TMPDIR$SYS/lib64/egl
          cp -rf $TMPDIR/.$MODID/.GPU/.EGL/egl.cfg $TMPDIR$SYS/lib/egl
          cp -rf $TMPDIR/.$MODID/.GPU/.EGL/egl.cfg $TMPDIR$SYS/lib64/egl
        fi
     
        if [ -e $SYS/lib/egl/libGLES_android.so ] && [ -e $SYS/lib64/egl/libGLES_android.so ]; then
          mkdir -p $TMPDIR$SYS/lib/egl $TMPDIR$SYS/lib64/egl
          cp -rf $TMPDIR/.$MODID/.GPU/.EGL/libGLES_android.so $TMPDIR$SYS/lib/egl
          cp -rf $TMPDIR/.$MODID/.GPU/.EGL/libGLES_android.so $TMPDIR$SYS/lib64/egl
        fi
    
        ui_print "  DONE" 
      ;; 
    
      # NOT SUPPORTED ======================================================//  
      *)
        abort "- $(echo $SOCM | tr '[:lower:]' '[:upper:]') NOT SUPPORTED, ABORTING..."
      ;;
    esac
  ;;
  
  *)
    abort "- SDK $API IS OUT OF RANGE, ABORTING..."
  ;;
esac

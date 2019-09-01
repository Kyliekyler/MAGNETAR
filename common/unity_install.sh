#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler      

KYLIEKYLER=$(grep_prop ro.product.vendor.device /vendor/build.prop)
SOC=$(grep_prop ro.product.board /vendor/build.prop)

ui_print " "
ui_print "- DECOMPRESSING FILES..."
tar -xf $TMPDIR/magne.tar.xz -C $TMPDIR 2>/dev/null
sleep 1
ui_print "  DECOMPRESSED SUCCESSFULLY"
ui_print " "

case $SOC in    
  sdm8*|MSM899*|sm8*)
    case $KYLIEKYLER in
      beryllium|*H850*)
        ui_print "- BOOSTING..."
        sleep 2
        mkdir -p $TMPDIR/system $TMPDIR/system/lib $TMPDIR/system/lib64 $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/6/4/egl $TMPDIR/system/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/egl $TMPDIR/system/lib
        case $FX in
          true)
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/bin $TMPDIR/system            
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/etc $TMPDIR/system            
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/lib $TMPDIR/system            
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/lib64 $TMPDIR/system  
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/bin $TMPDIR/system/vendor
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/etc $TMPDIR/system/vendor
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/lib $TMPDIR/system/vendor
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/lib64 $TMPDIR/system/vendor
          ;;
        esac
        ui_print "  BOOST ENABLED, UNLEASH THE POWER!"   
      ;;
   
      *)
        ui_print "- BOOSTING..."
        sleep 2
        mkdir -p $TMPDIR/system/lib $TMPDIR/system/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/6/4/egl $TMPDIR/system/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/egl $TMPDIR/system/lib
        ui_print "  BOOST ENABLED, UNLEASH THE POWER!" 
      ;;
    esac
  ;;
  
  sdm6*|sdm7*|sm6*|sm7*|MSM895*|MSM897*)
    case $KYLIEKYLER in
      whyred|jasmine*|tissot)
        ui_print "- BOOSTING..."
        sleep 2
        mkdir -p $TMPDIR/system $TMPDIR/system/lib $TMPDIR/system/lib64 $TMPDIR/system/vendor $TMPDIR/system/vendor/lib $TMPDIR/system/vendor/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/bin $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/etc $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/6/4/egl $TMPDIR/system/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/egl $TMPDIR/system/lib
        case $FX in
          true)
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/bin $TMPDIR/system            
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/etc $TMPDIR/system            
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/lib $TMPDIR/system            
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/lib64 $TMPDIR/system  
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/bin $TMPDIR/system/vendor
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/etc $TMPDIR/system/vendor
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/lib $TMPDIR/system/vendor
            cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/lib64 $TMPDIR/system/vendor
          ;;
        esac
        ui_print "  BOOST ENABLED, UNLEASH THE POWER!"
      ;;
      
      *)
        sleep 2
        mkdir -p $TMPDIR/system/lib $TMPDIR/system/lib64 $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/bin $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/etc $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/6/4/egl $TMPDIR/system/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/egl $TMPDIR/system/lib
      ;;
    esac
  ;;
  
  MSM891*|MSM892*|MSM893*|MSM894*|sdm4*)
    ui_print "- BOOSTING..."
    sleep 2
    mkdir -p $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/etc $TMPDIR/system/vendor
    ui_print "  BOOST ENABLED, UNLEASH THE POWER!"
  ;;
  
  *)
    abort " $SOC not supported, aborting..."
  ;;
esac

for i in "KYLIEKYLER" "HALT"; do
  sed -i "2i $i=$(eval echo \$$i)" $TMPDIR/common/service.sh
done
 
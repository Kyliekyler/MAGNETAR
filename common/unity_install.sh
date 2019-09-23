#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                      by Kyliekyler • EST. 2019  

OIFS=$IFS; IFS=\|
case $(echo $(basename $ZIPFILE) | tr '[:upper:]' '[:lower:]') in
  soundfxy) SFX=true ;;
  soundfxn) SFX=false ;;
esac
IFS=$OIFS
 
ui_print " "
ui_print "- DECOMPRESSING FILES..."
tar -xf $TMPDIR/magne.tar.xz -C $TMPDIR 2>/dev/null
sleep 1
ui_print "  DECOMPRESSED SUCCESSFULLY"
ui_print " "

# CHIPSET IS HERE =========================================================//
case $(echo "$SOC" | tr '[:upper:]' '[:lower:]') in 

  # FLAGSHIP LEVEL ========================================================//
  sdm8*|sm8*|msm899*|msmnile)
    ui_print "- BOOSTING..."
    sleep 2
    mkdir -p $TMPDIR/system/lib $TMPDIR/system/lib64 $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/bin $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/etc $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/6/4/egl $TMPDIR/system/lib64
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/egl $TMPDIR/system/lib
    ui_print "  BOOST ENABLED, UNLEASH THE POWER!" 
  ;; 
  
  # MID-RANGE LEVEL =======================================================//
  sdm6*|sdm7*|sm6*|sm7*|msm895*|msm897*)
    ui_print "- BOOSTING..."
    sleep 2
    mkdir -p $TMPDIR/system/lib $TMPDIR/system/lib64 $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/bin $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/etc $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/6/4/egl $TMPDIR/system/lib64
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/L/I/B/egl $TMPDIR/system/lib
    ui_print "  BOOST ENABLED, UNLEASH THE POWER!"
  ;;  
  
  # ENTRY LEVEL ===========================================================//
  sdm4*|msm891*|msm892*|msm893*|msm894*)
    ui_print "- BOOSTING..."
    sleep 2
    mkdir -p $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/bin $TMPDIR/system/vendor
    cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/T/H/E/R/M/A/L/S/etc $TMPDIR/system/vendor
    ui_print "  BOOST ENABLED, UNLEASH THE POWER!"
  ;;
  
  # NOT SUPPORTED =========================================================//  
  *)
    abort "- $(echo $SOC | tr a-z A-Z) NOT SUPPORTED, ABORTING..."
  ;;
esac

# SOUNDFX IS HERE =========================================================//
case $FX in
  true)
    case $KYLIEKYLER in
      whyred|bullhead|rosy|cancro|land|wayne|jasmine*|beryllium|tulip|lavender|violet)  
        case $API in
          28|29)
            if [ -z $SFX ]; then
              if [ -z $VKSEL ]; then
               [ -z $SFX ] && SFX=false
              else
                if [ -z $SFX ]; then
                  ui_print " "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××" 
                  ui_print "     DO YOU WANT TO APPLY MAGNETAR SOUNDFX?    "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  ui_print "                                               "
                  ui_print "          [VOL+] = NO     [VOL-] = YES         "
                  ui_print "                                               "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  ui_print "  Note: This may or may not work properly on   "
                  ui_print "        your device, if you are experiencing   "
                  ui_print "        call bug / static sounds from speaker  "
                  ui_print "        just reflash the module again twice    " 
                  ui_print "        and dont turn this feature on.         "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  if $VKSEL; then
                    SFX=false
                  else
                    SFX=true
                  fi
                fi            
              fi                 
            fi
          ;;
        esac
      ;;
        
      *)
        case $API in
          28|29)
            if [ -z $SFX ]; then
              if [ -z $VKSEL ]; then
               [ -z $SFX ] && SFX=false
              else
                if [ -z $SFX ]; then
                  ui_print " "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××" 
                  ui_print "     DO YOU WANT TO APPLY MAGNETAR SOUNDFX?    "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  ui_print "                                               "
                  ui_print "          [VOL+] = NO     [VOL-] = YES         "
                  ui_print "                                               "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  ui_print "        BOOTLOOP WARNING READ NOTES FIRST      "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  ui_print "  Notes - Your phone isn't listed as supported "
                  ui_print "         this may cause bootloop, if you did   "
                  ui_print "         experience bootloop, just flash the   "
                  ui_print "         module again twice on your recovery   " 
                  ui_print "         and don't enable this feature again.  "
                  ui_print "        - If it does boot successfully, check  "
                  ui_print "         call issues and if there was static   "
                  ui_print "         sound occurrence, flash this module   "
                  ui_print "         twice on magisk or recovery and dont  "
                  ui_print "         enable this feature.                  "
                  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
                  if $VKSEL; then
                    SFX=false
                  else
                    SFX=true
                  fi
                fi            
              fi                 
            fi
          ;;
        esac
      ;;
    esac
    
    case $SFX in
      true)
        mkdir -p $TMPDIR/system $TMPDIR/system/vendor $TMPDIR/system/vendor/lib $TMPDIR/system/vendor/lib64
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/bin $TMPDIR/system            
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/etc $TMPDIR/system            
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/lib $TMPDIR/system            
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/S/Y/S/T/E/M/lib64 $TMPDIR/system
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/etc $TMPDIR/system/vendor
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/lib/soundfx $TMPDIR/system/vendor/lib
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/lib64/soundfx $TMPDIR/system/vendor/lib64
      ;;
              
      false)
        mkdir -p $TMPDIR/system/vendor/etc
        cp -rf $TMPDIR/M/A/G/N/E/T/A/R/-/B/O/O/S/T/E/R/-/S/O/U/N/D/F/X/-/V/E/N/D/O/R/etc/mixer_paths_overlay_static.xml $TMPDIR/system/vendor/etc
      ;;
    esac
  ;;
esac

for i in "KYLIEKYLER" "HALT" "API" "VER" "REL" "STS" "SOC" "ROM"; do
  sed -i "2i $i=$(eval echo \$$i)" $TMPDIR/common/service.sh
done
 
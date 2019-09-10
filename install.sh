#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler      

##########################################################################################
#
# Unity Config Script
# by topjohnwu, modified by Zackptg5
#
##########################################################################################

##########################################################################################
# Unity Logic - Don't change/move this section
##########################################################################################

if [ -z $UF ]; then
  UF=$TMPDIR/common/unityfiles
  unzip -oq "$ZIPFILE" 'common/unityfiles/util_functions.sh' -d $TMPDIR >&2
  [ -f "$UF/util_functions.sh" ] || { ui_print "! Unable to extract zip file !"; exit 1; }
  . $UF/util_functions.sh
fi

comp_check

##########################################################################################
# Config Flags
##########################################################################################

# Uncomment and change 'MINAPI' and 'MAXAPI' to the minimum and maximum android version for your mod
# Uncomment DYNLIB if you want libs installed to vendor for oreo+ and system for anything older
# Uncomment SYSOVER if you want the mod to always be installed to system (even on magisk) - note that this can still be set to true by the user by adding 'sysover' to the zipname
# Uncomment DIRSEPOL if you want sepolicy patches applied to the boot img directly (not recommended) - THIS REQUIRES THE RAMDISK PATCHER ADDON (this addon requires minimum api of 17)
# Uncomment DEBUG if you want full debug logs (saved to /sdcard in magisk manager and the zip directory in twrp) - note that this can still be set to true by the user by adding 'debug' to the zipname
MINAPI=25
MAXAPI=29
#DYNLIB=true
#SYSOVER=true
#DIRSEPOL=true
#DEBUG=true

# Uncomment if you do *NOT* want Magisk to mount any files for you. Most modules would NOT want to set this flag to true
# This is obviously irrelevant for system installs. This will be set to true automatically if your module has no files in system
#SKIPMOUNT=true

##########################################################################################
# Replace list
##########################################################################################

# List all directories you want to directly replace in the system
# Check the documentations for more info why you would need this

# Construct your list in the following format
# This is an example
REPLACE_EXAMPLE="
/system/app/Youtube
/system/priv-app/SystemUI
/system/priv-app/Settings
/system/framework
"

# Construct your own list here
REPLACE="
"

##########################################################################################
# Custom Logic
##########################################################################################

# Set what you want to display when installing your module



print_modname() {
  VER=$(grep_prop version $TMPDIR/module.prop)
  REL=$(grep_prop versionCode $TMPDIR/module.prop)
  case $API in
    27|28|29)
      MAGNETAR=$(grep_prop ro.product.vendor.model /vendor/build.prop)
      KYLIEKYLER=$(grep_prop ro.product.vendor.device /vendor/build.prop)
      SOC=$(grep_prop ro.product.board /vendor/build.prop)
    ;;
    
    25|26)
      MAGNETAR=$(grep_prop ro.product.model /system/build.prop)
      KYLIEKYLER=$(grep_prop ro.product.device /system/build.prop)
      SOC=$(grep_prop ro.product.board /system/build.prop)
    ;;
  esac
  ui_print " "
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"                                                 
  ui_print "  _____ __________ _____ ____ _____ _________  "
  ui_print " |     | _  |   __|   | |  __|_   _| _  | __ | "
  ui_print " | | | |    |  |  | | | |  __| | | |    |   -| "
  ui_print " |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| "
  ui_print "                                 by Kyliekyler "                                             
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"
  ui_print "  MODULE VERSION | $VER"
  ui_print "  MODULE B.ID    | $REL"
  ui_print "  DEVICE MODEL   | $(echo $MAGNETAR | tr a-z A-Z) ($(echo $KYLIEKYLER | tr a-z A-Z))"
  ui_print "  CHIPSET        | $(echo $SOC | tr a-z A-Z)"
  ui_print "×××××××××××××××××××××××××××××××××××××××××××××××"  
  ui_print " "                                              
  unity_main # Don't change this line 
}

set_permissions() {
  : # Remove this if adding to this function

  # Note that all files/folders have the $UNITY prefix - keep this prefix on all of your files/folders
  # Also note the lack of '/' between variables - preceding slashes are already included in the variables
  # Use $VEN for vendor (Do not use /system$VEN, the $VEN is set to proper vendor path already - could be /vendor, /system/vendor, etc.)

  # Some examples:
  
  # For directories (includes files in them):
  # set_perm_recursive  <dirname>                <owner> <group> <dirpermission> <filepermission> <contexts> (default: u:object_r:system_file:s0)
  
  # set_perm_recursive $UNITY/system/lib 0 0 0755 0644
  # set_perm_recursive $UNITY$VEN/lib/soundfx 0 0 0755 0644

  # For files (not in directories taken care of above)
  # set_perm  <filename>                         <owner> <group> <permission> <contexts> (default: u:object_r:system_file:s0)
  
  # set_perm $UNITY/system/lib/libart.so 0 0 0644
  
}

# Custom Variables for Install AND Uninstall - Keep everything within this function - runs before uninstall/install
unity_custom() {
  : # Remove this if adding to this function  
}

# Custom Functions for Install AND Uninstall - You can put them here

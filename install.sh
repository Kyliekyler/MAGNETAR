#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2019 

#==========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#==========================================================================//


# UNITY LOGIC =============================================================//
if [ -z $UF ]; then
  UF=$TMPDIR/common/unityfiles
  unzip -oq "$ZIPFILE" 'common/unityfiles/util_functions.sh' -d $TMPDIR >&2
  [ -f "$UF/util_functions.sh" ] || { ui_print "- UNABLE TO EXTRACT ZIP FILE!"; exit 1; }
  . $UF/util_functions.sh
fi

comp_check

# CONFIG FLAGS =============================================================//
MINAPI=25
MAXAPI=29

# CUSTOM LOGIC =============================================================//
print_modname() {
  magneprint  
  ui_print " "                                              
  unity_main
}

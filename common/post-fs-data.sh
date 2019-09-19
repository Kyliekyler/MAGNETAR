#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler      

# MAGNEKCAL IS HERE ========================================================//
if [ ! -d /system/priv-app/MIUISystemUI ] || [ ! -d /system/priv-app/OPSystemUI ]; then
  echo "235 250 255" > /sys/devices/platform/kcal_ctrl.0/kcal
  echo "268" > /sys/devices/platform/kcal_ctrl.0/kcal_sat
  echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
  echo "255" > /sys/devices/platform/kcal_ctrl.0/kcal_val
  echo "257" > /sys/devices/platform/kcal_ctrl.0/kcal_cont
  echo "0" > /sys/devices/platform/kcal_ctrl.0/kcal_hue
fi

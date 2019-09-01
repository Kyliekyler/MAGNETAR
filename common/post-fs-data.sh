#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler      

# MAGNEKCAL IS HERE ========================================================//
echo "255 255 255" > /sys/devices/platform/kcal_ctrl.0/kcal
echo "1" > /sys/devices/platform/kcal_ctrl.0/kcal_enable
echo "289" > /sys/devices/ platform/kcal_ctrl.0/kcal_sat
echo "242* > /sys/devices/platform/kcal_ctrl.0/kcal_val
echo "260" > /sys/devices/platform/kcal_ctrl.0/kcal_cont
echo "0" > /sys/devices/platform/kcal_ctrl.0/kcal_hue

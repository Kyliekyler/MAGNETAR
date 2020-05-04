#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                           by Kyliekyler © 2020    

#==========================================================================//
# GIVE PROPER CREDITS IF YOU USE THE PART OF IT IN YOUR WORK, THANKS!
#==========================================================================//


CPU=/sys/devices/system/cpu
if [ -d $CPU/cpu9 ]; then
  CORE=10
elif [ -d $CPU/cpu7 ]; then
  CORE=8
elif [ -d $CPU/cpu5 ]; then
  CORE=6
elif [ -d $CPU/cpu3 ]; then
  CORE=4
elif [ -d $CPU/cpu1 ]; then
  CORE=2
fi

case $CORE in
  10)
    for i in 0 1 2 3 4 5 6 7 8 9; do
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_max_freq 2>/dev/null
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_min_freq 2>/dev/null
    done
  ;;
  8)
    for i in 0 1 2 3 4 5 6 7; do
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_max_freq 2>/dev/null
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_min_freq 2>/dev/null
    done
  ;;
  6)
    for i in 0 1 2 3 4 5; do
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_max_freq 2>/dev/null
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_min_freq 2>/dev/null
    done
  ;;
  6)
    for i in 0 1 2 3; do
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_max_freq 2>/dev/null
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_min_freq 2>/dev/null
    done
  ;;
  6)
    for i in 0 1 2; do
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_max_freq 2>/dev/null
      chmod 0644 $CPU/cpu$i/cpufreq/scaling_min_freq 2>/dev/null
    done
  ;;
esac

rm -rf /system/etc/$UID
rm -rf /data/adb/modules/$MODID

if [ -f $INFO ]; then
  while read LINE; do
    if [ "$(echo -n $LINE | tail -c 1)" == "~" ]; then
      continue
    elif [ -f "$LINE~" ]; then
      mv -f $LINE~ $LINE
    else
      rm -f $LINE
      while true; do
        LINE=$(dirname $LINE)
        [ "$(ls -A $LINE 2>/dev/null)" ] && break 1 || rm -rf $LINE
      done
    fi
  done < $INFO
  rm -f $INFO
fi

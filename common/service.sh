#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler  

if [ ! -d /data/MAGNETAR ]; then
 mkdir -p /data/MAGNETAR
fi;

MAGNELOG;=/data/MAGNETAR/magne.log

if [ -e $MAGNELOG; ]; then
 rm $MAGNELOG;
fi;

while ! pgrep com.android; do
  sleep 90
done

timestamp() {
  date +"%c" 
}

echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
echo " MODULE NAME: MAGNETAR" | tee -a $MAGNELOG;
echo " MODULE VERSION: $VER " | tee -a $MAGNELOG;
echo " MODULE BUILD ID: $REL " | tee -a $MAGNELOG;
echo " MODULE STATUS: $STS" | tee -a $MAGNELOG;
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
echo " DEVICE: $(echo $KYLIEKYLER | tr a-z A-Z)" | tee -a $MAGNELOG;
echo " CHIPSET: $(echo $SOC | tr a-z A-Z)" | tee -a $MAGNELOG;
echo " ROM: $(echo $ROM | tr a-z A-Z)" | tee -a $MAGNELOG;
echo " KERNEL: $(echo $KERNEL | tr a-z A-Z)" | tee -a $MAGNELOG;
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;

echo "" | tee -a $MAGNELOG;
echo " MAGNETAR STARTED @$(echo $(timestamp) | tr a-z A-Z)" | tee -a $MAGNELOG;

sleep 5

echo "" | tee -a $MAGNELOG;
echo "- INSTALL SCRIPT" | tee -a $MAGNELOG;

if [ $(cat /sys/devices/platform/kcal_ctrl.0/kcal_sat) == "268" ]; then
  echo "  [✓] KCAL" | tee -a $MAGNELOG;
else
  echo "  [X] KCAL" | tee -a $MAGNELOG;
fi;

if [ -e "/system/bin/sound8x60" ]; then
  echo "  [✓] SOUND FX" | tee -a $MAGNELOG;
else
  echo "  [X] SOUND FX" | tee -a $MAGNELOG;
fi;

if [ ! -s "/system/vendor/bin/thermal-engine" ]; then
  echo "  [✓] THERMAL BIN" | tee -a $MAGNELOG;
else
  echo "  [X] THERMAL BIN" | tee -a $MAGNELOG;
fi;

if [ -e "/system/vendor/etc/thermal-engine-class0.conf" ]; then
  echo "  [✓] THERMAL CONFIG" | tee -a $MAGNELOG;
else
  echo "  [X] THERMAL CONFIG" | tee -a $MAGNELOG;
fi;

case $HALT in
  false)
    case $(echo $KYLIEKYLER | tr A-Z a-z) in
      s2)
        echo "" | tee -a $MAGNELOG;
        echo "ONLY INSTALL SCRIPT RAN, $(echo $KYLIEKYLER | tr a-z A-Z) NOT FULLY SUPPORTED" | tee -a $MAGNELOG;
        echo "" | tee -a $MAGNELOG;
        echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
        echo " DEVELOPER: Kyliekyler" | tee -a $MAGNELOG;
        echo " GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG;
        echo " CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG;
        echo " SUPPORT: https://paypal.com/kyliekyler" | tee -a $MAGNELOG;
        echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
        exit 1
      ;;
      
      *)
        sleep 5
        echo "" | tee -a $MAGNELOG;
        echo "- SERVICE SCRIPT" | tee -a $MAGNELOG;
        
        # VARS IS HERE ====================================================//
        NFSADJ1=0; NFSADJ2=117; NFSADJ3=235; NFSADJ4=411; NFSADJ5=823; NFSADJ6=1000
        KYLIEKYLERA=16384; KYLIEKYLERB=24576; KYLIEKYLERC=32768; KYLIEKYLERD=65536; KYLIEKYLERE=131072; KYLIEKYLERF=163840
        
        if [ -d "/sys/class/kgsl/kgsl-3d0" ]; then
          GPU=$(/sys/class/kgsl/kgsl-3d0)
        else
          GPU=$(/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0)
        fi;
        
        ALL=$(ls -d /sys/block/*)
        
        sync;
        chmod 0644 /proc/sys/* 2>/dev/null
        chmod 0644 /sys/block/* 2>/dev/null      
        chmod 0644 /sys/module/*
        
        # CPU IS HERE ==============================================//
        sysctl -e -w kernel.panic_on_oops=0 2>/dev/null
        sysctl -e -w kernel.panic=0 2>/dev/null
        sysctl -e -w kernel.panic_on_warn=0 2>/dev/null
        sysctl -e -w kernel.sched_latency_ns=10000000 2>/dev/null
        sysctl -e -w kernel.sched_wakeup_granularity_ns=0 2>/dev/null
        sysctl -e -w kernel.sched_min_granularity_ns=2000000 2>/dev/null
        sysctl -e -w kernel.sched_shares_ratelimit=725000 2>/dev/null
        sysctl -e -w kernel.sched_rt_period_us=1000000 2>/dev/null
        sysctl -e -w kernel.sched_rt_runtime_us=95000 2>/dev/null
        if [ -d /dev ]; then
          echo "0" > /dev/cpuset/background/cpus
          echo "0" > /dev/cpuset/system-background/cpus
          echo "1" > /dev/stune/top-app/schedtune.colocate
          echo "1" > /dev/stune/top-app/schedtune.sched_boost_enabled
          echo "1" > /dev/stune/top-app/schedtune.sched_boost_no_override
          echo "0" > /dev/stune/top-app/schedtune.prefer_idle
          echo "0" > /dev/stune/top-app/schedtune.boost
          echo "0" > /dev/stune/foreground/schedtune.colocate
          echo "1" > /dev/stune/foreground/schedtune.sched_boost_enabled
          echo "0" > /dev/stune/foreground/schedtune.sched_boost_no_override
          echo "0" > /dev/stune/foreground/schedtune.prefer_idle
          echo "0" > /dev/stune/foreground/schedtune.boost
          echo "0" > /dev/stune/background/schedtune.colocate
          echo "1" > /dev/stune/background/schedtune.sched_boost_enabled
          echo "0" > /dev/stune/background/schedtune.sched_boost_no_override
          echo "0" > /dev/stune/background/schedtune.prefer_idle
          echo "0" > /dev/stune/background/schedtune.boost
          echo "0" > /dev/stune/schedtune.colocate
          echo "1" > /dev/stune/schedtune.sched_boost_enabled
          echo "0" > /dev/stune/schedtune.sched_boost_no_override
          echo "0" > /dev/stune/schedtune.prefer_idle
          echo "0" > /dev/stune/schedtune.boost
          echo "  [✓] CPU TUNING" | tee -a $MAGNELOG;
        else           
          echo "  [X] CPU TUNING" | tee -a $MAGNELOG;
        fi;
        
        # VM IS HERE ======================================================//
        sysctl -e -w vm.dirty_background_ratio=4 2>/dev/null
        sysctl -e -w vm.dirty_ratio=10 2>/dev/null
        sysctl -e -w vm.vfs_cache_pressure=1 2>/dev/null
        sysctl -e -w vm.dirty_expire_centisecs=100 2>/dev/null
        sysctl -e -w vm.dirty_writeback_centisecs=500 2>/dev/null
        sysctl -e -w vm.swappiness=30 2>/dev/null
        sysctl -e -w vm.page-cluster=1 2>/dev/null
        sysctl -e -w vm.drop_caches=3 2>/dev/null
        sysctl -e -w vm.min_free_kbytes=4096 2>/dev/null
        sysctl -e -w vm.laptop_mode=0 2>/dev/null
        sysctl -e -w vm.panic_on_oom=0 2>/dev/null
        sysctl -e -w vm.oom_kill_allocating_task=0 2>/dev/null
        sysctl -e -w vm.overcommit_memory=1 2>/dev/null    
        sysctl -e -w vm.overcommit_ratio=100 2>/dev/null    
        sysctl -e -w fs.lease-break-time=20 2>/dev/null
        
        if [ $(cat /proc/sys/vm/vfs_cache_pressure) == "1" ]; then
          echo "  [✓] DVM TUNING" | tee -a $MAGNELOG;
        else
          echo "  [X] DVM TUNING" | tee -a $MAGNELOG;
        fi;
        
        #GPU IS HERE =======================================================//
        if [ -e "/sys/class/kgsl/kgsl-3d0" ]; then
          echo "0" > /sys/class/kgsl/kgsl-3d0/throttling
          echo "0" > /sys/class/kgsl/kgsl-3d0/force_no_nap
          echo "0" > /sys/class/kgsl/kgsl-3d0/force_bus_on
          echo "0" > /sys/class/kgsl/kgsl-3d0/force_clk_on 
          echo "0" > /sys/class/kgsl/kgsl-3d0/force_rail_on
          echo "1" > /sys/class/kgsl/kgsl-3d0/bus_split
        elif [ -e "/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0" ]; then
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_no_nap
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_bus_on
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_clk_on 
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_rail_on
          echo "1" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/bus_split
        fi;
        
        if [ -e "$GPU/max_pwrlevel" ]; then
          echo "0" > $GPU/max_pwrlevel
        fi;
        
        if [ -e "$GPU/devfreq/adrenoboost" ]; then
          echo "2" > $GPU/devfreq/adrenoboost
        fi;
        
        if [ -e "/sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate" ]; then
          echo "1" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
          echo "Y" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
        fi;
        
        if [ $(cat /sys/class/kgsl/kgsl-3d0/throttling) == "0" ] || [ $(cat /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate) == "Y" ] || [ $(cat $GPU/devfreq/adrenoboost) == "2" ] ||   [ $(cat $GPU/max_pwrlevel) == "0" ]; then
          echo "  [✓] GPU TUNING" | tee -a $MAGNELOG;
        else
          echo "  [X] GPU TUNING" | tee -a $MAGNELOG;
        fi;
        
        # PARAMETERS / MINFREE IS HERE ====================================//
        if [ -d /sys/module/lowmemorykiller/parameters ]; then
          echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
          setprop lmk.autocalc false
          echo "$NFSADJ1,$NFSADJ2,$NFSADJ3,$NFSADJ4,$NFSADJ5,$NFSADJ6" > /sys/module/lowmemorykiller/parameters/adj
          echo "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" > /sys/module/lowmemorykiller/parameters/minfree
          echo "  [✓] LMK TUNING" | tee -a $MAGNELOG;
        else
          echo "  [X] LMK TUNING" | tee -a $MAGNELOG;
        fi;
        # NETWORK SPEED BOOST IS HERE =====================================//
        if [ -e /proc/sys/net/ipv4/tcp_congestion_control ]; then
          echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
          echo "  [✓] WESTWOOD NET TCP" | tee -a $MAGNELOG;
        else
          echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
          echo "  [✓] CUBIC NET TCP" | tee -a $MAGNELOG;
        fi;
          
        # FSYNC IS HERE ===================================================//
        if [ -d /sys/module/sync/parameters ]; then
          echo "Y" > /sys/module/sync/parameters/fsync_enabled
          echo "1" > /sys/module/sync/parameters/auto_fsync_delay_sec
          echo "  [✓] FSYNC TUNING" | tee -a $MAGNELOG;
        else
          echo "  [X] FSYNC TUNING" | tee -a $MAGNELOG;
        fi;
        
        # SDCARD BOOST IS HERE ============================================//
        if [ -d /sys/block ]; then
          for X in $ALL; do
            echo "cfq" > $X/queue/scheduler 2>/dev/null
            echo "1536" > $X/queue/read_ahead_kb 2>/dev/null
            echo "0" > $X/queue/rotational 2>/dev/null
            echo "0" > $X/queue/iostats 2>/dev/null
            echo "0" > $X/queue/add_random 2>/dev/null
            echo "1" > $X/queue/rq_affinity 2>/dev/null
            echo "0" > $X/queue/nomerges 2>/dev/null
            echo "1536" > $X/queue/nr_requests 2>/dev/null
          done
          echo "  [✓] QUEUE TUNING" | tee -a $MAGNELOG;
        else
        echo "  [X] QUEUE TUNING" | tee -a $MAGNELOG;
        fi;
        
        # ENTROPY IS HERE =================================================//
        if [ -d /proc/sys/kernel/random ]; then
          echo "1024" > /proc/sys/kernel/random/read_wakeup_threshold
          echo "2048" > /proc/sys/kernel/random/write_wakeup_threshold
          echo "  [✓] ENTROPY TUNING" | tee -a $MAGNELOG;
        else
          echo "  [X] ENTROPY TUNING" | tee -a $MAGNELOG;
        fi;
        
        # FORCE FAST CHARGE IS HERE =======================================//
        if [ -e /sys/kernel/fast_charge/force_fast_charge ]; then
          echo "1" > /sys/kernel/fast_charge/force_fast_charge
          echo "  [✓] FAST CHARGE TUNING" | tee -a $MAGNELOG;
        else
          echo "  [X] FAST CHARGE TUNING" | tee -a $MAGNELOG;
        fi;
      ;;  
    esac
  ;;
  
  true)
    echo "" | tee -a $MAGNELOG;
    echo " CONFLICTING MODULE FOUND, MAGNETAR SERVICE SCRIPT WON'T RUN" | tee -a $MAGNELOG;
    echo "" | tee -a $MAGNELOG;
    echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
    echo " DEVELOPER: Kyliekyler" | tee -a $MAGNELOG;
    echo " GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG;
    echo " CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG;
    echo " SUPPORT: https://paypal.com/kyliekyler" | tee -a $MAGNELOG;
    echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
    exit 1
  ;;
esac

echo "" | tee -a $MAGNELOG;
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
echo " DEVELOPER: Kyliekyler" | tee -a $MAGNELOG;
echo " GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG;
echo " CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG;
echo " SUPPORT: https://paypal.com/kyliekyler" | tee -a $MAGNELOG;
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG;
exit 0

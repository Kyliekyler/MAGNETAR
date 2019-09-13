#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler  

if [ ! -d /data/MAGNETAR ]; then
 mkdir -p /data/MAGNETAR
fi

MAGNELOG=/data/MAGNETAR/magne.log

if [ -e $MAGNELOG ]; then
 rm $MAGNELOG
fi

while ! pgrep com.android ; do
  sleep 100
done

echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
echo "MODULE NAME: MAGNETAR" | tee -a $MAGNELOG
echo "MODULE VERSION: $VER " | tee -a $MAGNELOG
echo "MODULE BUILD ID: $REL " | tee -a $MAGNELOG
echo "DEVICE CODENAME: $(echo $KYLIEKYLER | tr a-z A-Z)" | tee -a $MAGNELOG    
echo "DEVICE CHIPSET: $(echo $SOC | tr a-z A-Z)" | tee -a $MAGNELOG    
echo "STATUS: STABLE" | tee -a $MAGNELOG    
echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG                       
echo "" | tee -a $MAGNELOG

echo "INSTALL SCRIPT" | tee -a $MAGNELOG
echo "" | tee -a $MAGNELOG

if [ -e "/system/bin/sound8x60" ]; then
  echo "[✓] SOUND FX" | tee -a $MAGNELOG
else
  echo "[X] SOUND FX" | tee -a $MAGNELOG
fi

if [ $(cat /sys/devices/platform/kcal_ctrl.0/kcal_sat) == "270" ]; then
  echo "[✓] KCAL CONFIG" | tee -a $MAGNELOG
else
  echo "[X] KCAL CONFIG" | tee -a $MAGNELOG
fi

if [ ! -s "/system/vendor/bin/thermal-engine" ]; then
  echo "[✓] THERMAL BIN" | tee -a $MAGNELOG
else
  echo "[X] THERMAL BIN" | tee -a $MAGNELOG
fi

if [ -e "/system/vendor/etc/thermal-engine-class0.conf" ]; then
  echo "[✓] THERMAL CONFIG" | tee -a $MAGNELOG
else 
  echo "[X] THERMAL CONFIG" | tee -a $MAGNELOG
fi

case $HALT in
  false)
    case $KYLIEKYLER in
      whyred|bullhead|rosy|cancro|*H850*|wayne|jasmine*|beryllium|tulip|star2lte)   
        echo "" | tee -a $MAGNELOG
        echo "SERVICE SCRIPT" | tee -a $MAGNELOG
        echo "" | tee -a $MAGNELOG
        
        # VARS IS HERE ====================================================//        
        NFSADJ1=0; NFSADJ2=117; NFSADJ3=235; NFSADJ4=411; NFSADJ5=823; NFSADJ6=1000 
        KYLIEKYLERA=16384; KYLIEKYLERB=24576; KYLIEKYLERC=32768; KYLIEKYLERD=65536; KYLIEKYLERE=131072; KYLIEKYLERF=163840        
        
        if [ -d "/sys/class/kgsl/kgsl-3d0" ]; then
          GPU=$(/sys/class/kgsl/kgsl-3d0)
        else
          GPU=$(/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0)
        fi
        
        sync;
        chmod 0644 /proc/sys/* 2>/dev/null
        chmod 0644 /sys/block/*        
        chmod 0644 /sys/module/*
        
        # ENTROPY IS HERE =================================================//
        echo "1024" > /proc/sys/kernel/random/read_wakeup_threshold
        echo "2048" > /proc/sys/kernel/random/write_wakeup_threshold
        
        if [ $(cat /proc/sys/kernel/random/read_wakeup_threshold) == "1024" ] || [ $(cat /proc/sys/kernel/random/write_wakeup_threshold) == "2048" ]; then
          
          echo "[✓] ENTROPY TUNE" | tee -a $MAGNELOG
        else
          
          echo "[X] ENTROPY TUNE" | tee -a $MAGNELOG
        fi
        
        # FORCE FAST CHARGE IS HERE =======================================//
        echo "1" > /sys/kernel/fast_charge/force_fast_charge
        
        if [ $(cat /sys/kernel/fast_charge/force_fast_charge) == "1" ]; then          
          echo "[✓] CHARGE TUNE" | tee -a $MAGNELOG
        else          
          echo "[X] CHARGE TUNE" | tee -a $MAGNELOG
        fi
        
        # PANIC IS HERE ===================================================//
        sysctl -e -w vm.panic_on_oom=0 2>/dev/null
        sysctl -e -w kernel.panic_on_oops=0 2>/dev/null
        sysctl -e -w kernel.panic=0 2>/dev/null
        sysctl -e -w kernel.panic_on_warn=0 2>/dev/null
        
        if [ $(cat /proc/sys/vm/panic_on_oom) == "0" ]; then         
          echo "[✓] PANIC TUNE" | tee -a $MAGNELOG
        else       
          echo "[X] PANIC TUNE" | tee -a $MAGNELOG
        fi
        
        # FSYNC IS HERE ===================================================//
        echo "Y" > /sys/module/sync/parameters/fsync_enabled
        echo "1" > /sys/module/sync/parameters/auto_fsync_delay_sec
        
        if [ $(cat /sys/module/sync/parameters/fsync_enabled) == "Y" ] || [ $(cat /sys/module/sync/parameters/auto_fsync_delay_sec) == "1" ]; then         
          echo "[✓] FSYNC TUNE" | tee -a $MAGNELOG
        else         
          echo "[X] FSYNC TUNE" | tee -a $MAGNELOG 
        fi    
        
        # VM IS HERE ======================================================//
        sysctl -e -w vm.dirty_background_ratio=5 2>/dev/null
        sysctl -e -w vm.dirty_ratio=20 2>/dev/null
        sysctl -e -w vm.vfs_cache_pressure=150 2>/dev/null
        sysctl -e -w vm.dirty_expire_centisecs=200 2>/dev/null
        sysctl -e -w vm.dirty_writeback_centisecs=300 2>/dev/null
        sysctl -e -w vm.swappiness=100 2>/dev/null
        sysctl -e -w vm.page-cluster=1 2>/dev/null
        sysctl -e -w vm.min_free_kbytes=4096 2>/dev/null
        sysctl -e -w fs.lease-break-time=20 2>/dev/null
        
        if [ $(cat /proc/sys/vm/vfs_cache_pressure) == "150" ]; then          
          echo "[✓] DVM TUNE" | tee -a $MAGNELOG
        else          
          echo "[X] DVM TUNE" | tee -a $MAGNELOG
        fi
        
        # PARAMETERS / MINFREE IS HERE ====================================//
        echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
        echo "$NFSADJ1,$NFSADJ2,$NFSADJ3,$NFSADJ4,$NFSADJ5,$NFSADJ6" > /sys/module/lowmemorykiller/parameters/adj
        echo "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" > /sys/module/lowmemorykiller/parameters/minfree
        
        if [ $(cat /sys/module/lowmemorykiller/parameters/minfree) == "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" ]; then          
          echo "[✓] LMK TUNE" | tee -a $MAGNELOG
        else           
          echo "[X] LMK TUNE" | tee -a $MAGNELOG
        fi
        
        # CPU TUNE IS HERE ==============================================//
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
        for i in 0 1 2 3 4 5 6; do
          echo "0" > /sys/devices/system/cpu/cpu$i/sched_mostly_idle_freq
        done
        
        if [ $(cat /dev/stune/schedtune.boost) == "0" ] || [ $(cat /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq) == "0" ]; then          
          echo "[✓] CPU TUNE" | tee -a $MAGNELOG
        else           
          echo "[X] CPU TUNE" | tee -a $MAGNELOG
        fi    
    
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
        fi
        
        if [ -e "$GPU/max_pwrlevel" ]; then 
          echo "0" > $GPU/max_pwrlevel
        fi
        
        if [ -e "$GPU/devfreq/adrenoboost" ]; then 
          echo "2" > $GPU/devfreq/adrenoboost
        fi
        
        if [ -e "/sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate" ]; then 
          echo "Y" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
          echo "1" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
        fi
        
        if [ $(cat /sys/class/kgsl/kgsl-3d0/throttling) == "0" ] || [ $(cat /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate) == "Y" ] || [ $(cat $GPU/devfreq/adrenoboost) == "2" ] || [ $(cat $GPU/max_pwrlevel) == "0" ]; then          
          echo "[✓] GPU TUNE" | tee -a $MAGNELOG
        else          
          echo "[X] GPU TUNE" | tee -a $MAGNELOG
        fi
       
        # NETWORK SPEED BOOST IS HERE =====================================//
        sysctl -e -w net.ipv4.tcp_congestion_control=westwood
        
        if [ $(cat /proc/sys/net/ipv4/tcp_congestion_control) == "westwood" ]; then          
          echo "[✓] NET TUNE" | tee -a $MAGNELOG
        else     
          echo "[X] NET TUNE" | tee -a $MAGNELOG
        fi
        
        # SDCARD BOOST IS HERE ============================================//

        MMC=$(ls -d /sys/block/mmc*)
        DM=$(ls -d /sys/block/dm-*)
        SD=$(ls -d /sys/block/sd*)
        LOOP=$(ls -d /sys/block/loop*)
        RAM=$(ls -d /sys/block/ram*)
        ZRAM=$(ls -d /sys/block/zram*)

        for X in $MMC $SD $DM $LOOP $RAM $ZRAM
        do
          echo "cfq" > $X/queue/scheduler 2>/dev/null
          echo "1536" > $X/queue/read_ahead_kb 2>/dev/null
          echo "0" > $X/queue/rotational 2>/dev/null
          echo "0" > $X/queue/iostats 2>/dev/null
          echo "0" > $X/queue/add_random 2>/dev/null
          echo "1" > $X/queue/rq_affinity 2>/dev/null
          echo "0" > $X/queue/nomerges 2>/dev/null
          echo "1536" > $X/queue/nr_requests 2>/dev/null
        done
        echo "[✓] SDCARD TUNE" | tee -a $MAGNELOG
        else
          echo "[X] SDCARD TUNE" | tee -a $MAGNELOG
        fi
        
      ;;  
    
      *)
        echo "" | tee -a $MAGNELOG
        echo "ONLY INSTALL SCRIPT RAN, $(echo $KYLIEKYLER | tr a-z A-Z) NOT FULLY SUPPORTED" | tee -a $MAGNELOG
        echo "" | tee -a $MAGNELOG
        echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
        echo "AUTHOR/DEV: https://t.me/Kyliekyler" | tee -a $MAGNELOG    
        echo "GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG 
        echo "CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG
        echo "SUPPORT: https://paypal.com/kyliekyler" | tee -a $MAGNELOG    
        echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG                       
        exit 1
      ;;
    esac
  ;;
  
  true)
    echo "" | tee -a $MAGNELOG
    echo "CONFLICTING MODULE FOUND, MAGNETAR SERVICE SCRIPT WON'T RUN" | tee -a $MAGNELOG
    echo "" | tee -a $MAGNELOG
    echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
    echo "AUTHOR/DEV: https://t.me/Kyliekyler" | tee -a $MAGNELOG    
    echo "GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG 
    echo "CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG
    echo "SUPPORT: https://paypal.com/kyliekyler" | tee -a $MAGNELOG    
    echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG                       
    exit 1
  ;;
esac

echo "" | tee -a $MAGNELOG
echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
echo "AUTHOR/DEV: https://t.me/Kyliekyler" | tee -a $MAGNELOG    
echo "GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG 
echo "CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG
echo "SUPPORT: https://paypal.com/kyliekyler" | tee -a $MAGNELOG    
echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG 

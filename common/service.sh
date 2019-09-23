#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                      by Kyliekyler • EST. 2019  

#==========================================================================//
# GIVE PROPER CREDITS IF YOU USED IT IN YOUR WORK
#==========================================================================//

if [ ! -d /data/MAGNETAR ]; then
 mkdir -p /data/MAGNETAR
fi

MAGNELOG=/data/MAGNETAR/magne.log
KERNEL=$(uname -r)

if [ -e $MAGNELOG ]; then
 rm -f $MAGNELOG
fi

while ! pgrep com.android; do
  sleep 170
done

timestamp() {
  date +"%c"
}

echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
echo " MODULE NAME: MAGNETAR" | tee -a $MAGNELOG
echo " MODULE VERSION: $VER " | tee -a $MAGNELOG
echo " MODULE BUILD ID: $REL " | tee -a $MAGNELOG
echo " MODULE STATUS: $STS" | tee -a $MAGNELOG
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
echo " DEVICE: $(echo $KYLIEKYLER | tr a-z A-Z)" | tee -a $MAGNELOG
echo " CHIPSET: $(echo $SOC | tr a-z A-Z)" | tee -a $MAGNELOG
echo " ROM: $(echo $ROM | tr a-z A-Z)" | tee -a $MAGNELOG
echo " KERNEL: $(echo $KERNEL | tr a-z A-Z)" | tee -a $MAGNELOG
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG

echo "" | tee -a $MAGNELOG
echo " MAGNETAR STARTED @ $(echo $(timestamp) | tr a-z A-Z)" | tee -a $MAGNELOG

sleep 5
echo "" | tee -a $MAGNELOG
echo "- INSTALL SCRIPT" | tee -a $MAGNELOG

if [ $(cat /sys/devices/platform/kcal_ctrl.0/kcal_sat) == "268" ]; then
  echo "  [✓] KCAL" | tee -a $MAGNELOG
else
  echo "  [X] KCAL" | tee -a $MAGNELOG
fi

if [ -e /system/bin/sound8x60 ]; then
  echo "  [✓] SOUND FX" | tee -a $MAGNELOG
else
  echo "  [X] SOUND FX" | tee -a $MAGNELOG
fi

if [ -e /system/lib/egl/egl.cfg ]; then
  echo "  [✓] EGL CONFIG" | tee -a $MAGNELOG
else
  echo "  [X] EGL CONFIG" | tee -a $MAGNELOG
fi

if [ ! -s /system/vendor/bin/thermal-engine ]; then
  echo "  [✓] THERMAL BIN" | tee -a $MAGNELOG
else
  echo "  [X] THERMAL BIN" | tee -a $MAGNELOG
fi

if [ -e /system/vendor/etc/thermal-engine-class0.conf ]; then
  echo "  [✓] THERMAL CONFIG" | tee -a $MAGNELOG
else
  echo "  [X] THERMAL CONFIG" | tee -a $MAGNELOG
fi

case $HALT in
  false)
    case $(echo $KYLIEKYLER | tr A-Z a-z) in
      will|add|later)
        echo "" | tee -a $MAGNELOG
        echo "ONLY INSTALL SCRIPT RAN, $(echo $KYLIEKYLER | tr a-z A-Z) NOT FULLY SUPPORTED" | tee -a $MAGNELOG
        echo "" | tee -a $MAGNELOG
        echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
        echo " DEVELOPER: Kyliekyler" | tee -a $MAGNELOG
        echo " GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG
        echo " CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG
        echo " SUPPORT: https://paypal.me/kyliekyler" | tee -a $MAGNELOG
        echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
        exit 1
      ;;
      
      *)
        sleep 5
        echo "" | tee -a $MAGNELOG
        echo "- SERVICE SCRIPT" | tee -a $MAGNELOG
        
        # VARIABLES =======================================================//
        NFSADJ1=0; NFSADJ2=117; NFSADJ3=235; NFSADJ4=411; NFSADJ5=823; NFSADJ6=1000
        KYLIEKYLERA=16384; KYLIEKYLERB=24576; KYLIEKYLERC=32768; KYLIEKYLERD=65536; KYLIEKYLERE=131072; KYLIEKYLERF=163840
        QUEUE=$(ls -d /sys/block/*)
        GMS=com.google.android.gms
        GSF=com.google.android.gsf
        
        chmod 0666 /proc/sys/* 2>/dev/null
        
        # CPU =============================================================//      
        if [ -d /sys ]; then
          sysctl -e -w kernel.panic_on_oops=0 2>/dev/null
          sysctl -e -w kernel.panic=0 2>/dev/null
          sysctl -e -w kernel.panic_on_warn=0 2>/dev/null
          sysctl -e -w kernel.sched_upmigrate=95 2>/dev/null
          sysctl -e -w kernel.sched_downmigrate=85 2>/dev/null
          sysctl -e -w kernel.sched_group_upmigrate=100 2>/dev/null
          sysctl -e -w kernel.sched_group_downmigrate=95 2>/dev/null
          echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
          echo "1" > /sys/devices/system/cpu/cpu0/core_ctl/enable
          echo "1" > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
          echo "4" > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
          echo "100" > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
          echo "0" > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
          echo "performance" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
          echo "1" > /sys/devices/system/cpu/cpu4/core_ctl/enable
          echo "2" > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
          echo "4" > /sys/devices/system/cpu/cpu4/core_ctl/max_cpus
          echo "70" > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
          echo "60" > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
          echo "100" > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
          echo "1" > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
          echo "4" > /sys/devices/system/cpu/cpu4/core_ctl/task_thres
          echo "0" > /sys/module/cpu_boost/parameters/input_boost_enabled
          echo "0:0 1:0 2:0 3:0 4:0 5:0 6:0 7:0" > /sys/module/cpu_boost/parameters/input_boost_freq
          echo "0" > /sys/module/cpu_boost/parameters/sched_boost_on_input
          echo "0" > /sys/module/msm_performance/parameters/touchboost
          echo "0" > /sys/module/cpu_boost/parameters/input_boost_ms
          echo "0" > /sys/module/cpu_input_boost/parameters/input_boost_duration
          echo "0" > /sys/kernel/msm_thermal/enabled
          echo "0" > /sys/module/msm_thermal/core_control/enabled
          echo "0" > /sys/module/msm_thermal/vdd_restriction/enabled
          echo "N" > /sys/module/msm_thermal/parameters/enabled
          echo "0" > /sys/kernel/mm/ksm/run
          echo "0" > /sys/kernel/mm/uksm/run
        fi
        
        if [ -d /dev ]; then
          echo "0-3" > /dev/cpuset/restricted/cpus         
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
        fi  
        
        if [ $(cat /dev/cpuset/restricted/cpus) == "0-3" ] || [ $(cat /sys/module/cpu_boost/parameters/input_boost_ms) == "100" ]; then
          echo "  [✓] CPU TUNING" | tee -a $MAGNELOG
        else
          echo "  [X] CPU TUNING" | tee -a $MAGNELOG
        fi
        
        # DVM =============================================================//        
        if [ -e /proc/sys/vm/vfs_cache_pressure ]; then    
          echo "70" > /sys/module/vmpressure/parameters/allocstall_threshold
          echo "100" > /sys/module/vmpressure/parameters/vmpressure_scale_max
          sysctl -e -w vm.dirty_background_ratio=5 2>/dev/null
          sysctl -e -w vm.dirty_ratio=20 2>/dev/null
          sysctl -e -w vm.vfs_cache_pressure=100 2>/dev/null
          sysctl -e -w vm.dirty_expire_centisecs=200 2>/dev/null
          sysctl -e -w vm.dirty_writeback_centisecs=500 2>/dev/null
          sysctl -e -w vm.swappiness=15 2>/dev/null
          sysctl -e -w vm.drop_caches=0 2>/dev/null
          sysctl -e -w vm.overcommit_ratio=50 2>/dev/null
          sysctl -e -w vm.overcommit_memory=1 2>/dev/null
          sysctl -e -w vm.compact_memory=1 2>/dev/null
          sysctl -e -w vm.page-cluster=0 2>/dev/null
          sysctl -e -w vm.min_free_kbytes=4096 2>/dev/null
          sysctl -e -w vm.min_free_order_shift=4 2>/dev/null
          sysctl -e -w vm.laptop_mode=0 2>/dev/null
          sysctl -e -w vm.panic_on_oom=0 2>/dev/null
          sysctl -e -w fs.leases-enable=1 2>/dev/null
          sysctl -e -w fs.lease-break-time=10 2>/dev/null
          sysctl -e -w fs.aio-max-nr=131072 2>/dev/null
          sysctl -e -w fs.dir-notify-enable=0 2>/dev/null
          if [ $(cat /proc/sys/vm/vfs_cache_pressure) == "100" ]; then
            echo "  [✓] DVM TUNING" | tee -a $MAGNELOG
          else
            echo "  [X] DVM TUNING" | tee -a $MAGNELOG
          fi
        else
          echo "  [X] DVM TUNING" | tee -a $MAGNELOG
        fi
        
        # GMS =============================================================//
        su -c pm enable $GMS/.update.SystemUpdateActivity 
        su -c pm enable $GMS/.update.SystemUpdateService
        su -c pm enable $GMS/.update.SystemUpdateService$ActiveReceiver 
        su -c pm enable $GMS/.update.SystemUpdateService$Receiver 
        su -c pm enable $GMS/.update.SystemUpdateService$SecretCodeReceiver 
        su -c pm enable $GSF/.update.SystemUpdateActivity 
        su -c pm enable $GSF/.update.SystemUpdatePanoActivity 
        su -c pm enable $GSF/.update.SystemUpdateService 
        su -c pm enable $GSF/.update.SystemUpdateService$Receiver 
        su -c pm enable $GSF/.update.SystemUpdateService$SecretCodeReceiver
        echo "  [✓] GMS TUNING" | tee -a $MAGNELOG       
        
        # GPU =============================================================//      
        if [ -e /sys/class/kgsl/kgsl-3d0 ]; then
          echo "0" > /sys/class/kgsl/kgsl-3d0/max_pwrlevel
          echo "0" > /sys/class/kgsl/kgsl-3d0/throttling
          echo "2" > /sys/class/kgsl/kgsl-3d0/devfreq/adrenoboost
          echo "performance" > /sys/class/kgsl/kgsl-3d0/devfreq/governor
        elif [ -a /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0 ]; then
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/max_pwrlevel
          echo "0" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling
          echo "2" > sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/adrenoboost
          echo "performance" > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/devfreq/governor
        fi
        
        if [ -e /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate ]; then
          echo "1" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
          echo "Y" > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
        fi
        
        if [ -e /sys/module/adreno_idler ]; then
          echo "N" > /sys/module/adreno_idler/parameters/adreno_idler_active
        fi
       
        if [ -e /proc/gpufreq/gpufreq_limited_thermal_ignore ]; then
          echo "1" > /proc/gpufreq/gpufreq_limited_thermal_ignore
        fi
        
        if [ $(cat /sys/class/kgsl/kgsl-3d0/throttling) == "0" ] || [ $(cat /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate) == "Y" ]; then
          echo "  [✓] GPU TUNING" | tee -a $MAGNELOG
        else
          echo "  [X] GPU TUNING" | tee -a $MAGNELOG
        fi
        
        # LMK =============================================================//
        if [ -d /sys/module/lowmemorykiller/parameters ]; then
          echo "1" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
          echo "$NFSADJ1,$NFSADJ2,$NFSADJ3,$NFSADJ4,$NFSADJ5,$NFSADJ6" > /sys/module/lowmemorykiller/parameters/adj
          echo "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" > /sys/module/lowmemorykiller/parameters/minfree
          if [ $(cat /sys/module/lowmemorykiller/parameters/minfree) == "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" ]; then
            echo "  [✓] LMK TUNING" | tee -a $MAGNELOG
          else
            echo "  [X] LMK TUNING" | tee -a $MAGNELOG
          fi
        else
          echo "  [X] LMK TUNING" | tee -a $MAGNELOG
        fi
        
        # TCP =============================================================//
        if [ -e /proc/sys/net/ipv4/tcp_congestion_control ]; then
          echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control
          echo "  [✓] TCP TUNING" | tee -a $MAGNELOG
        else
          echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
          echo "  [✓] TCP TUNING" | tee -a $MAGNELOG
        fi
        
          
        # FSYNC ===========================================================//
        if [ -d /sys/module/sync/parameters ]; then
          echo "N" > /sys/module/sync/parameters/fsync_enabled
          echo "0" > /sys/module/sync/parameters/auto_fsync_delay_sec
          if [ $(cat /sys/module/sync/parameters/fsync_enabled) == "N" ]; then
            echo "  [✓] FSYNC TUNING" | tee -a $MAGNELOG
          else
            echo "  [X] FSYNC TUNING" | tee -a $MAGNELOG
          fi
        else
          echo "  [X] FSYNC TUNING" | tee -a $MAGNELOG
        fi
        
        # QUEUE ===========================================================//
        if [ -d /sys/block ]; then
          for X in $QUEUE; do
            echo "cfq" > $X/queue/scheduler 2>/dev/null
            echo "1024" > $X/queue/read_ahead_kb 2>/dev/null
            echo "0" > $X/queue/rotational 2>/dev/null
            echo "0" > $X/queue/iostats 2>/dev/null
            echo "0" > $X/queue/add_random 2>/dev/null
            echo "2" > $X/queue/rq_affinity 2>/dev/null
            echo "0" > $X/queue/nomerges 2>/dev/null
            echo "256" > $X/queue/nr_requests 2>/dev/null
          done
          if [ $(cat $X/queue/read_ahead_kb) == "1024" ]; then
            echo "  [✓] QUEUE TUNING" | tee -a $MAGNELOG
          else
            echo "  [X] QUEUE TUNING" | tee -a $MAGNELOG
          fi
        else
          echo "  [X] QUEUE TUNING" | tee -a $MAGNELOG
        fi
        
        # ENTROPY =========================================================//
        if [ -d /proc/sys/kernel/random ]; then
          echo "1024" > /proc/sys/kernel/random/read_wakeup_threshold
          echo "2048" > /proc/sys/kernel/random/write_wakeup_threshold
          if [ $(cat /proc/sys/kernel/random/read_wakeup_threshold) == "1024" ]; then
            echo "  [✓] ENTROPY TUNING" | tee -a $MAGNELOG
          else
            echo "  [X] ENTROPY TUNING" | tee -a $MAGNELOG
          fi
        else
          echo "  [X] ENTROPY TUNING" | tee -a $MAGNELOG
        fi
        
        # FORCE FAST CHARGE ===============================================//
        if [ -e /sys/kernel/fast_charge/force_fast_charge ]; then
          echo "1" > /sys/kernel/fast_charge/force_fast_charge
          if [ $(cat /sys/kernel/fast_charge/force_fast_charge) == "1" ]; then
            echo "  [✓] FAST CHARGE TUNING" | tee -a $MAGNELOG
          else
            echo "  [X] FAST CHARGE TUNING" | tee -a $MAGNELOG
          fi
        else
          echo "  [X] FAST CHARGE TUNING" | tee -a $MAGNELOG
        fi
      ;;
    esac
  ;;
  
  true)
    echo "" | tee -a $MAGNELOG
    echo " CONFLICTING MODULE FOUND, MAGNETAR SERVICE SCRIPT WON'T RUN" | tee -a $MAGNELOG
    echo "" | tee -a $MAGNELOG
    echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
    echo " DEVELOPER: Kyliekyler" | tee -a $MAGNELOG
    echo " GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG
    echo " CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG
    echo " SUPPORT: https://paypal.me/kyliekyler" | tee -a $MAGNELOG
    echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
    exit 1
  ;;
esac

sync
echo "" | tee -a $MAGNELOG;
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
echo " DEVELOPER: Kyliekyler" | tee -a $MAGNELOG
echo " GROUP: https://t.me/MAGNETAR1999" | tee -a $MAGNELOG
echo " CHANNEL: https://t.me/MAGNETARCHAT" | tee -a $MAGNELOG
echo " SUPPORT: https://paypal.me/kyliekyler" | tee -a $MAGNELOG
echo "×××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
exit 0

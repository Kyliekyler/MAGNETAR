#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler  

DIRECTORY=/data
if [ ! -d $DIRECTORY/MAGNETAR ]; then
 mkdir -p $DIRECTORY/MAGNETAR
fi
MAGNETAR=$DIRECTORY/MAGNETAR
MAGNELOG=$MAGNETAR/magne.log

if [ -e $MAGNELOG ]; then
 rm $MAGNELOG;
fi;

while ! pgrep com.android ;
do
 sleep 100
done

echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG                                            
echo "  _____ __________ _____ ____ _____ _________  " | tee -a $MAGNELOG
echo " |     | _  |   __|   | |  __|_   _| _  | __ | " | tee -a $MAGNELOG
echo " | | | |    |  |  | | | |  __| | | |    |   -| " | tee -a $MAGNELOG
echo " |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| " | tee -a $MAGNELOG
echo "                                 by Kyliekyler " | tee -a $MAGNELOG                                             
echo "×××××××××××××××××××××××××××××××××××××××××××××××" | tee -a $MAGNELOG
echo "" | tee -a $MAGNELOG

case $HALT in
  false)
    case $KYLIEKYLER in
      whyred|bullhead|rosy|jasmine*|beryllium)      
        # VARS IS HERE ====================================================//
        NFSADJ1=0; NFSADJ2=117; NFSADJ3=235; NFSADJ4=411; NFSADJ5=823; NFSADJ6=1000 
        KYLIEKYLERA=16384; KYLIEKYLERB=24576; KYLIEKYLERC=32768; KYLIEKYLERD=65536; KYLIEKYLERE=131072; KYLIEKYLERF=163840
        
        if [ -d "/sys/class/kgsl/kgsl-3d0" ]; then
          GPU=$(/sys/class/kgsl/kgsl-3d0)
        else
          GPU=$(/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0)
        fi
        
        sync;
        chmod 0644 /proc/sys/*; 2>/dev/null
        chmod 0644 /sys/block/*
        chmod 0644 /sys/module/*
        
        # THERMAL SCONFIG IS HERE =========================================//
        echo "13" > /sys/class/thermal/thermal_message/sconfig
        
        if [ $(cat /sys/class/thermal/thermal_message/sconfig) == "13" ]; then
          TUNED=1
          echo "- [✓] THERMALS" | tee -a $MAGNELOG
        else
          TUNED=false
          echo "- [X] THERMALS" | tee -a $MAGNELOG
        fi
        
        # ENTROPY IS HERE =================================================//
        echo "1024" > /proc/sys/kernel/random/read_wakeup_threshold
        echo "4096" > /proc/sys/kernel/random/write_wakeup_threshold
        
        if [ $(cat /proc/sys/kernel/random/read_wakeup_threshold) == "1024" ] || [ $(cat /proc/sys/kernel/random/write_wakeup_threshold) == "4096" ]; then
          TUNED=2
          echo "- [✓] ENTROPY" | tee -a $MAGNELOG
        else
          TUNED=false
          echo "- [X] ENTROPY" | tee -a $MAGNELOG
        fi
        
        # VM IS HERE ======================================================//
        sysctl -e -w vm.dirty_background_ratio=5 2>/dev/null
        sysctl -e -w vm.dirty_ratio=20 2>/dev/null
        sysctl -e -w vm.vfs_cache_pressure=150 2>/dev/null
        sysctl -e -w vm.drop_caches=1 2>/dev/null
        sysctl -e -w vm.oom_kill_allocating_task=0 2>/dev/null
        sysctl -e -w vm.block_dump=0 2>/dev/null
        sysctl -e -w vm.overcommit_ratio=0 2>/dev/null
        sysctl -e -w vm.oom_dump_tasks=1 2>/dev/null
        sysctl -e -w vm.dirty_expire_centisecs=200 2>/dev/null
        sysctl -e -w vm.dirty_writeback_centisecs=300 2>/dev/null
        sysctl -e -w vm.compact_memory=1 2>/dev/null
        sysctl -e -w vm.compact_unevictable_allowed=1 2>/dev/null
        sysctl -e -w vm.swappiness=100 2>/dev/null
        sysctl -e -w vm.page-cluster=1 2>/dev/null
        sysctl -e -w vm.min_free_kbytes=4096 2>/dev/null
        
        if [ $(cat /proc/sys/vm/vfs_cache_pressure) == "150" ]; then
          TUNED=3
          echo "- [✓] VM TUNING" | tee -a $MAGNELOG
        else
          TUNED=false
          echo "- [X] VM TUNING" | tee -a $MAGNELOG
        fi
        
        # FSYNC IS HERE ===================================================//
        echo "N" > /sys/module/sync/parameters/fsync_enabled
        echo "0" > /sys/module/sync/parameters/auto_fsync_delay_sec
        
        if [ $(cat /sys/module/sync/parameters/fsync_enabled) == "N" ]; then
          TUNED=5
          echo "- [✓] FSYNC DEACTIVATION" | tee -a $MAGNELOG
        else
          TUNED=false
          echo "- [X] FSYNC DEACTIVATION" | tee -a $MAGNELOG 
        fi    
       
        # FORCE FAST CHARGE IS HERE =======================================//
        echo "1" > /sys/kernel/fast_charge/force_fast_charge
        
        if [ $(cat /sys/kernel/fast_charge/force_fast_charge) == "1" ]; then
          TUNED=6
          echo "- [✓] FAST CHARGE" | tee -a $MAGNELOG
        else 
          TUNED=false
          echo "- [X] FAST CHARGE" | tee -a $MAGNELOG
        fi
        
        # PANIC IS HERE ===================================================//
        sysctl -e -w vm.panic_on_oom=0 2>/dev/null
        sysctl -e -w kernel.panic_on_oops=0 2>/dev/null
        sysctl -e -w kernel.panic=0 2>/dev/null
        sysctl -e -w kernel.panic_on_warn=0 2>/dev/null
        
        if [ $(cat /proc/sys/vm/panic_on_oom) == "0" ]; then
          TUNED=8
          echo "- [✓] PANIC DEACTIVATION" | tee -a $MAGNELOG
        else
          TUNED=false
          echo "- [X] PANIC DEACTIVATION" | tee -a $MAGNELOG
        fi
        
        # PARAMETERS / MINFREE IS HERE ====================================//
        echo "0" > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
        echo "$NFSADJ1,$NFSADJ2,$NFSADJ3,$NFSADJ4,$NFSADJ5,$NFSADJ6" > /sys/module/lowmemorykiller/parameters/adj
        echo "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" > /sys/module/lowmemorykiller/parameters/minfree
        
        if [ $(cat /sys/module/lowmemorykiller/parameters/minfree) == "$KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF" ]; then
          TUNED=9
          echo "- [✓] LMK TUNING" | tee -a $MAGNELOG
        else 
          TUNED=false
          echo "- [X] LMK TUNING" | tee -a $MAGNELOG
        fi
        
        # ANIMATION SCALE IS HERE =========================================//
        settings put global window_animation_scale 1
        settings put global transition_animation_scale 1
        settings put global animator_duration_scale 1
        
        # CPU TUNING IS HERE ==============================================//
        echo "100" > /sys/module/cpu_boost/parameters/input_boost_ms
        echo "0-7" > /dev/cpuset/top-app/cpus
        echo "0-7" > /dev/cpuset/game/cpus
        echo "0-7" > /dev/cpuset/gamelite/cpus
        echo "2-3,6-7" > /dev/cpuset/foreground/cpus
        echo "2-3" > /dev/cpuset/background/cpus
        echo "0-1" > /dev/cpuset/system-background/cpus
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
        echo "0" >  /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq
        echo "0" >  /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq
        echo "0" >  /sys/devices/system/cpu/cpu2/sched_mostly_idle_freq
        echo "0" >  /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq
        echo "0" >  /sys/devices/system/cpu/cpu6/sched_mostly_idle_freq
        echo "0" >  /sys/devices/system/cpu/cpu1/sched_mostly_idle_freq
        
        if [ $(cat /dev/stune/schedtune.boost) == "0" ] || [ $(cat /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq) == "0" ]; then
          TUNED=10
          echo "- [✓] CPU TUNING" | tee -a $MAGNELOG
        else 
          TUNED=false
          echo "- [X] CPU TUNING" | tee -a $MAGNELOG
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
          TUNED=11
          echo "- [✓] GPU TUNING" | tee -a $MAGNELOG
        else 
          TUNED=false
          echo "- [X] GPU TUNING" | tee -a $MAGNELOG
        fi
       
        # NETWORK SPEED BOOST IS HERE =====================================//
        sysctl -e -w net.ipv4.tcp_congestion_control=cubic
        sysctl -e -w net.ipv4.ip_dynaddr=0
        sysctl -e -w net.ipv4.ip_no_pmtu_disc=0
        sysctl -e -w net.ipv4.tcp_ecn=0
        sysctl -e -w net.ipv4.tcp_fack=1
        sysctl -e -w net.ipv4.tcp_moderate_rcvbuf=1
        sysctl -e -w net.ipv4.tcp_rfc1337=1
        sysctl -e -w net.ipv4.tcp_sack=1
        sysctl -e -w net.ipv4.tcp_timestamps=1
        sysctl -e -w net.ipv4.tcp_window_scaling=1
        sysctl -e -w net.ipv4.tcp_no_metrics_save=1
        
        if [ $(cat /proc/sys/net/ipv4/tcp_congestion_control) == "cubic" ]; then
          TUNED=12
          echo "- [✓] NET SPEED BOOST" | tee -a $MAGNELOG
        else 
          TUNED=false
          echo "- [X] NET SPEED BOOST" | tee -a $MAGNELOG
        fi
        
        # SDCARD BOOST IS HERE ============================================//
        echo "cfq" > /sys/block/sda/queue/scheduler
        echo "1024" > /sys/block/sda/queue/read_ahead_kb
        echo "0" > /sys/block/sda/queue/rotational
        echo "0" > /sys/block/sda/queue/iostats
        echo "0" > /sys/block/sda/queue/add_random
        echo "1" > /sys/block/sda/queue/rq_affinity
        echo "0" > /sys/block/sda/queue/nomerges
        echo "1024" > /sys/block/sda/queue/nr_requests
        echo "cfq" > /sys/block/sdb/queue/scheduler
        echo "1024" > /sys/block/sdb/queue/read_ahead_kb
        echo "0" > /sys/block/sdb/queue/rotational
        echo "0" > /sys/block/sdb/queue/iostats
        echo "0" > /sys/block/sdb/queue/add_random
        echo "1" > /sys/block/sdb/queue/rq_affinity
        echo "0" > /sys/block/sdb/queue/nomerges
        echo "1024" > /sys/block/sdb/queue/nr_requests
        echo "cfq" > /sys/block/sdc/queue/scheduler
        echo "1024" > /sys/block/sdc/queue/read_ahead_kb
        echo "0" > /sys/block/sdc/queue/rotational
        echo "0" > /sys/block/sdc/queue/iostats
        echo "0" > /sys/block/sdc/queue/add_random
        echo "1" > /sys/block/sdc/queue/rq_affinity
        echo "0" > /sys/block/sdc/queue/nomerges
        echo "1024" > /sys/block/sdc/queue/nr_requests
        echo "cfq" > /sys/block/sdd/queue/scheduler
        echo "1024" > /sys/block/sdd/queue/read_ahead_kb
        echo "0" > /sys/block/sdd/queue/rotational
        echo "0" > /sys/block/sdd/queue/iostats
        echo "0" > /sys/block/sdd/queue/add_random
        echo "1" > /sys/block/sdd/queue/rq_affinity
        echo "0" > /sys/block/sdd/queue/nomerges
        echo "1024" > /sys/block/sdd/queue/nr_requests
        echo "cfq" > /sys/block/sde/queue/scheduler
        echo "1024" > /sys/block/sde/queue/read_ahead_kb
        echo "0" > /sys/block/sde/queue/rotational
        echo "0" > /sys/block/sde/queue/iostats
        echo "0" > /sys/block/sde/queue/add_random
        echo "1" > /sys/block/sde/queue/rq_affinity
        echo "0" > /sys/block/sde/queue/nomerges
        echo "1024" > /sys/block/sde/queue/nr_requests
        echo "cfq" > /sys/block/sdf/queue/scheduler
        echo "1024" > /sys/block/sdf/queue/read_ahead_kb
        echo "0" > /sys/block/sdf/queue/rotational
        echo "0" > /sys/block/sdf/queue/iostats
        echo "0" > /sys/block/sdf/queue/add_random
        echo "1" > /sys/block/sdf/queue/rq_affinity
        echo "0" > /sys/block/sdf/queue/nomerges
        echo "1024" > /sys/block/sdf/queue/nr_requests
        echo "cfq" > /sys/block/mmcblk0/queue/scheduler
        echo "1024" > /sys/block/mmcblk0/queue/read_ahead_kb
        echo "0" > /sys/block/mmcblk0/queue/rotational
        echo "0" > /sys/block/mmcblk0/queue/iostats
        echo "0" > /sys/block/mmcblk0/queue/add_random
        echo "1" > /sys/block/mmcblk0/queue/rq_affinity
        echo "0" > /sys/block/mmcblk0/queue/nomerges
        echo "1024" > /sys/block/mmcblk0/queue/nr_requests
        
        case $TUNED in
          1-13)
            echo "" | tee -a $MAGNELOG
            echo "- TUNED SUCCESSFULLY" | tee -a $MAGNELOG
          ;;

          false)
            echo "" | tee -a $MAGNELOG
            echo "- TUNED UNSUCCESSFULLY" | tee -a $MAGNELOG
          ;;
        esac           
      ;;  
    
      *)
        echo "- MAGNETAR SERVICE SCRIPT DIDN\'T RUN, $KYLIEKYLER ISN\'T SUPPORTED" | tee -a $MAGNELOG
        exit 0
      ;;
    esac
  ;;
  
  true)
    echo "- CONFLICTING MODULE FOUND, MAGNETAR SERVICE SCRIPT WON\'T RUN" | tee -a $MAGNELOG
    exit 1
  ;;
esac


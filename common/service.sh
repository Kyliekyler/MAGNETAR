#!/system/bin/sh
#   _____ __________ _____ ____ _____ _________  
#  |     | _  |   __|   | |  __|_   _| _  | __ | 
#  | | | |    |  |  | | | |  __| | | |    |   -| 
#  |_|_|_|_|__|_____|_|___|____| |_| |_|__|_|__| 
#                                  by Kyliekyler  

case $HALT in
  false)  
    case $KYLIEKYLER in
      whyred|bullhead|rosy|*H850*|wayne|jasmine*|beryllium|mido|daisy)
        # VARS IS HERE ====================================================//
        GOV=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
        NFSADJ1=0; NFSADJ2=117; NFSADJ3=235; NFSADJ4=411; NFSADJ5=823; NFSADJ6=1000 
        KYLIEKYLERA=16384; KYLIEKYLERB=24576; KYLIEKYLERC=32768; KYLIEKYLERD=65536; KYLIEKYLERE=131072; KYLIEKYLERF=163840

        if [ -d "/sys/class/kgsl/kgsl-3d0" ]; then
          GPU=$(/sys/class/kgsl/kgsl-3d0)
        else
          GPU=$(/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0)
        fi

        # THERMAL SCONFIG IS HERE =================================================//
        echo 13 > /sys/class/thermal/thermal_message/sconfig
 
        # ENTROPY IS HERE =========================================================//
        echo 1024 > /proc/sys/kernel/random/read_wakeup_threshold
        echo 4096 > /proc/sys/kernel/random/write_wakeup_threshold

        chmod 644 /sys/block/mmcblk0/queue/read_ahead_kb
        echo 1536 > /sys/block/mmcblk0/queue/read_ahead_kb
        chmod 644 /sys/block/mmcblk1/queue/read_ahead_kb
        echo 1536 > /sys/block/mmcblk1/queue/read_ahead_kb

        chmod 644 /sys/block/mmcblk0/queue/iostats
        chmod 644 /sys/block/mmcblk1/queue/iostats
        echo 0 > /sys/block/mmcblk0/queue/iostats
        echo 0 > /sys/block/mmcblk1/queue/iostats

        # VM IS HERE ==============================================================//
        echo 200 > /proc/sys/vm/dirty_expire_centisecs
        echo 300 > /proc/sys/vm/dirty_writeback_centisecs
        chmod 644 /proc/sys/vm/swappiness
        echo 100 > /proc/sys/vm/swappiness
        echo 20 > /proc/sys/vm/dirty_ratio
        echo 5 > /proc/sys/vm/dirty_background_ratio
        echo 1 > /proc/sys/vm/page-cluster
        echo 4096 > /proc/sys/vm/min_free_kb
        echo 20 > /proc/sys/fs/lease-break-time
        echo 4096 > /proc/sys/vm/min_free_kbytes
        echo 150 > /proc/sys/vm/vfs_cache_pressure

        # FSYNC IS HERE ===========================================================//
        echo N > /sys/module/sync/parameters/fsync_enabled
        echo 0 > /sys/module/sync/parameters/auto_fsync_delay_sec

        # FORCE FAST CHARGE IS HERE ===============================================//
        echo 1 > /sys/kernel/fast_charge/force_fast_charge

        # INPUT BOOST IS HERE =====================================================//
        chmod 644 /sys/kernel/cpu_input_boost/enabled
        echo 1 > /sys/kernel/cpu_input_boost/enabled
        
        chmod 644 /sys/module/cpu_boost/parameters/input_boost_enabled
        echo Y > /sys/module/cpu_boost/parameters/input_boost_enabled

        # PANIC IS HERE ===========================================================//
        chmod 644 /proc/sys/vm/panic_on_oom
        chmod 644 /proc/sys/kernel/panic
        chmod 644 /proc/sys/kernel/panic_on_oops
        echo 0 > /proc/sys/vm/panic_on_oom
        echo 0 > /proc/sys/kernel/panic
        echo 0 > /proc/sys/kernel/panic_on_oops

        echo 0 >  /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq
        echo 0 >  /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq 

        # PARAMETERS / MINFREE IS HERE ============================================//
        chmod 0666 /sys/module/lowmemorykiller/parameters/adj;
        chmod 0666 /sys/module/lowmemorykiller/parameters/minfree;
        
        echo 0 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk;
        echo $NFSADJ1,$NFSADJ2,$NFSADJ3,$NFSADJ4,$NFSADJ5,$NFSADJ6 > /sys/module/lowmemorykiller/parameters/adj;
        echo $KYLIEKYLERA,$KYLIEKYLERB,$KYLIEKYLERC,$KYLIEKYLERD,$KYLIEKYLERE,$KYLIEKYLERF > /sys/module/lowmemorykiller/parameters/minfree;

        # ANIMATION SCALE IS HERE =================================================//
        settings put global window_animation_scale 1
        settings put global transition_animation_scale 1
        settings put global animator_duration_scale 1

        # CPU SET TUNING IS HERE ==================================================//
        echo 100 > /sys/module/cpu_boost/parameters/input_boost_ms
        echo 0-7 > /dev/cpuset/top-app/cpus
        echo 0-7 > /dev/cpuset/game/cpus
        echo 0-7 > /dev/cpuset/gamelite/cpus
        echo 2-3,6-7 > /dev/cpuset/foreground/cpus
        echo 2-3 > /dev/cpuset/background/cpus
        echo 0-1 > /dev/cpuset/system-background/cpus

        echo 1 > /dev/stune/top-app/schedtune.colocate
        echo 1 > /dev/stune/top-app/schedtune.sched_boost_enabled
        echo 1 > /dev/stune/top-app/schedtune.sched_boost_no_override
        echo 0 > /dev/stune/top-app/schedtune.prefer_idle
        echo 0 > /dev/stune/top-app/schedtune.boost

        echo 0 > /dev/stune/foreground/schedtune.colocate
        echo 1 > /dev/stune/foreground/schedtune.sched_boost_enabled
        echo 0 > /dev/stune/foreground/schedtune.sched_boost_no_override
        echo 0 > /dev/stune/foreground/schedtune.prefer_idle
        echo 0 > /dev/stune/foreground/schedtune.boost

        echo 0 > /dev/stune/background/schedtune.colocate
        echo 1 > /dev/stune/background/schedtune.sched_boost_enabled
        echo 0 > /dev/stune/background/schedtune.sched_boost_no_override
        echo 0 > /dev/stune/background/schedtune.prefer_idle
        echo 0 > /dev/stune/background/schedtune.boost

        echo 0 > /dev/stune/schedtune.colocate
        echo 1 > /dev/stune/schedtune.sched_boost_enabled
        echo 0 > /dev/stune/schedtune.sched_boost_no_override
        echo 0 > /dev/stune/schedtune.prefer_idle
        echo 0 > /dev/stune/schedtune.boost

        #GPU IS HERE ==============================================================//
        if [ -e "/sys/class/kgsl/kgsl-3d0" ]; then
          echo 0 > /sys/class/kgsl/kgsl-3d0/throttling
          echo 0 > /sys/class/kgsl/kgsl-3d0/force_no_nap
          echo 0 > /sys/class/kgsl/kgsl-3d0/force_bus_on
          echo 0 > /sys/class/kgsl/kgsl-3d0/force_clk_on 
          echo 0 > /sys/class/kgsl/kgsl-3d0/force_rail_on
          echo 1 > /sys/class/kgsl/kgsl-3d0/bus_split
        elif [ -e "/sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0" ]; then
          echo 0 > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/throttling
          echo 0 > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_no_nap
          echo 0 > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_bus_on
          echo 0 > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_clk_on 
          echo 0 > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/force_rail_on
          echo 1 > /sys/devices/soc/*.qcom,kgsl-3d0/kgsl/kgsl-3d0/bus_split
        fi

        if [ -e "$GPU/max_pwrlevel" ]; then 
          echo 0 > $GPU/max_pwrlevel
        fi

        if [ -e "$GPU/devfreq/adrenoboost" ]; then 
          echo 2 > $GPU/devfreq/adrenoboost
        fi
        
        if [ -e "/sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate" ]; then 
          echo Y > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
          echo 1 > /sys/module/simple_gpu_algorithm/parameters/simple_gpu_activate
        fi

        # NETWORK SPEED BOOST IS HERE =============================================//
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
	
        # SDCARD BOOST IS HERE ====================================================//
        echo cfq > /sys/block/sda/queue/scheduler
        echo 1536 > /sys/block/sda/queue/read_ahead_kb
        echo 0 > /sys/block/sda/queue/rotational
        echo 0 > /sys/block/sda/queue/iostats
        echo 0 > /sys/block/sda/queue/add_random
        echo 1 > /sys/block/sda/queue/rq_affinity
        echo 0 > /sys/block/sda/queue/nomerges
        echo 1536 > /sys/block/sda/queue/nr_requests

        echo cfq > /sys/block/sdb/queue/scheduler
        echo 1536 > /sys/block/sdb/queue/read_ahead_kb
        echo 0 > /sys/block/sdb/queue/rotational
        echo 0 > /sys/block/sdb/queue/iostats
        echo 0 > /sys/block/sdb/queue/add_random
        echo 1 > /sys/block/sdb/queue/rq_affinity
        echo 0 > /sys/block/sdb/queue/nomerges
        echo 1536 > /sys/block/sdb/queue/nr_requests

        echo cfq > /sys/block/sdc/queue/scheduler
        echo 1536 > /sys/block/sdc/queue/read_ahead_kb
        echo 0 > /sys/block/sdc/queue/rotational
        echo 0 > /sys/block/sdc/queue/iostats
        echo 0 > /sys/block/sdc/queue/add_random
        echo 1 > /sys/block/sdc/queue/rq_affinity
        echo 0 > /sys/block/sdc/queue/nomerges
        echo 1536 > /sys/block/sdc/queue/nr_requests

        echo cfq > /sys/block/sdd/queue/scheduler
        echo 1536 > /sys/block/sdd/queue/read_ahead_kb
        echo 0 > /sys/block/sdd/queue/rotational
        echo 0 > /sys/block/sdd/queue/iostats
        echo 0 > /sys/block/sdd/queue/add_random
        echo 1 > /sys/block/sdd/queue/rq_affinity
        echo 0 > /sys/block/sdd/queue/nomerges
        echo 1536 > /sys/block/sdd/queue/nr_requests

        echo cfq > /sys/block/sde/queue/scheduler
        echo 1536 > /sys/block/sde/queue/read_ahead_kb
        echo 0 > /sys/block/sde/queue/rotational
        echo 0 > /sys/block/sde/queue/iostats
        echo 0 > /sys/block/sde/queue/add_random
        echo 1 > /sys/block/sde/queue/rq_affinity
        echo 0 > /sys/block/sde/queue/nomerges
        echo 1536 > /sys/block/sde/queue/nr_requests

        echo cfq > /sys/block/sdf/queue/scheduler
        echo 1536 > /sys/block/sdf/queue/read_ahead_kb
        echo 0 > /sys/block/sdf/queue/rotational
        echo 0 > /sys/block/sdf/queue/iostats
        echo 0 > /sys/block/sdf/queue/add_random
        echo 1 > /sys/block/sdf/queue/rq_affinity
        echo 0 > /sys/block/sdf/queue/nomerges
        echo 1536 > /sys/block/sdf/queue/nr_requests

        echo cfq > /sys/block/mmcblk0/queue/scheduler
        echo 1536 > /sys/block/mmcblk0/queue/read_ahead_kb
        echo 0 > /sys/block/mmcblk0/queue/rotational
        echo 0 > /sys/block/mmcblk0/queue/iostats
        echo 0 > /sys/block/mmcblk0/queue/add_random
        echo 1 > /sys/block/mmcblk0/queue/rq_affinity
        echo 0 > /sys/block/mmcblk0/queue/nomerges
        echo 1536 > /sys/block/mmcblk0/queue/nr_requests
	
        # BACKGROUND CPU IS HERE ==================================================//
        echo 0 > /dev/cpuset/background/cpus 
        echo 0 > /dev/cpuset/system-background/cpus
        
        # CPU IDLE IS HERE ========================================================//
        echo 0 >  /sys/devices/system/cpu/cpu0/sched_mostly_idle_freq
        echo 0 >  /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq
        echo 0 >  /sys/devices/system/cpu/cpu2/sched_mostly_idle_freq
        echo 0 >  /sys/devices/system/cpu/cpu4/sched_mostly_idle_freq
        echo 0 >  /sys/devices/system/cpu/cpu6/sched_mostly_idle_freq
        echo 0 >  /sys/devices/system/cpu/cpu1/sched_mostly_idle_freq
      ;;
      
      *)
        exit 1
      ;;
    esac
  ;;
  
  true)
    exit 1
  ;;
esac

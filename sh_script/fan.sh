#!/bin/bash
# set -x
set -e

CPU_QUIET=55
# FRONT_QUIET=50
FRONT_QUIET=35
NVME_QUIET=50
GPU_QUIET=25

CPU_LOUD=80
# FRONT_LOUD=70
FRONT_LOUD=60
NVME_LOUD=65
# GPU_LOUD=70
GPU_LOUD=47

CPU_PANIC=94
# FRONT_PANIC=95
FRONT_PANIC=70
NVME_PANIC=100
GPU_PANIC=85

QUIET_TRIGGER=50
LOUD_TRIGGER=60
PANIC_TRIGGER=70

CPU_QUIET_TRIGGER=68
CPU_LOUD_TRIGGER=75
CPU_PANIC_TRIGGER=89

GPU_QUIET_TRIGGER=60
GPU_LOUD_TRIGGER=70
GPU_PANIC_TRIGGER=85

CPU_FAN=pwm1
# CPU_BIS_FAN=pwm2
NVME_FAN=pwm3  # back
FRONT_FAN=pwm5

REFRESH_SEC=3
MEAN_SIZE=10

MIN_INTERVAL=60


FAN_DIR=$(find /sys/devices/platform/nct6687.*/hwmon -maxdepth 1 -type d | tail -n 1)


enable_fans() {
    for f in "$FAN_DIR"/pwm*_enable; do
        echo 1 > "$f"
    done
    chmod +s /usr/lib/Xorg
    # nvidia-settings -a "[gpu:0]/GPUFanControlState=1" >/dev/null
    # nvidia-settings -a "[gpu:0]/GPUPowerMizerMode=1" >/dev/null
}

set_cpu_speed() {
    local speed="$1"
    local force="$2"
    if ! test "$force"; then
        test "$speed" = "$CPU_SPEED" && return
        if test "$CPU_SPEED" && (($speed < $CPU_SPEED)); then
            (($COOL_DELAY < $MIN_INTERVAL)) && echo "Delaying CPU slowdown" && return
        else
            COOL_DELAY=1
        fi
    fi
    echo "$speed" > "$FAN_DIR/$CPU_FAN"
    echo "Setting CPU fan speed to $(to100 $speed)% (was $(to100 $CPU_SPEED)% at $CPU_TEMP_MEAN°C)."
    CPU_SPEED="$speed"
}

set_front_speed() {
    local speed="$1"
    local force="$2"
    if ! test "$force"; then
        test "$speed" = "$FRONT_SPEED" && return
        if test "$FRONT_SPEED" && (($speed < $FRONT_SPEED)); then
            (($COOL_DELAY < $MIN_INTERVAL)) && echo "Delaying FRONT slowdown" && return
        else
            COOL_DELAY=1
        fi
    fi
    echo "$speed" > "$FAN_DIR/$FRONT_FAN"
    echo "Setting FRONT fan speed to $(to100 $speed)% (was $(to100 $FRONT_SPEED)% at $MOBO_TEMP_MEAN°C)."
    FRONT_SPEED="$speed"
}

set_nvme_speed() {
    local speed="$1"
    local force="$2"
    if ! test "$force"; then
        test "$speed" = "$NVME_SPEED" && return
        if test "$NVME_SPEED" && (($speed < $NVME_SPEED)); then
            (($COOL_DELAY < $MIN_INTERVAL)) && echo "Delaying NVME_SPEED slowdown" && return
        else
            COOL_DELAY=1
        fi
    fi
    echo "$speed" > "$FAN_DIR/$NVME_FAN"  # left (front)
    echo "Setting NVME fan speed to $(to100 $speed)% (was $(to100 $NVME_SPEED)% at $NVME_TEMP_MEAN°C)."
    NVME_SPEED="$speed"
}

set_gpu_speed() {
    local speed="$1"
    local force="$2"
    if ! test "$force"; then
        test "$speed" = "$GPU_SPEED" && return
        if test "$GPU_SPEED" && (($speed < $GPU_SPEED)); then
            (($COOL_DELAY < $MIN_INTERVAL)) && echo "Delaying GPU slowdown" && return
        else
            COOL_DELAY=1
        fi
    fi
    # nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=$speed" >/dev/null
    echo "Setting GPU fan speed to $speed% (was $GPU_SPEED% at $GPU_TEMP_MEAN°C)."
    GPU_SPEED="$speed"

    # best you can do is: /sys/class/drm/card1/device/gpu_od/fan_ctrl
}

to255() {
    echo $(($1 * 255 / 100))
}

to100() {
    test "$1" && echo $(($1 * 100 / 255)) || echo "??"
}

init_fans() {
    CPU_QUIET=$(to255 $CPU_QUIET)
    FRONT_QUIET=$(to255 $FRONT_QUIET)
    NVME_QUIET=$(to255 $NVME_QUIET)

    CPU_LOUD=$(to255 $CPU_LOUD)
    FRONT_LOUD=$(to255 $FRONT_LOUD)
    NVME_LOUD=$(to255 $NVME_LOUD)

    CPU_PANIC=$(to255 $CPU_PANIC)
    FRONT_PANIC=$(to255 $FRONT_PANIC)
    NVME_PANIC=$(to255 $NVME_PANIC)

    set_cpu_speed $CPU_QUIET
    set_front_speed $FRONT_QUIET
    set_nvme_speed $NVME_QUIET
    set_gpu_speed $GPU_QUIET
}


mean_temps() {
    CPU_TEMP_LIST=$(echo "$CPU_TEMP_LIST
$CPU_TEMP" | grep . | tail -n -$MEAN_SIZE)
    MOBO_TEMP_LIST=$(echo "$MOBO_TEMP_LIST
$MOBO_TEMP" | grep . | tail -n -$MEAN_SIZE)
    NVME_TEMP_LIST=$(echo "$NVME_TEMP_LIST
$NVME_TEMP" | grep . | tail -n -$MEAN_SIZE)
    GPU_TEMP_LIST=$(echo "$GPU_TEMP_LIST
$GPU_TEMP" | grep . | tail -n -$MEAN_SIZE)

    if (($(echo "$CPU_TEMP_LIST" | wc -l) < $MEAN_SIZE)); then
        CPU_TEMP_MEAN=$CPU_TEMP
        MOBO_TEMP_MEAN=$MOBO_TEMP
        NVME_TEMP_MEAN=$NVME_TEMP
        GPU_TEMP_MEAN=$GPU_TEMP
    else
        CPU_TEMP_MEAN=$(($(echo "$CPU_TEMP_LIST" | paste -s -d+ | bc) / $MEAN_SIZE))
        MOBO_TEMP_MEAN=$(($(echo "$MOBO_TEMP_LIST" | paste -s -d+ | bc) / $MEAN_SIZE))
        NVME_TEMP_MEAN=$(($(echo "$NVME_TEMP_LIST" | paste -s -d+ | bc) / $MEAN_SIZE))
        GPU_TEMP_MEAN=$(($(echo "$GPU_TEMP_LIST" | paste -s -d+ | bc) / $MEAN_SIZE))
    fi
}

get_temps() {
    local sensors_out=$(sensors)
    local rgx='s/.*[^=] \+?([0-9]+).*°?C.*/\1/'
    CPU_TEMP=$(echo "$sensors_out" \
                   | grep Tdie \
                   | sed -E "$rgx")
    MOBO_TEMP=$(echo "$sensors_out" \
                   | grep -m 1 temp1 \
                   | sed -E "$rgx")
    # NVME_TEMP=$(echo "$sensors_out" \
    #                | grep Composite \
    #                | sed -E "$rgx")
    NVME_TEMP=$(nvme smart-log /dev/nvme0 \
                    | grep temp \
                    | sed -E "$rgx")
    GPU_TEMP=$(echo "$sensors_out" \
                   | grep edge \
                   | sed -E "$rgx")
    if $(echo "$MOBO_TEMP" | grep -q 'N/A'); then
        #TODO: I think when the kernel is rebuilt the it87 mod isn't reloaded,
        # so the mobo sensor won't show up till next reboot.
        # We'll use another sensor from the mobo, that seems pretty close...
        MOBO_TEMP=$(echo "$sensors_out" \
                        | grep -m2 temp1 \
                        | tail -n1 \
                        | sed -E "$rgx")
        echo "Warning: no mobo temp found, using a random sensor instead..."
    fi
    mean_temps
    MAX_TEMP=$(echo "
$GPU_TEMP_MEAN
$NVME_TEMP_MEAN
$MOBO_TEMP_MEAN" | sort -n | tail -n1)
}

handle_gpu() {
    if (($GPU_TEMP_MEAN >= $GPU_PANIC_TRIGGER)); then
        set_gpu_speed 100
    elif (($GPU_TEMP_MEAN >= $GPU_LOUD_TRIGGER)) \
             || test -e /tmp/fan.gpu; then
        set_gpu_speed $GPU_PANIC
    elif (($GPU_TEMP_MEAN >= $GPU_QUIET_TRIGGER)); then
        set_gpu_speed $GPU_LOUD
    else
        set_gpu_speed $GPU_QUIET
    fi
}

handle_cpu() {
    if (($CPU_TEMP_MEAN >= $CPU_PANIC_TRIGGER)); then
        set_cpu_speed 255
    elif (($CPU_TEMP_MEAN >= $CPU_LOUD_TRIGGER)); then
        set_cpu_speed $CPU_PANIC
    elif (($CPU_TEMP_MEAN >= $CPU_QUIET_TRIGGER)); then
        set_cpu_speed $CPU_LOUD
    else
        set_cpu_speed $CPU_QUIET
    fi
}

handle_nvme() {  # back
    if (($MAX_TEMP >= $PANIC_TRIGGER)) \
           || (($CPU_TEMP_MEAN >= $CPU_PANIC_TRIGGER)); then
        set_nvme_speed $NVME_PANIC
    elif (($MAX_TEMP >= $QUIET_TRIGGER)) \
           || (($CPU_TEMP_MEAN >= $CPU_LOUD_TRIGGER)); then
        set_nvme_speed $NVME_LOUD
    else
        set_nvme_speed $NVME_QUIET
    fi
}

handle_front() {
    if (($MAX_TEMP >= $PANIC_TRIGGER)) \
           || (($CPU_TEMP_MEAN >= $CPU_PANIC_TRIGGER)); then
        set_front_speed $FRONT_PANIC
    elif (($MAX_TEMP >= $LOUD_TRIGGER)) \
             || (($CPU_TEMP_MEAN >= $CPU_LOUD_TRIGGER)); then
        set_front_speed $FRONT_LOUD
    else
        set_front_speed $FRONT_QUIET
    fi
}

status() {
    echo
    date
    cat <<EOF
CPU:   $CPU_TEMP_MEAN°C  $(to100 $CPU_SPEED)%
GPU:   $GPU_TEMP_MEAN°C  $GPU_SPEED%
FRONT: $MOBO_TEMP_MEAN°C  $(to100 $FRONT_SPEED)%
NVME:  $NVME_TEMP_MEAN°C  $(to100 $NVME_SPEED)%
EOF
}


printf 'Starting SuperFan3000!\n\n'

if ! test -d "$FAN_DIR"; then
    echo "invalid fan dir '$FAN_DIR'"
    exit 42
fi
enable_fans
test $1 && return
init_fans

i=1
COOL_DELAY=$MIN_INTERVAL
while true; do
    get_temps

    if ! ((i % $REFRESH_SEC)); then
        if test -e /tmp/fan.panic; then
            echo "PANIC!"
            # set_gpu_speed $(test -e /tmp/fan.gpu && echo $GPU_PANIC || echo $GPU_LOUD)
            set_cpu_speed $CPU_PANIC
            set_nvme_speed $NVME_LOUD
            set_front_speed $FRONT_LOUD
        else
            handle_gpu
            handle_cpu
            handle_nvme
            handle_front
        fi
    fi

    ((i++ % 30)) || status
    ((COOL_DELAY++))
    sleep 1
done

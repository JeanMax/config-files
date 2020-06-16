#!/bin/bash
# set -x
set -e

# fan1: cpu
# fan2: front
# fan3: nvme
# fan'4': gpu

CPU_QUIET=45
FRONT_QUIET=37
NVME_QUIET=30
GPU_QUIET=25

CPU_LOUD=80
FRONT_LOUD=49
NVME_LOUD=50
GPU_LOUD=47

# 100% if over

QUIET_TRIGGER=45
LOUD_TRIGGER=60
PANIC_TRIGGER=80

REFRESH_SEC=3


FAN_DIR=/sys/devices/platform/it87.2624/hwmon/hwmon2


enable_fans() {
    for pwm in pwm{1..3}; do
        echo 1 > "$FAN_DIR/$pwm"_enable
    done
    nvidia-settings -a "[gpu:0]/GPUFanControlState=1" >/dev/null
}

set_cpu_speed() {
    local speed="$1"
    test "$speed" = "$CPU_SPEED" && return
    echo "$speed" > "$FAN_DIR"/pwm1
    echo "Setting CPU fan speed to $(to100 $speed)% (was $(to100 $CPU_SPEED)% at $CPU_TEMP_MEAN°C)."
    CPU_SPEED="$speed"
}

set_front_speed() {
    local speed="$1"
    test "$speed" = "$FRONT_SPEED" && return
    echo "$speed" > "$FAN_DIR"/pwm2
    echo "Setting FRONT fan speed to $(to100 $speed)% (was $(to100 $FRONT_SPEED)% at $WIFI_TEMP_MEAN°C)."
    FRONT_SPEED="$speed"
}

set_nvme_speed() {
    local speed="$1"
    test "$speed" = "$NVME_SPEED" && return
    echo "$speed" > "$FAN_DIR"/pwm3
    echo "Setting NVME fan speed to $(to100 $speed)% (was $(to100 $NVME_SPEED)% at $NVME_TEMP_MEAN°C)."
    NVME_SPEED="$speed"
}

set_gpu_speed() {
    local speed="$1"
    test "$speed" = "$GPU_SPEED" && return
    nvidia-settings -a "[fan:0]/GPUTargetFanSpeed=$speed" >/dev/null
    echo "Setting GPU fan speed to $speed% (was $GPU_SPEED% at $GPU_TEMP_MEAN°C)."
    GPU_SPEED="$speed"
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

    set_cpu_speed $CPU_QUIET
    set_front_speed $FRONT_QUIET
    set_nvme_speed $NVME_QUIET
    set_gpu_speed $GPU_QUIET
}


mean_temps() {
    CPU_TEMP_LIST=$(echo "$CPU_TEMP_LIST
$CPU_TEMP" | grep . | tail -n -$REFRESH_SEC)
    WIFI_TEMP_LIST=$(echo "$WIFI_TEMP_LIST
$WIFI_TEMP" | grep . | tail -n -$REFRESH_SEC)
    NVME_TEMP_LIST=$(echo "$NVME_TEMP_LIST
$NVME_TEMP" | grep . | tail -n -$REFRESH_SEC)
    GPU_TEMP_LIST=$(echo "$GPU_TEMP_LIST
$GPU_TEMP" | grep . | tail -n -$REFRESH_SEC)

    if (($(echo "$CPU_TEMP_LIST" | wc -l) < $REFRESH_SEC)); then
        CPU_TEMP_MEAN=$CPU_TEMP
        WIFI_TEMP_MEAN=$WIFI_TEMP
        NVME_TEMP_MEAN=$NVME_TEMP
        GPU_TEMP_MEAN=$GPU_TEMP
    else
        CPU_TEMP_MEAN=$(($(echo "$CPU_TEMP_LIST" | paste -s -d+ | bc) / $REFRESH_SEC))
        WIFI_TEMP_MEAN=$(($(echo "$WIFI_TEMP_LIST" | paste -s -d+ | bc) / $REFRESH_SEC))
        NVME_TEMP_MEAN=$(($(echo "$NVME_TEMP_LIST" | paste -s -d+ | bc) / $REFRESH_SEC))
        GPU_TEMP_MEAN=$(($(echo "$GPU_TEMP_LIST" | paste -s -d+ | bc) / $REFRESH_SEC))
    fi
}

get_temps() {
    local sensors_out=$(sensors)
    local rgx='s/.*\+([0-9]+).*°C .*/\1/'
    CPU_TEMP=$(echo "$sensors_out" \
                   | grep Tdie \
                   | sed -E "$rgx")
    WIFI_TEMP=$(echo "$sensors_out" \
                   | grep -m 1 temp1 \
                   | sed -E "$rgx")
    NVME_TEMP=$(echo "$sensors_out" \
                   | grep Composite \
                   | sed -E "$rgx")
    GPU_TEMP=$(nvidia-settings -tq gpucoretemp \
                   | head -n1)
    mean_temps
}

handle_gpu() {
    if (($GPU_TEMP_MEAN >= $PANIC_TRIGGER)); then
        set_gpu_speed 100
    elif (($GPU_TEMP_MEAN >= $LOUD_TRIGGER)); then
        set_gpu_speed $GPU_LOUD
    elif (($GPU_TEMP_MEAN >= $QUIET_TRIGGER)); then
        set_gpu_speed $GPU_QUIET
    else
        set_gpu_speed 0
    fi
}

handle_cpu() {
    if (($CPU_TEMP_MEAN >= $PANIC_TRIGGER)); then
        set_cpu_speed 255
    elif (($CPU_TEMP_MEAN >= $LOUD_TRIGGER)); then
        set_cpu_speed $CPU_LOUD
    else
        set_cpu_speed $CPU_QUIET
    fi
}

handle_nvme() {
    if (($NVME_TEMP_MEAN >= $PANIC_TRIGGER)); then
        set_nvme_speed 255
    elif (($NVME_TEMP_MEAN >= $LOUD_TRIGGER)); then
        set_nvme_speed $NVME_LOUD
    elif (($NVME_TEMP_MEAN >= $QUIET_TRIGGER)); then
        set_nvme_speed $NVME_QUIET
    else
        set_nvme_speed 0
    fi
}

handle_front() {
    local max_temp=$(echo "$CPU_TEMP_MEAN
$GPU_TEMP_MEAN
$NVME_TEMP_MEAN
$WIFI_TEMP_MEAN" | sort -n | tail -n1)

    if (($max_temp >= $PANIC_TRIGGER)); then
        set_front_speed 255
    elif (($max_temp >= $LOUD_TRIGGER)); then
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
FRONT: $WIFI_TEMP_MEAN°C  $(to100 $FRONT_SPEED)%
NVME:  $NVME_TEMP_MEAN°C  $(to100 $NVME_SPEED)%
EOF
}


printf 'Starting SuperFan3000!\n\n'

enable_fans
init_fans

i=1
while true; do
    get_temps

    if ! ((i % $REFRESH_SEC)); then
        handle_gpu
        handle_cpu
        handle_nvme
        handle_front
    fi

    ((i++ % 30)) || status
    sleep 1
done

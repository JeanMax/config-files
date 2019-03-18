#!/bin/bash

OUT=/etc/thinkfan.conf

find_thermo() {
	find /sys/devices -type f -regex ".*\(temp[0-9]_input\|thermal_zone[0-9]/temp\)"
}

for i in {0..100}; do
	find_thermo | grep -q zone1 && break
	sleep 0.2
done

echo tp_fan /proc/acpi/ibm/fan > $OUT

for i in $(find_thermo); do
	echo hwmon $i >> $OUT
done

echo "
(2,   0,  55)
(4,   47, 72)
(6,   62, 84)
(127, 75, 32767)" >> $OUT

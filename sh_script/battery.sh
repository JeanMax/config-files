#!/bin/bash

CHARGE_START=90
CHARGE_STOP=95

BAT=1


forceDischarge() {
	tpacpi-bat -s forceDischarge $BAT $1
}


if (( EUID != 0 )); then
	echo "This script should be run as root!" >& 2
	exit 1
fi

acpi=$(acpi -ab)
percent=$(echo "$acpi" | head -n 1 | sed -E 's/.* ([0-9]+)%.*/\1/')
status=$(echo "$acpi" | head -n 1 | sed -E 's/.*: (\w+).*/\1/')

if echo "$acpi" | grep -q 'on-line'; then
	if [ $status = Discharging ]; then
		if [ $percent -lt $CHARGE_START ]; then
			forceDischarge 0
			echo "Charging!"
			exit
		fi
	else  # $status = Charging || $status = Full
		if [ $percent -gt $CHARGE_STOP ]; then
			forceDischarge 1
			echo "Discharging!"
			exit
		fi
	fi
else
	if $(tpacpi-bat -g forceDischarge $BAT) = yes; then
		forceDischarge 0
		echo "Disabling force-discharge."
		exit
	fi
fi
echo "Nothing to do..."

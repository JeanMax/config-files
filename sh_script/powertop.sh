echo 1 > /sys/module/snd_hda_intel/parameters/power_save
echo 0 > /proc/sys/kernel/nmi_watchdog

# VM writeback timeout
echo 1500 > /proc/sys/vm/dirty_writeback_centisecs

# Enable SATA link power management
for i in {0..8}; do
    echo med_power_with_dipm > /sys/class/scsi_host/host$i/link_power_management_policy
done

# Runtime PM for I2C Adapter i2c-5 (NVIDIA i2c adapter 9 at 8:00.0)
echo auto > /sys/bus/i2c/devices/i2c-5/device/power/control
# Runtime PM for I2C Adapter i2c-7 (SMBus PIIX4 adapter port 2 at 0b00)
echo auto > /sys/bus/i2c/devices/i2c-7/device/power/control

# Autosuspend for USB device CHERRY Wireless Desktop [Cherry GmbH]
echo auto > /sys/bus/usb/devices/3-2/power/control

# Autosuspend for USB device ITE Device(8595) [ITE Tech. Inc.]
echo auto > /sys/bus/usb/devices/1-1/power/control;

# Runtime PM for port ata$i of PCI device: Advanced Micro Devices, Inc. [AMD] FCH SATA Controller [AHCI mode]
for i in {1..9}; do
    echo auto > /sys/bus/pci/devices/0000:07:00.0/ata$i/power/control;
done

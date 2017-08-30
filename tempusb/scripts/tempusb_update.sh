#!/bin/sh

eval `dbus export tempusb_`

if [ "$tempusb_enable" != "1" ]; then
    echo "not enable"
    exit
fi

now=`date`

die () {
    echo $1
    dbus ram tempusb_last_act="$now: failed($1)"
}
#get cpu temperature
tempusb_last_temp=`cat /proc/dmu/temperature|awk  -F ': '  '{print $2}'| cut -b 1-2`
#cat /proc/dmu/temperature | sed -r 's/[^0-9.]+//g'
tempusb_usb_status="close"

if [ "$tempusb_last_temp" -ge "$tempusb_up" ];then
	echo "open"
	tempusb_usb_status="open"
fi

if [ "$tempusb_last_temp" -le "$tempusb_down" ];then
	echo "close"
	tempusb_usb_status="close"
fi


#echo blacklist usb_storage >> /etc/modprobe.d/blacklist.conf

#echo suspend > /sys/bus/usb/devices/usb1/power/level
#echo on > /sys/bus/usb/devices/usb1/power/level
#echo disabled > /sys/bus/usb/devices/usb1/power/wakeup
#echo enabled > /sys/bus/usb/devices/usb1/power/wakeup

#--------------------------------------------------------------------------------
# https://github.com/RMerl/asuswrt-merlin/blob/583fd39588955d4a8564a106cb64f5c34beb113e/release/src-rt-7.x.main/src/linux/linux-2.6.36/Documentation/usb/power-management.txt
# https://www.kernel.org/doc/Documentation/usb/power-management.txt
#--------------------------------------------------------------------------------


#echo "0" > "/sys/bus/usb/devices/usbX/power/autosuspend"

#echo "auto" > "/sys/bus/usb/devices/usbX/power/control"
#echo "on" > "/sys/bus/usb/devices/usbX/power/control"

# 另一种尝试
# 禁用USB口
#/sbin/modprobe -r usb-uhci
# 启用USB口
#/sbin/modprobe -a usb-uhci

dbus ram tempusb_last_act="$now: $tempusb_last_temp ($tempusb_usb_status)"
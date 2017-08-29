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

tempusb_usb_status="close"

if [ "$tempusb_last_temp" -gt "$tempusb_up" ];then
	echo "open"
	tempusb_usb_status="open"
fi

if [ "$tempusb_last_temp" -le "$tempusb_down" ];then
	echo "close"
	tempusb_usb_status="close"
fi

dbus ram tempusb_last_act="$now: $tempusb_last_temp ($tempusb_usb_status)"
#!/bin/sh

eval `dbus export tempusb_`

if [ "$tempusb_enable" != "1" ]; then
    echo "not enable"
    exit
fi

now=`date`

die(){
	echo $1
	dbus ram tempusb_last_act="$now:failed($1)"

}

dbus ram tempusb_last_act="$now:failed"
#!/bin/sh

eval `dbus export tempusb_`

if [ "$tempusb_enable" != "1" ]; then
    echo "not enable"
    exit
fi

now=`date`

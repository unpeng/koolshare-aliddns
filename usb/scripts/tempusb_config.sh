#!/bin/sh

if [ "`dbus get tempusb_enable`" = "1" ]; then
    dbus delay tempusb_timer `dbus get tempusb_interval` /koolshare/scripts/tempusb_update.sh
else
    dbus remove __delay__tempusb_timer
fi

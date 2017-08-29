#!/bin/sh

cp -r /tmp/tempusb/* /koolshare/
chmod a+x /koolshare/scripts/tempusb_*

# add icon into softerware center
dbus set softcenter_module_tempusb_install=1
dbus set softcenter_module_tempusb_version=0.1
dbus set softcenter_module_tempusb_description="USB Temp(测试)"
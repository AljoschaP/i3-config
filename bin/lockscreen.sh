#!/bin/sh
# Based on https://raw.githubusercontent.com/aminb/usb-lock/master/onusbunplug.sh

getXuser() {
        user=`pinky| grep -m1 ":$displaynum" | awk '{print $1}'`
 
        if [ x"$user" != x"" ]; then
                userhome=`getent passwd $user | cut -d: -f6`
                export XAUTHORITY="$userhome/.Xauthority"
        else
                export XAUTHORITY=""
        fi
}

for x in /tmp/.X11-unix/*; do
    displaynum=`echo $x | sed s#/tmp/.X11-unix/X##`
    getXuser
    if [ x"$XAUTHORITY" != x"" ]; then
        # extract current state
	export DISPLAY=":$displaynum"
    fi
done

su "$user" -c "/usr/bin/i3lock -c 000000"

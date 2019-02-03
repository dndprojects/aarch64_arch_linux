#!/bin/csh

mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir/IRSEND -m '{ "protocol": "NEC", "bits": 32, "data": 5EA17887 }'

set process=`ps -adef | egrep "mpg123|ogg123" | grep -v grep | awk '{print $2}'`
set total=`echo $process | wc -l`
if ($total > 0 ) then
kill -9 $process
endif

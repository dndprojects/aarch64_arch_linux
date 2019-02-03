#!/bin/csh

cd /media/music
cd $1 

set process=`ps -adef | egrep "mpg123|ogg123" | grep -v grep | awk '{print $2}'`
set total = `echo $process | wc -l`
if ($total > 0 ) then
kill -9 $process
endif

sleep 3
mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir/IRSEND -m '{ "protocol": "NEC", "bits": 32, "data": 5EA1B847 }'

sleep 3
mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir/IRSEND -m '{ "protocol": "NEC", "bits": 32, "data": 5EA1A857 }'

set ogg = `\ls -1 *.ogg | wc -l`
if ($ogg > 0 ) then
 ogg123  *.ogg > /dev/null
endif

set mp3 = `\ls -1 *.mp3 | wc -l`
if ($mp3 > 0 ) then
 mpg123 -z *.mp3 > /dev/null
endif

mosquitto_pub -h 192.168.1.3 -t cmnd/sonoff_ir/IRSEND -m '{ "protocol": "NEC", "bits": 32, "data": 5EA17887 }'

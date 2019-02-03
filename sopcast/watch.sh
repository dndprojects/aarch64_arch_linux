#!/bin/bash
set -x

#sop://broker.sopcast.com:3912/258825

# Some basic sanity check for the URL
URL=$1
PORT=8908
[[ $URL =~ ^sop:// ]] || { echo "Usage: $0 sop://URL"; exit 1; }

# Make sure local port is not in use
netstat -vant | grep $PORT | grep -q LISTEN && { 
 echo "Port $PORT is in use, incr PORT";
 let "PORT++" ; echo "new port is $PORT"; }
# add locale libstdc++.so.5
cd $(dirname $0)
export LD_LIBRARY_PATH=$(pwd)

#./qemu-i386 lib/ld-linux.so.2 --library-path lib ./sp-sc-auth $URL 3908 $PORT >/dev/null &
./qemuaarch-i386 lib/ld-linux.so.2 --library-path lib ./sp-sc-auth -u ezradnd@walla.com:topgan12 $URL 3908 $PORT >/dev/null &
_PID=$!

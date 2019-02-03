#!/usr/bin/env python

# -*- coding: utf-8 -*-


import urllib.request
import sys
import time


time_to_sleep = str(sys.argv[1])
url = str(sys.argv[2])

htmlfile = urllib.request.urlopen(url.replace("=Off","=On"))
htmltext = htmlfile.read()

time.sleep(60 * float(time_to_sleep))
#print(time_to_sleep + ' ' + url)

htmlfile = urllib.request.urlopen(url)
htmltext = htmlfile.read()

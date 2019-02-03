#!/bin/bash
DomoticzIP="192.168.1.3
DomoticzPort="8081"
TempFileDir="/var/tmp/"
WhatsappPath="/home/pi/domoticz/Whatsapp/"			# your Whatsapp install directory
WhatsappHomePath=$WhatsappPath"yowsup/"				# your yowsub directory
WhatsappConfigFile=$WhatsappHomePath"yowsup/config"
WhatsappRecipient1=316********					# your Whatsapp recipients
WhatsappRecipient2=316********
 
yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient1 "Doorbell Pressed"
yowsup-cli demos -c $WhatsappConfigFile -s $WhatsappRecipient2 "Doorbell Pressed"

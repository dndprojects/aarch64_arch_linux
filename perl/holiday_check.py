#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import datetime
from convertdate import hebrew

def getJewishMonthName(month):

  if month == 1:
    return "Nisan"
  elif month == 2:
    return "Iyyar"
  elif month == 3:
    return "Sivan"
  elif month == 4:
    return "Tammuz"
  elif month == 5:
    return "Av"
  elif month == 6:
    return "Elul"
  elif month == 7:
    return "Tishri"
  elif month == 8:
    return "Heshvan"
  elif month == 9:
    return "Kislev"
  elif month == 10:
    return "Teveth"
  elif month == 11:
    return "Shevat"
  elif month == 12:
#    if date_utils.calendar_util.hebrew_leap(year):
      return "Adar I"
#    else:
#      return "Adar"
  elif month == 13:
    return "Adar II"

now = datetime.datetime.now()
hebrew_date = hebrew.from_gregorian(now.year, now.month, now.day)

today = datetime.date.today()
next_day = today + datetime.timedelta(days=1)

chag = ['15_Nisan', '21_Nisan', '6_Sivan','1_Tishri', '2_Tishri','10_Tishri', '15_Tishri', '22_Tishri']
day_to_print = "false"
next_day_to_print = "false"
erev_shabbat = "false"
m = getJewishMonthName(hebrew_date[1])
d = str(hebrew_date[2])
next_d = str(hebrew_date[2] + 1)
day_to_check = d+'_'+m
next_day_to_check = next_d+'_'+m

if day_to_check in chag:
   day_to_print = "true"
if next_day_to_check in chag:
   next_day_to_print = "true"
   erev_shabbat = "true"
   
if today.strftime('%A') == "Friday":
   erev_shabbat = "true"
if today.strftime('%A') == "Saturday":
   day_to_print = "true"
if next_day.strftime('%A') == "Saturday":
   next_day_to_print = "true"


#for i in range(7):
#    tmp_date = sunday + datetime.timedelta(i)
#print (today.strftime('%A'), '...', next_day.strftime('%A'))
#print (next_day_to_check)
sys.stdout.write(day_to_print+';'+next_day_to_print+';'+erev_shabbat)




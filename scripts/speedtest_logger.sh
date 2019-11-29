#!/usr/bin/env bash

# crontab 
# run every 5 minutes
# */5 * * * * /home/stereosonic/bin/speedtest_logger.sh

LOG_PATH="/media/usb/dropbox/speedtest.log"

if result=$(/usr/local/bin/speedtest --simple); then
  parsed_result=$(printf "${result}\"" | sed ':a;N;$!ba;s/\n/" /g' | sed 's/: /="/g')
  printf "[$(date)] ${parsed_result}\n" >> "${LOG_PATH}"
else
  printf "[$(date)] error\n" >> "${LOG_PATH}"
  exit 1
fi
exit 0
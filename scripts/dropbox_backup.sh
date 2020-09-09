#!/bin/sh

rclone copy /data/backups MyDropbox:backup/raspi4

# every 5 minutes
# */5 * * * * /home/stereosonic/raspberrypi/scripts/dropbox_backup.sh

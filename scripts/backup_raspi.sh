#!/bin/bash
####################################
#
# Backup script.
#
####################################

# crontab every day at 12 pm
# 0 0 * * * bash /home/stereosonic/raspberrypi/scripts/backup_raspi.sh
# What to backup. 
backup_files="/home /etc /root"

# Where to backup to.
dest="/data/backups/backups"

# Create archive filename.
day=$(date +%Y-%m-%d_%H-%M)
hostname=$(hostname -s)
archive_file="$hostname-$day-backup.tgz"

# Print start status message.
echo "Backing up $backup_files to $dest/$archive_file"
date
echo

echo "delete old backup"
find $dest -type f -mtime +2 -iname '*-backup.tgz' -delete

# Backup the files using tar.
tar czf $dest/$archive_file $backup_files

# Print end status message.
echo
echo "Backup finished"
date

# Long listing of files in $dest to check file sizes.
ls -lh $dest

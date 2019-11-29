#!/bin/bash

# crontab run evey 5 minutes
# */5 * * * * /home/stereosonic/bin/dropbox_upload.sh >> /tmp/sync.log
HOME=/media/usb/dropbox
CONFIG_DIR=/home/stereosonic

cd $HOME
docker run -i --rm --user=$(id -u):$(id -g) -v $CONFIG_DIR:/config -v $HOME:/workdir stereosupersonic/dropbox_uploader:latest_pi upload * /
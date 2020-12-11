# raspberrypi

some scripts and docs about raspberry


## setup traefik

git clone git@github.com:stereosupersonic/raspberrypi.git

cd raspberrypi

sudo docker-compose -f traefik.yml up -d

> First make it work, then make it beautiful.

## setup cron

example
```
# postgres backup once a day
0 1 * * * /home/stereosonic/raspberrypi/scripts/postgres_backup.sh >> /tmp/postgres_backup.log 2>&1

# alive info every 5 min
*/5 * * * * sudo raspberrypi/scripts/raspi-info >> /data/backups/`hostname`.log 2>&1

# copy the backup folder with the dropbox every 5 min
*/5 * * * * /home/stereosonic/raspberrypi/scripts/dropbox_backup.sh  >> /tmp/dropbox_backup.log 2>&1

# data backup once a day
0 0 * * * sudo /home/stereosonic/raspberrypi/scripts/backup_raspi.sh >> /tmp/backup.log 2>&1
```


## restore postgres backups

cat /data/backups/radiar_production_2020-08-09-02:00:08.dump.sql | docker exec -i postgresdb pg_restore -U postgres -d radiar_production


# setup a grafana system dashboard

https://grafana.com/grafana/dashboards/5955


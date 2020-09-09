# raspberrypi

some scripts and docs about raspberry


## setup traefik 

git clone git@github.com:stereosupersonic/raspberrypi.git

cd raspberrypi

sudo docker-compose -f traefik.yml up -d

> First make it work, then make it beautiful.

## restore postgres backups

cat /data/backups/radiar_production_2020-08-09-02:00:08.dump.sql | docker exec -i postgresdb pg_restore -U postgres -d radiar_production

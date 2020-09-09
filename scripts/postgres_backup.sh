#!/usr/bin/env ruby

# add it to cron like
# every day at 1 am
# * 1 * * * ruby /home/stereosonic/raspberrypi/scripts/postgresql_backup >> /tmp/postgres_backup.log 2>&1

# 2>&1 means  redirect stderr to stdout https://stackoverflow.com/questions/818255/in-the-shell-what-does-21-mean

BACKUP_DIR="/data/backups/postgresql"

`mkdir -p #{BACKUP_DIR}`

#remove old backups
puts `find #{BACKUP_DIR} -type f -mtime +2 -iname '*.dump.sql' -delete`
# -mtime +5 will find those files last modified more than n*24h  
# https://wiki.ubuntuusers.de/find/

# find all databases except system db's
command= "docker exec -i postgresdb psql -U postgres -q -t -c \"SELECT datname from pg_database WHERE NOT datistemplate and datname != 'postgres'\" "

# NOTE 
# docker exec -i NOT docker exec -i because Error “The input device is not a TTY”
# https://stackoverflow.com/questions/43099116/error-the-input-device-is-not-a-tty

database_names = `#{command}`.split("\n").map {|name| name.gsub(" ","").strip}.reject(&:empty?).compact

database_names.each_with_index do |dbname, i|
  backup_file = "#{BACKUP_DIR}/#{dbname}_#{Time.now.strftime('%Y-%m-%d-%H:%M:%S')}.dump.sql"

  puts "BACKUP DB: #{dbname} to #{backup_file}"

  backup_command = "docker exec -i postgresdb  pg_dump -U postgres -Fc -b -c -C --if-exists  #{dbname} > #{backup_file}"

  `#{backup_command}`
  puts "DONE with #{i+1} from #{database_names.size}"
end

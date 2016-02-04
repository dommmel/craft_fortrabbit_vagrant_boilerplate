#!/bin/bash

app="my_fortrabbit_app"

# Working dir is one level above
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Start SSH Tunnel
ssh -M -S my-ctrl-socket -fnNT -L 13306:${app}.mysql.eu2.frbit.com:3306 tunnel@tunnel.eu2.frbit.com

#Get mysql password
export pass=$(ssh git@deploy.eu2.frbit.com secrets ${app} MYSQL.PASSWORD 2>&1)

# Export mysql dump from fortrabbit
/Applications/MAMP/Library/bin/mysqldump --opt -u${app} -h127.0.0.1 -P13306 -p"$pass" ${app} > ${DIR}/${app}.sql

# Import dump into vagrant
echo "mysql -uroot -proot -h localhost scotchbox < /var/www/${app}.sql" | vagrant ssh --

# Exit Tunnel
ssh -S my-ctrl-socket -O exit  tunnel@tunnel.eu2.frbit.com

#!/bin/bash

APP="app_name"
FORTRABBIT_REGION="eu2"
LOCAL_DATABASENAME="db_name"

EXCLUDED_TABLES=(
craft_entryversions
craft_searchindex
craft_templateelements
craft_templatecaches
craft_templatecacheelements
craft_templatecachecriteria
craft_retour_stats
)

# OSX: use MAMP binaries
PATH=/Applications/MAMP/Library/bin/:$PATH

# I keep this script in ./bin but the working dir should be one level up at ./
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )"

# Make sure to clean up after the script finishes or get's interrupted
function finish {
  echo "Closing ssh tunnel."
  ssh -q -S my-ctrl-socket -O exit  tunnel@tunnel.${FORTRABBIT_REGION}.frbit.com

  echo "Deleting dump file."
  rm ${DIR}/${APP}.sql
}
trap finish EXIT

# Start SSH Tunnel
echo "Opening ssh tunnel."
ssh -M -S my-ctrl-socket -fnNT -L 13306:${APP}.mysql.${FORTRABBIT_REGION}.frbit.com:3306 tunnel@tunnel.${FORTRABBIT_REGION}.frbit.com

# Get mysql password
MYSQL_PWD=$(eval ssh git@deploy.${FORTRABBIT_REGION}.frbit.com secrets ${APP} MYSQL.PASSWORD 2>&1)
# Remove carriage return from password
MYSQL_PWD=$(echo "$MYSQL_PWD" | tr -d '\r')

# Export mysql dump from fortrabbit
IGNORED_TABLES_STRING=''
for TABLE in "${EXCLUDED_TABLES[@]}"
do :
  IGNORED_TABLES_STRING+=" --ignore-table=${APP}.${TABLE}"
done
echo "Exporting fortrabbit sql data to dump file."
MYSQL_PWD=${MYSQL_PWD} mysqldump --opt -u${APP} -h127.0.0.1 -P13306 ${APP} ${IGNORED_TABLES_STRING} > ${DIR}/${APP}.sql

# Import dump
# Vagrant
echo "mysql -uroot -proot -h localhost ${LOCAL_DATABASENAME} < /var/www/${APP}.sql" | vagrant ssh --
## MAMP
# echo "Importing data... better not interrupt me now!"
# MYSQL_PWD="root" mysql -uroot -h localhost ${LOCAL_DATABASENAME} < ${DIR}/${APP}.sql

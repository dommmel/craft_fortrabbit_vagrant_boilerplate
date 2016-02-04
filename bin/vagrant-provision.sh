## Add a line with ENV Vars to already added (fortrabbit specific)
LINE='SetEnv APP_SECRETS /var/www/dev_secrets.json'
FILE=/etc/apache2/sites-enabled/000-default.conf
fgrep -xq "$LINE" "$FILE" || sed -i "/<VirtualHost \*:80>/ a\\$LINE" "$FILE"
service apache2 restart
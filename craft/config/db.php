<?php

/**
 * Database Configuration
 *
 * All of your system's database configuration settings go in here.
 * You can see a list of the default settings in craft/app/etc/config/defaults/db.php
 */

$creds = json_decode(file_get_contents($_SERVER['APP_SECRETS']), true);

return array(

	// The database server name or IP address. Usually this is 'localhost' or '127.0.0.1'.
	'server' => $creds['MYSQL']['HOST'],

	// The name of the database to select.
	'database' => $creds['MYSQL']['DATABASE'],

	// The database username to connect with.
	'user' => $creds['MYSQL']['USER'],

	// The database password to connect with.
	'password' => $creds['MYSQL']['PASSWORD'],

	// The prefix to use when naming tables. This can be no more than 5 characters.
	'tablePrefix' => 'craft',

);

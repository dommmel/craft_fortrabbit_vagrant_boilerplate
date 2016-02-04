## Setting things up

Set your development hostname (config.vm.hostname) in `Vagrantfile` 

run `vagrant up`

visit the hostname (e.g. http://mybox.dev) in your browser

## Asset compilation

run `grunt` to compile scripts and styles into `/assets/css/main.css` resp. `/assets/css/main.js`

## Import production database from fortrabbit

set the `app` variable in `bin/import_production_into_local_db.sh`to the name of your fortrabbit app

run `bin/import_production_into_local_db.sh`

## Update craft

run `bin/update_craft.sh`

this will download the newest version oft craft, unzip it and copy over the `app` folder and then all files in craft_customization (e.g. custom locales)

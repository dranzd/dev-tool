#!/bin/bash

rsync -pogtv --chown=www-data:adm -e "ssh -l USER -p XXXX" site1.com:/var/log/apache2/access.log* /dest/logs/site1.com/var/
rsync -pogtv --chown=www-data:adm -e "ssh -l USER -p XXXX" site1.com:/srv/www/site1.com/logs/access.log* /dest/logs/site1.com/www/

rsync -pogtv --chown=www-data:adm -e "ssh -l USER -p XXXX" site2.com:/var/log/apache2/access.log* /dest/logs/site2.com/var/
rsync -pogtv --chown=www-data:adm -e "ssh -l USER -p XXXX" site2.com:/srv/www/site1.com/logs/access.log* /dest/logs/site2.com/www/

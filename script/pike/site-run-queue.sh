#/bin/bash

sudo -H -u USER -g GROUP bash -c '/usr/bin/php /path/to/app/public/index.php queue doctrine default --start &'

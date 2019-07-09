#/bin/bash

sudo -H -u www-data -g www-data bash -c '/usr/bin/php /path/to/git/app/public/index.php queue doctrine default --start &'
echo $!

# ps -eo pid,user,args --sort user | grep queue

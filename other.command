[NGROK]
$> /path/to/ngrok -authtoken="AUTH-TOKEN" -httpauth="USER:PASS" -subdomain=[DOMAIN.NAME] [IP:PORT]

[PHPBREW]
$> alias phpbrew-switch-7='phpbrew switch-off && sudo a2dismod php5 && sudo a2enmod php7.0 && sudo service apache2 restart'
$> alias phpbrew-switch-5='phpbrew switch php-5.5.22 && sudo a2dismod php7.0 && sudo a2enmod php5 && sudo service apache2 restart'

[HTACCESS]
$> ssh -p PORT USER@REMOTE-SERVER -t "sudo /PATH/TO/htpasswd /PATH/TO/HTPASSWD-FILE USERNAME"

[FAIL2BAN]
$> fail2ban-client status
$> fail2ban-client set [JAILNAME, e.g. sshd] unbanip [IPADDRESS]

[BASH]
$> wget -qO - HTTP://DOMAIN/PATH/TO/SCRIPT | bash

[FIND & EXECUTE COMMAND]
$> find [DIR_PATH_HERE] -type [d=DIR,f=FILE] -exec [COMMAND HERE; e.g. chmod 0755] {} \;

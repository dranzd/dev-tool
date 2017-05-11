$> /usr/share/awstats/tools/logresolvemerge.pl /PATH/TO/SRC/1/access.log* /PATH/TO/SRC/2/access.log* > /PATH/TO/DST/access.log

$> sudo nice /usr/lib/cgi-bin/awstats.pl -update -config="SITE.COM" -LogFile="/usr/share/awstats/tools/logresolvemerge.pl /PATH/TO/SRC/1/access.log* /PATH/TO/SRC/2/access.log* |"

$> rsync -n -pogtv -e "ssh -l USER -p PORT" REMOTE-SERVER:/PATH/TO/SRC/access.log* /PATH/TO/DST/

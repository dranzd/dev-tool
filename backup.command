[WWW]
$> rsync -n --delete --copy-links -rtgoDCzvK --exclude-from=www_backup_exclude -e "ssh -l UNAME -p XX" yoursite.com:/path/to/doc/root/ /path/to/backup/ > /path/to/result.log

[IMAGES]
$> rsync -n --copy-links -rtgoDCzvK --exclude-from=image_backup_exclude -e "ssh -l UNAME -p XX" yoursite.com:/path/to/doc/root/images/ /path/to/backup/ > /path/to/result.log

[DATABASE]
$> mysqldump -u UNAME -p --add-drop-table --extended-insert DBASE-NAME | gzip -9 > /path/to/backup-with-drop-2016XXXX-XXXX.sql.gz

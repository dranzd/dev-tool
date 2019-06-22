[DATABASE]
$> gunzip -c /path/to/backup-with-drop-2016XXXX-XXXX.sql.gz | mysql -u UNAME -p DBASE-NAME
$> gunzip -c /path/to/backup-with-drop-2016XXXX-XXXX.sql.gz | \
    docker-compose exec DOCKER_SERVICE_NAME /usr/bin/mysql -u DB_USER --password=DB_PASS DB_NAME

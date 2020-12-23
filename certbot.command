# Register new certificate
$> certbot --apache certonly -d domain.name[,other-domain.name]

# Renew certificate of specific domain
$> certbot --apache renew -d domain.name

# Renew certificate
$> certbot certonly --webroot -w /path/to/domain.name/public -d domain.name

# Renew all expired certificate
$> certbot -q renew

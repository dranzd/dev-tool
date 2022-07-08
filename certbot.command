# Register new certificate
# To support www and non-www, need to provide both like so "-d domain.com -d www.domain.com"
$> certbot --apache certonly -d domain.name[,other-domain.name]

# Renew certificate of specific domain
$> certbot --apache renew -d domain.name

# Renew certificate
$> certbot certonly -q --keep-until-expiring --webroot -w /path/to/domain.name/public -d domain.name

# Renew all expired certificate
$> certbot -q renew

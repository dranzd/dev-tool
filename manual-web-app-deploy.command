$> rsync -n -rtoDCzvK --exclude-from=exclude.file -e "ssh -l uname -p XX" /path/to/source/ yoursite.com:/path/to/destination/ > /path/to/result.log

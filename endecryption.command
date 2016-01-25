Encrypt:
$ openssl aes-256-cbc -a -in file.raw -out file.encrypted

Decrypt
$ openssl aes-256-cbc -d -a -in file.encrypted -a -out file.decrypted

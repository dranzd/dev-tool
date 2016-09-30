#!/bin/bash

CFLAGS="-I/home/user/.phpbrew/build/php-5.5.22" phpbrew install 5.5.22 +default +mysql +pdo +gd +openssl=/usr +apxs2=/usr/bin/apxs2 -- \
--with-libdir=lib/x86_64-linux-gnu \
--with-gd=shared \
--with-jpeg-dir=/usr/lib \
--with-png-dir=/usr/lib \
--with-freetype-dir=/usr

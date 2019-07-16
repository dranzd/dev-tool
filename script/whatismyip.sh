#!/bin/bash

dig +short myip.opendns.com @resolver1.opendns.com | tr -d "\n" | xclip -selection clipboard

xclip -o -selection clipboard

echo -e

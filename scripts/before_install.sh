#!/bin/bash

c=$(ls -l /var/www/demo/ | wc -l)

if [ $c -gt 0 ]
then
  cd /var/www/demo
  pm2 delete all
  rm -fr *
  rm -fr .git*
else
  echo "Empty"
fi

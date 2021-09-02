#!/bin/bash

c=$(ls -l /var/www/demo/ | wc -l)

if [ $c -gt 0 ]
then
  cd /var/www/demo

  rm -fr .git*
else
  echo "Empty"
fi

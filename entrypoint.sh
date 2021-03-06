#!/bin/bash

cp /aria2/aria2.conf.bak /aria2/aria2.conf
if [[ -f "/config/cert" ]]; then
  echo "rpc-secure=true" >> /aria2/aria2.conf
  echo "rpc-certificate=/config/cert" >> /aria2/aria2.conf
  echo "rpc-private-key=/config/key" >> /aria2/aria2.conf
fi

touch /aria2/aria2.session
/usr/bin/aria2c --conf-path=/aria2/aria2.conf --input-file=/aria2/aria2.session --save-session=/aria2/aria2.session --daemon
nginx -g "daemon off;"

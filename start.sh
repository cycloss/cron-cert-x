#!/bin/sh

# run first time cert in standalone mode
# MUST have injected EMAIL and HOST into the environment
certfile = '/etc/letsencrypt/live/mobile-proxy.wessexinternet.net/cert.pem'

# if file doesn't exist, will also go to the else condition
if openssl x509 -checkend 86400 -noout -in $certfile ; do
          echo "Certificate is good for another day!"
else
        echo "Certificate has expired, or will do so within 24 hours!"
        echo "Renewing certificate"
        certbot certonly --standalone --email $EMAIL --agree-tos --preferred-challenges http -d $HOST 
fi

# start cron running
cron

# run nginx in daemon off mode to keep it in the foreground
# this prevents the container from shutting down as soon as the nginx worker processes have spawned and the start process has quit
nginx -g 'daemon off;'
#!/bin/sh

# run first time cert in standalone mode
# MUST have injected EMAIL and HOST into the environment
certbot certonly --standalone --email $EMAIL --agree-tos --preferred-challenges http -d $HOST

# start cron running
cron

# run nginx in daemon off mode to keep it in the foreground
# this prevents the container from shutting down as soon as the nginx worker processes have spawned and the start process has quit
nginx -g 'daemon off;'
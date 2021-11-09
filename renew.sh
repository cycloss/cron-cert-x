#!/bin/sh

/usr/bin/certbot renew

# the same as systemctl reload nginx 
# (systemctl will not be available in container)
kill -HUP `cat /var/run/nginx.pid`
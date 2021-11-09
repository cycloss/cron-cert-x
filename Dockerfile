FROM nginx:stable


# execute as one command to reduce container size
# install the required commands
# remove default configs
RUN apt update \
    && apt install -y cron certbot \
    && rm -f /etc/nginx/conf.d/default.conf \
    && mkdir /opt/certbot \
    && mkdir /opt/start \
    && rm -f /etc/cron.d/certbot

# copy the script into the dir created above
COPY renew.sh /opt/certbot
COPY start.sh /opt/start

# run every 3rd day at 3am
RUN echo "* 3 */3 * * root /opt/certbot/renew.sh" > /etc/cron.d/certbotRenew

# see `start.sh` for commented start up script
CMD /opt/start/start.sh
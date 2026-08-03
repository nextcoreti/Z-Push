#!/bin/sh
set -e

if [ -n "$ZIMBRA_URL" ]; then
    rpl master.kyahosting.com "$ZIMBRA_URL" /usr/share/z-push/backend/zimbra/config.php
fi

if [ -n "$TIMEZONE" ] && [ -f /usr/share/zoneinfo/"$TIMEZONE" ]; then
    rm -f /etc/localtime
    ln -fs /usr/share/zoneinfo/"$TIMEZONE" /etc/localtime
    echo "$TIMEZONE" > /etc/timezone
fi

mkdir -p /run/php
php-fpm8.2 -D
exec nginx -g "daemon off;"

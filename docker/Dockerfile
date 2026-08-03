FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        nginx \
        php8.2-fpm \
        php8.2-curl \
        php8.2-mbstring \
        php8.2-xml \
        rpl \
        tzdata \
        ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

COPY src/ /usr/share/z-push/
COPY docker/nginx-zpush.conf /etc/nginx/sites-enabled/default
COPY docker/php-fpm-zpush.conf /etc/php/8.2/fpm/pool.d/zpush.conf
COPY docker/start.sh /start.sh

RUN chmod +x /start.sh \
    && mkdir -p /var/lib/z-push /var/log/z-push \
    && chown -R www-data:www-data /var/lib/z-push /var/log/z-push /usr/share/z-push \
    && sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/8.2/fpm/php.ini \
    && rm -f /etc/php/8.2/fpm/pool.d/www.conf

ENV ZIMBRA_URL=127.0.0.1
ENV TIMEZONE=UTC

EXPOSE 80

CMD ["/start.sh"]

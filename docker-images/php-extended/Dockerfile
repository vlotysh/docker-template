# syntax=docker/dockerfile:experimental
FROM php:8.0-fpm as runtime

MAINTAINER Vladislav Lotysh <lotysh.vm@gmail.com>

USER root
RUN apt-get update && apt-get install -y \
    ssh \
    curl \
    wget \
    git \
    zip \
    unzip \
    libxml2-dev \
    procps\
    cron\
    libpq-dev \
    libmcrypt-dev \
    postgresql-client \
    && apt-get autoremove -y -f \
    && apt-get clean -y

# memcached
RUN apt-get update && apt-get install -y libmemcached-dev zlib1g-dev
RUN pecl install memcached
RUN docker-php-ext-enable memcached
#RUN docker-php-ext-install -j$(nproc) memcached

# Install php extensions
RUN docker-php-ext-install -j$(nproc) \
    pdo \
    pdo_mysql \
    intl \
    soap \
    bcmath \
    pcntl

#Since xdebug 3.x has mode=off.
RUN pecl install xdebug && docker-php-ext-enable xdebug
ENV XDEBUG_MODE=off

ADD docker-images/php-extended/conf/php.ini /usr/local/etc/php/conf.d/90-custom.ini

WORKDIR /var/www

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install nodejs -y

RUN npm install uglify-js webpack webpack-cli -g | npm install
RUN npm add @babel/runtime

CMD ["php-fpm"]

EXPOSE 9000

FROM runtime AS tools
USER root
# Install composer
ENV COMPOSER_ALLOW_SUPERUSER 1 \
    COMPOSER_HOME /composer \
    PATH=$COMPOSER_HOME/vendor/bin:$PATH

RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/local/bin \
  --filename=composer

RUN groupadd -r docker-user && useradd --home /home/docker-user -m -N docker-user
RUN apt install -y gosu
COPY docker-images/php-extended/gosu_entrypoint.sh /usr/local/bin/gosu_entrypoint.sh
RUN chmod +x /usr/local/bin/gosu_entrypoint.sh
ENTRYPOINT ["/usr/local/bin/gosu_entrypoint.sh"]

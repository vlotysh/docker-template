FROM php:7.4-fpm
MAINTAINER Vladislav Lotysh <lotysh.vm@gmail.com>

RUN apt-get update
# update the repository sources list
# and install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    nano \
    git \
    zlib1g-dev \
    libzip-dev \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.4

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash \
    && . ${NVM_DIR}/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH ${NVM_DIR}/v${NODE_VERSION}/lib/node_modules
ENV PATH ${NVM_DIR}/versions/node/v${NODE_VERSION}/bin:$PATH

# Libs
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
        libmcrypt-dev \
        libpng-dev \
        libjpeg-dev \
        libpng-dev \
        libonig-dev \
        libicu-dev \
        libmagickwand-dev --no-install-recommends \
        libcurl4-openssl-dev \
        libxslt1-dev \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxpm-dev \
        libfreetype6-dev

# Pecl packages
RUN pecl install \
    imagick \
    xdebug \
    zip \
    mcrypt-1.0.3

# Php modules
RUN docker-php-ext-install \
    json \
    opcache \
    pdo \
    pdo_mysql \
    mysqli \
    iconv \
    gd \
    intl \
    curl \
    exif \
    xsl \
    zip \
    bz2

# gd modules config
RUN docker-php-ext-configure gd

# php modules enable
RUN docker-php-ext-enable \
    imagick \
    xdebug \
    mcrypt

WORKDIR /code

COPY zz-docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf

EXPOSE 9000
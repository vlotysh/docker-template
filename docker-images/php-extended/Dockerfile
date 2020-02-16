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
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.4

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Libs
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
        libmcrypt-dev \
        libpng-dev \
        libjpeg-dev \
        libpng-dev \
        libicu-dev \
        libmagickwand-dev --no-install-recommends \
        libcurl4-openssl-dev \
        libxslt1-dev

# Pecl packages
RUN pecl install \
    imagick \
    xdebug \
    zip

# Php modules
RUN docker-php-ext-install -j$(nproc) \
    json \
    mbstring \
    opcache \
    pdo \
    pdo_mysql \
    mysqli \
    iconv \
    mcrypt \
    gd \
    mbstring \
    intl \
    curl \
    exif \
    xsl \
    zip

# gd modules config
RUN docker-php-ext-configure gd \
    --enable-gd-native-ttf \
    --with-freetype-dir=/usr/include/freetype2 \
    --with-png-dir=/usr/include \
    --with-jpeg-dir=/usr/include

# php modules enable
RUN docker-php-ext-enable \
    imagick \
    xdebug \
    xsl \
    zip \
    gd
FROM php:7.1-fpm
MAINTAINER Vladislav Lotysh <lotysh.vm@gmail.com>

RUN apt-get update
# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

RUN apt-get update && \
     apt-get install -y \
         zlib1g-dev \
         && docker-php-ext-install zip

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

# Some basic extensions
RUN docker-php-ext-install -j$(nproc) json mbstring opcache pdo pdo_mysql mysqli

# Curl
RUN apt-get install -y libcurl4-openssl-dev \
    && docker-php-ext-install -j$(nproc) curl

# GD
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
        libmcrypt-dev \
        libpng-dev \
        libjpeg-dev \
        libpng-dev \
    && docker-php-ext-install iconv mcrypt \
    && docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-freetype-dir=/usr/include/freetype2 \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-enable gd

# Intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install -j$(nproc) intl

#install Imagemagick & PHP Imagick ext
RUN apt-get update && apt-get install -y \
  libmagickwand-dev --no-install-recommends
RUN pecl install imagick && docker-php-ext-enable imagick

# Intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install -j$(nproc) intl

# Compile and install xDebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

#install exif
RUN docker-php-ext-install exif

RUN apt-get install -y libxslt1-dev

#install xsl
RUN docker-php-ext-install xsl \
    && docker-php-ext-enable xsl

RUN apt-get install -y libgearman-dev
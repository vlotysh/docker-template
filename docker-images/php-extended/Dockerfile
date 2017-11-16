FROM php:7.1-fpm
MAINTAINER Vladislav Lotysh <lotysh.vm@gmail.com>

RUN apt-get update
# update the repository sources list
# and install dependencies
RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

# nvm environment variables
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.4

# install nvm
# https://github.com/creationix/nvm#install-script
#RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash

# install node and npm
#RUN chmod u+x $NVM_DIR/nvm.sh
#RUN ls -la $NVM_DIR
#RUN $NVM_DIR/nvm.sh
#   RUN nvm install $NODE_VERSION
#   RUN nvm alias default $NODE_VERSION
#   RUN nvm use default

# Install nvm with node and npm
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.31.2/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# confirm installation
#RUN node -v
#RUN npm -v

# Some basic extensions
RUN docker-php-ext-install -j$(nproc) json mbstring opcache pdo pdo_mysql mysqli

# Curl
RUN apt-get install -y libcurl4-openssl-dev
RUN docker-php-ext-install -j$(nproc) curl

# GD
RUN apt-get install -y libpng-dev libjpeg-dev
RUN docker-php-ext-install -j$(nproc) gd

# Intl
RUN apt-get install -y libicu-dev
RUN docker-php-ext-install -j$(nproc) intl

#install Imagemagick & PHP Imagick ext
RUN apt-get update && apt-get install -y \
  libmagickwand-dev --no-install-recommends
RUN pecl install imagick && docker-php-ext-enable imagick

# Compile and install xDebug
RUN pecl install xdebug \
    && docker-php-ext-enable xdebug

#install exif
RUN docker-php-ext-install exif

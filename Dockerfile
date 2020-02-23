FROM php:7.2-fpm

RUN apt-get update && apt-get -y install iputils-ping \
    vim \
    git \
    zip \
    unzip \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    wget \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    supervisor
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    zip \
    pdo_mysql \
    bcmath \
    calendar \
    exif \
    gettext \
    sockets \
    dba \
    mysqli \
    pcntl \
    shmop \
    sysvmsg \
    sysvsem \
    sysvshm \
    iconv
RUN pecl install mongodb && docker-php-ext-enable mongodb \
    && pecl install redis-5.0.2 && docker-php-ext-enable redis \
    && wget https://mirrors.aliyun.com/composer/composer.phar \
    && chmod 755 composer.phar \
    && mv composer.phar /usr/local/bin/composer \
    && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/ \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install opcache
CMD ["service","supervisor","start","&","php-fpm"]

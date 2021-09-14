FROM centos:7
# Centos 7
# PHP-FPM 8.0.3
# Pytone 3.6
# NodeJs v14.16.1
# NPM 6.14.12
ARG user 
ARG uid

RUN  yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
     https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN  yum update -y

 RUN yum install -y vim \
     wget \
     gcc \
     gcc-c++ make \
     pcre-devel \
     zlib-devel make \
     zip \
     unzip \
     sed \
     gd \
     gd-devel \
     gmp-devel \
     net-tools \
     ntpdate \
     ntp \
     openssh-clients \
     httpd \
     openssl-devel \
     yum-utils \
     perl \
     curl \
     squid \
     git \
     crontabs
# Payton
RUN yum install -y python36 \
     python36-devel \ 
     python36-setuptools 
RUN yum-config-manager --disable 'remi-php*'
RUN yum-config-manager --enable remi-php8*
# RUN yum -y install php php-{cli,fpm,mysqlnd,pdo_mysql,unzip,devel,pdo,gd,intl,mbstring,curl,xml,pear,bcmath,json,soap}
RUN yum install -y php \
                   php-fpm \
                   php-gd \
                   php-redis \
                   php-soap \
                   php-intl \
                   php-pdo \
                   php-pdo_mysql \
                   php-pdo_pgsql \
                   php-pear \
                   php-devel \
                   php-mysql.x86_64  --skip-broken \
                   php-mbstring \
                   php-zip \
                   php-unzip

RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash - 
RUN yum install nodejs -y

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN easy_install-3.6 pip
RUN pip install supervisor

RUN useradd -G root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
     chown -R $user:$user /home/$user

RUN mkdir -p /var/log/php-fpm
RUN mkdir -p /var/log/nginx
RUN mkdir -p /var/run/php-fpm
RUN chown -R $user:$user /var/log/php-fpm
RUN chown -R $user:$user /var/log/nginx
RUN chown -R $user:$user /var/run/php-fpm

COPY ./etc/nginx/build_pgSpeedNginx/customNginx.sh /
RUN chmod +x ./customNginx.sh
RUN ./customNginx.sh

RUN pip install s3cmd
RUN yum install lsof -y

RUN yum install htop -y
CMD ["supervisord", "-c" ,"/etc/supervisord.conf"]
NPS_VERSION=1.13.35.2-stable
NGINX_VERSION=1.18.0
PSOL_FILENAME=https://dl.google.com/dl/page-speed/psol/$PSOL_FILENAME

NPS_FILENAME=v${NPS_VERSION}.zip
NGINX_FILENAME=nginx-${NGINX_VERSION}.tar.gz

wget https://github.com/pagespeed/ngx_pagespeed/archive/$NPS_FILENAME
unzip $NPS_FILENAME
mv incubator-pagespeed-ngx-1.13.35.2-stable NPS

cd ./NPS
[ -e scripts/format_binary_url.sh ] && PSOL_FILENAME=$(scripts/format_binary_url.sh PSOL_BINARY_URL)
wget -O- ${PSOL_FILENAME} | tar -xz  # extracts to psol/
DIR_NPS=$PWD

cd
wget http://nginx.org/download/$NGINX_FILENAME
tar -xvzf  $NGINX_FILENAME
mv nginx-1.18.0 NX
cd NX

mkdir -p /var/cache/nginx/client_temp
mkdir -p /var/cache/nginx/proxy_temp
mkdir -p /var/cache/nginx/fastcgi_temp
mkdir -p /var/cache/nginx/uwsgi_temp
mkdir -p /var/cache/nginx/scgi_temp

chown -R app:app /var/cache/nginx

./configure \
--add-module=$DIR_NPS \
--user=nobody \
--group=nobody \
--pid-path=/var/run/nginx.pid ${PS_NGX_EXTRA_FLAGS} \
--with-http_ssl_module \
--with-http_realip_module \
--with-http_stub_status_module \
--http-client-body-temp-path=/var/cache/nginx/client_temp \
--http-proxy-temp-path=/var/cache/nginx/proxy_temp \
--http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
--http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
--http-scgi-temp-path=/var/cache/nginx/scgi_temp
--with-compat \
--with-file-aio \
--with-threads \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_random_index_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_v2_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_realip_module \
--with-stream_ssl_module \
--with-stream_ssl_preread_module

make

make install

ln -s /usr/local/nginx/conf/ /etc/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/sbin/nginx
mkdir -p /var/ngx_pagespeed_cache
chown -R app:app /var/ngx_pagespeed_cache
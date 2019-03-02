ARG ARCH=docker.io
FROM ${ARCH}/nginx:alpine

LABEL maintainer="paulhybryant@gmail.com"

ENV TZ 'Asia/Chongqing'

COPY qemu-aarch64-static /usr/bin/

RUN \
    apk -U upgrade \
    && apk add --no-cache bash aria2 unzip curl

RUN mkdir /aria2 \
  && curl -L https://github.com/paulhybryant/aria2-daemon/archive/v1.0.tar.gz | tar --strip-components=1 -C /aria2/ -xzv \
  && sed -i -e "s@\$dir@/downloads@" /aria2/aria2.conf \
  && cp /aria2/aria2.conf /aria2/aria2.conf.bak \
  && curl -L https://github.com/mayswind/AriaNg/releases/download/1.0.1/AriaNg-1.0.1.zip -o /tmp/ariang.zip \
  && unzip -o /tmp/ariang.zip -d /usr/share/nginx/html

VOLUME ["/config"]
VOLUME ["/downloads"]

EXPOSE 6800

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

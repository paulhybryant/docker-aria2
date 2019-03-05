ARG ARCH=docker.io
FROM ${ARCH}/nginx:alpine

LABEL maintainer="paulhybryant@gmail.com"

ENV TZ 'Asia/Chongqing'

COPY qemu-aarch64-static /usr/bin/

RUN \
    apk -U upgrade \
    && apk add --no-cache bash aria2 unzip curl

COPY conf/aria2.conf /aria2/
ADD ariang-1.0.1.tar.gz /usr/share/nginx/html/

RUN sed -i -e "s@\$dir@/downloads@" /aria2/aria2.conf \
  && cp /aria2/aria2.conf /aria2/aria2.conf.bak

VOLUME ["/config"]
VOLUME ["/downloads"]

EXPOSE 6800

COPY entrypoint.sh /usr/bin/
ENTRYPOINT ["/usr/bin/entrypoint.sh"]

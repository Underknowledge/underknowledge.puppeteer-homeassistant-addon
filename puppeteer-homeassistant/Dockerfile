# https://developers.home-assistant.io/docs/add-ons/configuration#add-on-dockerfile
ARG BUILD_FROM
FROM $BUILD_FROM

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

# Copy root filesystem
COPY rootfs /



RUN cat /etc/passwd

RUN adduser user -u 1000 -s /bin/bash && mkdir -p /opt/puppeteer/ && chown 1000:1000 /opt/puppeteer/

WORKDIR /opt/puppeteer/
# 2018.. what should go wrong https://github.com/puppeteer/puppeteer/issues/1793#issuecomment-437688599
RUN set -x \
      && apk update \
      && apk upgrade \
      # replacing default repositories with edge ones
      && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
      && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
      && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
      \
      # Add the packages
      && apk add --no-cache imagemagick openssh-client sshpass netcat nano curl make gcc g++ python linux-headers binutils-gold gnupg libstdc++ nss chromium \
      \
      && npm install puppeteer@14.1.1 \
      \
      # Do some cleanup
      && apk del --no-cache make gcc g++ python binutils-gold gnupg libstdc++ \
      && rm -rf /usr/include \
      && rm -rf /var/cache/apk/* /root/.node-gyp /usr/share/man /tmp/* \
      && echo
    


USER user

ENTRYPOINT ["/etc/services.d/puppeteer/run"]
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



ENV USER=user
ENV UID=1000

WORKDIR /opt/puppeteer/



RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "$(pwd)" \
    --no-create-home \
    --uid "$UID" \
    "$USER" \
    && chown 1000:1000 /opt/puppeteer/


# Failed before with 
# apk add libstdc++ chromium harfbuzz nss freetype ttf-freefont font-noto-emoji wqy-zenhei
# ERROR: unable to select packages:
#   so:libcjson.so.1 (no such package):
#     required by: librist-0.2.6-r1[so:libcjson.so.1]
#   so:libmbedcrypto.so.7 (no such package):
#     required by: librist-0.2.6-r1[so:libmbedcrypto.so.7]
    #   libstdc++ \
    #   chromium \
    #   harfbuzz \
    #   nss \
    #   freetype \
    #   ttf-freefont \
    #   font-noto-emoji \
    #   wqy-zenhei \

#      chromium \

# 2018.. what should go wrong https://github.com/puppeteer/puppeteer/issues/1793#issuecomment-437688599
# 2020.. were getting warmer https://blog.logrocket.com/how-to-set-up-a-headless-chrome-node-js-server-in-docker/
RUN set -x \
      && apk update \
      && apk upgrade \
      # replacing default repositories with edge ones
      && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
      && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories \
      && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
      && echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories \    
      && apk upgrade -U -a \
      && apk add --no-cache \
      harfbuzz \
      nss \
      "freetype>2.8" \
      ttf-freefont \
      \
      # Add the packages
      && apk add --no-cache \
      imagemagick openssh-client sshpass netcat-openbsd \
      && apk add --no-cache \
      nano curl tini make gcc g++ python3 git nodejs nodejs-npm yarn \
      \
      && npm install puppeteer@12.0.1 \
      \
      # Do some cleanup
      && apk del --no-cache make gcc g++ python3  \
      && rm -rf /usr/include \
      && rm -rf /var/cache/* /root/.node-gyp /usr/share/man /tmp/* \
      && mkdir /var/cache/apk \
      && echo
    # libstdc++  binutils-gold
# puppeteer 14 is to new for alpines (current: {"node":"12.22.12","npm":"6.14.16"})

# ERROR: unable to select packages:
#   so:libcjson.so.1 (no such package):
#     required by: librist-0.2.6-r1[so:libcjson.so.1]
#   so:libmbedcrypto.so.7 (no such package):
#     required by: librist-0.2.6-r1[so:libmbedcrypto.so.7]


USER user


ENTRYPOINT ["/etc/services.d/puppeteer/run"]
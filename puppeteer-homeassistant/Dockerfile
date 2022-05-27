FROM zenika/alpine-chrome:with-node


user root
# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    whoami && \
    apk add --no-cache \
      curl imagemagick openssh-client sshpass netcat-openbsd \
    && curl -sSLf -o /usr/bin/tempio \
      "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"\
    && rm -rf /usr/include \
    && rm -rf /var/cache/* /root/.node-gyp /usr/share/man /tmp/* \
    && mkdir /var/cache/apk \
    && echo

# Copy root filesystem
COPY rootfs /


ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD 1
ENV PUPPETEER_EXECUTABLE_PATH /usr/bin/chromium-browser
WORKDIR /usr/src/app
COPY --chown=chrome rootfs/usr/src/app/package.jsonpackage.json package-lock.json ./
RUN npm install
COPY --chown=chrome . ./
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
# CMD ["node", "src/pdf"]


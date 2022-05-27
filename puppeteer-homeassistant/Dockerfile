FROM zenika/alpine-chrome:with-node


# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

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


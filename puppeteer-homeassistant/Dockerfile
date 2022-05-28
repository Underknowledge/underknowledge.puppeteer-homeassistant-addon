ARG BUILD_FROM
FROM $BUILD_FROM
# build_from:
#   amd64: "ghcr.io/home-assistant/amd64-base-ubuntu:20.04"
#   aarch64: "ghcr.io/home-assistant/aarch64-base-ubuntu:20.04"

# Execute during the build of the image
ARG TEMPIO_VERSION BUILD_ARCH
RUN \
    curl -sSLf -o /usr/bin/tempio \
    "https://github.com/home-assistant/tempio/releases/download/${TEMPIO_VERSION}/tempio_${BUILD_ARCH}"

# Copy root filesystem
COPY rootfs /

ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

RUN apt-get update && apt-get install -y curl gnupg \
    && apt-get install -y nodejs npm nano imagemagick openssh-client sshpass netcat-openbsd \
    \
    && ARCH="$(echo $BUILD_FROM | grep -o 'amd64\|aarch64')" \
    && if [ "${BUILD_ARCH}" = "aarch64" ]; then export ARCH="aarch64"; fi \
    && if [ "${BUILD_ARCH}" = "amd64" ]; then export ARCH="amd64"; fi \
    && echo "Running $ARCH build" \
    \
  && curl --location --silent https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && sh -c 'echo "deb [arch=$ARCH] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list' \
  && apt-get update \
  && apt-get install google-chrome-stable -y --no-install-recommends \
  && rm -rf /var/lib/apt/lists/*


WORKDIR /usr/src/app
RUN npm install

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]


# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: nodejs (glibc support)
# Minimum Panel Version: 1.3.1
# ----------------------------------

FROM    node:current-alpine3.13

LABEL   author="sub1to software" maintainer="sub1to"

        # A minimal Docker image with Node and Puppeteer
        #
        # Initially based upon:
        # https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker

        # Pterodactyl dependencies
RUN     apk add --no-cache --update libc6-compat ffmpeg git \

         # Installs latest Chromium (89) package.
         && chromium \
         && nss \
         && freetype \
         && freetype-dev \
         && harfbuzz \
         && ca-certificates \
         && ttf-freefont \
         && nodejs \
         && yarn \
         # Add pterodactyl user 'container'
         && adduser -D -h /home/container container

        # Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV     PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
        PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

        # Install Puppeteer under /node_modules so it's available system-wide
ADD     package.json package-lock.json /
RUN     npm install

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY ./entrypoint.sh /entrypoint.sh
CMD ["/bin/bash", "/entrypoint.sh"]
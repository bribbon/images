# ----------------------------------
# Pterodactyl Core Dockerfile
# Environment: nodejs (glibc support)
# Minimum Panel Version: 1.3.1
# ----------------------------------

FROM    alpine:latest

ARG     BUILD_DATE

LABEL   author="sub1to software" maintainer="sub1to"

        # A minimal Docker image with Node and Puppeteer
        #
        # Initially based upon:
        # https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#running-puppeteer-in-docker

        # Pterodactyl dependencies
RUN     apk add --no-cache --update libc6-compat ffmpeg git \

         # Installs latest Chromium package.
         && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories \
         && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
         && echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
         && echo "http://dl-cdn.alpinelinux.org/alpine/v3.12/main" >> /etc/apk/repositories \
         && apk upgrade -U -a \
         && apk add \
         libstdc++ \
         chromium \
         harfbuzz \
         nss \
         freetype \
         ttf-freefont \
         font-noto-emoji \
         wqy-zenhei \
         && rm -rf /var/cache/* \
         && mkdir /var/cache/apk

COPY    local.conf /etc/fonts/local.conf

        # Add Chrome as a user
RUN     mkdir -p /home/container \
         && adduser -D container \
         && chown -R container:container /home/container

ENV     CHROME_BIN=/usr/bin/chromium-browser \
        CHROME_PATH=/usr/lib/chromium/

        # Tell Puppeteer to skip installing Chrome. We'll be using the installed package.
ENV     PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
        PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

        # Install Puppeteer under /node_modules so it's available system-wide
ADD     package.json package-lock.json /
RUN     npm install

        # Run Chrome as non-privileged
USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
ENTRYPOINT ["chromium-browser", "--headless", "--use-gl=swiftshader", "--disable-software-rasterizer", "--disable-dev-shm-usage"]
CMD     ["/bin/bash", "/entrypoint.sh"]
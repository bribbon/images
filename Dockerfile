# ------------------------------------
# Pterodactyl Panel Docker Container
# Environment: ubuntu
# Minimum Panel Version: 1.3.X
# ------------------------------------

FROM    ubuntu:18.04

LABEL   author="sub1to software" maintainer="sub1to"

ENV     DEBIAN_FRONTEND=noninteractive

RUN     apt-get update \
         && apt-get dist-upgrade -y \
         && apt-get autoremove -y \
         && apt-get autoclean \
         && apt-get -y install dirmngr curl software-properties-common locales git cmake \
         && apt-get -y install autoconf automake g++ libtool \
         && apt-get -y install ffmpeg libmp3lame-dev x264 \
         && apt-get -y install sqlite3 libsqlite3-dev \
         && adduser -D -h /home/container container

        # Ensure UTF-8
RUN     locale-gen en_US.UTF-8
ENV     LANG en_US.UTF-8
ENV     LC_ALL en_US.UTF-8
ENV     TZ=UTC
RUN     ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

        # Nodejs & discord.js
RUN     curl -sL https://deb.nodesource.com/setup_10.x | bash - \
         && apt update \
         && apt -y upgrade \
         && apt -y install nodejs node-gyp \
         && npm install discord.js \
         && npm install @discordjs/opus \
         && npm install node-opus \
         && npm install opusscript \
         && npm install bufferutil \
         && npm install libsodium-wrappers \
         && npm install sqlite3 \
         && npm install better-sqlite3 \
         && npm install utf-8-validate \
         && npm install ffmpeg \
         && npm install sodium

USER    container
ENV     USER container
ENV     HOME /home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]

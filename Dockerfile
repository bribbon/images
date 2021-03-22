# ------------------------------------
# Pterodactyl Panel Docker Container
# Environment: glibc
# Minimum Panel Version: 1.3.X
# ------------------------------------

FROM    alpine:latest

LABEL   author="sub1to software" maintainer="sub1to"

RUN     apk add --no-cache --update ca-certificates \
         && adduser -D -h /home/container container

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/ash", "/entrypoint.sh"]
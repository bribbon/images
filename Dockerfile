# ------------------------------------
# Pterodactyl Panel Docker Container
# Environment: glibc
# Minimum Panel Version: 1.3.X
# ------------------------------------

FROM        node:14-buster-slim

LABEL       author="sub1to software" maintainer="sub1to"

RUN         apt update \
            && apt -y install ffmpeg iproute2 git sqlite3 python3 ca-certificates dnsutils build-essential \
            && useradd -m -d /home/container container

USER        container
ENV         USER=container HOME=/home/container
WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
CMD         ["/bin/bash", "/entrypoint.sh"]
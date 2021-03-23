# ------------------------------------
# Pterodactyl Panel Docker Container
# Environment: glibc
# Minimum Panel Version: 1.3.X
# ------------------------------------

FROM    node:14.16.0-buster-slim@sha256:ffc15488e56d99dbc9b90d496aaf47901c6a940c077bc542f675ae351e769a12

LABEL   author="sub1to software" maintainer="sub1to"

RUN     apt update \
        && apt -y install ffmpeg iproute2 git sqlite3 python3 ca-certificates dnsutils build-essential \
        && useradd -m -d /home/container container

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./entrypoint.sh /entrypoint.sh
CMD     ["/bin/bash", "/entrypoint.sh"]

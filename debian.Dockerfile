FROM python:3.11.0-slim-bullseye

ARG BUILD_DATE
ARG VCS_REF
ARG CHERRYMUSIC_VERSION

LABEL org.opencontainers.image.authors="Tobias Hargesheimer <docker@ison.ws>" \
    org.opencontainers.image.title="CherryMusic" \
    org.opencontainers.image.description="CherryMusic: Stream your own music collection to all your devices!" \
    org.opencontainers.image.licenses="GPL-3.0" \
    org.opencontainers.image.version="${CHERRYMUSIC_VERSION}" \
    org.opencontainers.image.created="${BUILD_DATE}" \
    org.opencontainers.image.revision="${VCS_REF}" \
    org.opencontainers.image.url="https://hub.docker.com/r/tobi312/rpi-cherrymusic" \
    org.opencontainers.image.source="https://github.com/Tob1as/docker-cherrymusic"

SHELL ["/bin/bash", "-euxo", "pipefail", "-c"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN \
    addgroup --gid 1000 cherrymusic ; \
    adduser --system --shell /sbin/nologin --uid 1000 --ingroup cherrymusic --home /cherrymusic cherrymusic ; \
    chmod +x /usr/local/bin/docker-entrypoint.sh ; \
    apt-get update ; \
    apt-get install -y --no-install-recommends \
        lame \
        vorbis-tools \
        flac \
        faad \
        mpg123 \
        opus-tools \
        #ffmpeg \
        imagemagick \
        wget netcat-openbsd \
    ; \
    #rm -rf /var/lib/apt/lists/*	; \
    BUILD_DEPS='gcc libcairo2-dev libgirepository1.0-dev git'; \
    #apt-get update ; \
    apt-get install -y --no-install-recommends \
        $BUILD_DEPS \
    ; \
    pip3 install --no-cache-dir Unidecode PyGObject CherryPy ; \
    git clone --branch master --single-branch https://github.com/devsnd/cherrymusic.git /cherrymusic/app ; \
    rm -r /cherrymusic/app/.git ; \
    apt remove --purge -y $BUILD_DEPS; apt autoremove -y ; \
    rm -rf /var/lib/apt/lists/*	; \
    mkdir -p /cherrymusic/{.config/cherrymusic,.local/share/cherrymusic,Music,ssl} ; \
    chown -R cherrymusic:cherrymusic /cherrymusic

VOLUME /cherrymusic/.config/cherrymusic /cherrymusic/.local/share/cherrymusic
WORKDIR /cherrymusic
USER cherrymusic
EXPOSE 8080/tcp 8443/tcp

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["python3", "-u", "./app/cherrymusic"]
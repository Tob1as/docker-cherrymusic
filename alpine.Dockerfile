FROM python:3.11-alpine3.16

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
    org.opencontainers.image.source="https://github.com/Tob1asDocker/rpi-cherrymusic"

SHELL ["/bin/sh", "-euxo", "pipefail", "-c"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN \
    addgroup --gid 1000 cherrymusic ; \
    adduser --system --shell /sbin/nologin --uid 1000 --ingroup cherrymusic --home /cherrymusic cherrymusic ; \
    chmod +x /usr/local/bin/docker-entrypoint.sh ; \
    apk add --no-cache \
        lame \
        vorbis-tools \
        flac \
        faad2 \
        mpg123 \
        opus-tools \
        #ffmpeg \
        imagemagick \
        openssl \
    ; \
    apk add --no-cache --virtual .build-deps \
        gcc \
        musl-dev \
        cairo-dev \
        gobject-introspection-dev \
        git \
    ; \
    pip3 install --no-cache-dir Unidecode PyGObject CherryPy ; \
    git clone --branch master --single-branch https://github.com/devsnd/cherrymusic.git /cherrymusic/app ; \
    rm -r /cherrymusic/app/.git ; \
    apk del --no-network --purge .build-deps ; \
    #mkdir -p /cherrymusic/{.config/cherrymusic,.local/share/cherrymusic,Music,ssl} ; \
    mkdir -p /cherrymusic/.config/cherrymusic ; \
    mkdir -p /cherrymusic/.local/share/cherrymusic ; \
    mkdir -p /cherrymusic/Music ; \
    mkdir -p /cherrymusic/ssl ; \
    chown -R cherrymusic:cherrymusic /cherrymusic

VOLUME /cherrymusic/.config/cherrymusic /cherrymusic/.local/share/cherrymusic
WORKDIR /cherrymusic
USER cherrymusic
EXPOSE 8080/tcp 8443/tcp

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["python3", "-u", "./app/cherrymusic"]
FROM python:3.11-alpine3.16

LABEL org.opencontainers.image.authors="Tobias Hargesheimer <docker@ison.ws>" \
	org.opencontainers.image.title="CherryMusic" \
	org.opencontainers.image.description="Stream your own music collection to all your devices!" \
	org.opencontainers.image.licenses="GPL-3.0" \
	org.opencontainers.image.url="https://hub.docker.com/r/tobi312/rpi-cherrymusic" \
	org.opencontainers.image.source="https://github.com/Tob1asDocker/rpi-cherrymusic"

SHELL ["/bin/sh", "-euxo", "pipefail", "-c"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN \
    addgroup --gid 1000 cherrymusic ; \
    adduser --system --shell /sbin/nologin --uid 1000 --ingroup cherrymusic --home /cherrymusic cherrymusic ; \
    chmod +x /usr/local/bin/docker-entrypoint.sh ; \
    apk add --no-cache \
        git \
        lame \
        vorbis-tools \
        flac \
        faad2 \
        mpg123 \
        opus-tools \
        #ffmpeg \
        imagemagick \
    ; \
    apk add --no-cache \
        py3-unidecode \
        py3-gobject3 \
        #py3-cherrypy \
    ; \
    #pip3 install --no-cache-dir Unidecode ; \
    #pip3 install --no-cache-dir PyGObject ; \
    pip3 install --no-cache-dir CherryPy ; \
    git clone --branch master --single-branch https://github.com/devsnd/cherrymusic.git /cherrymusic/app ; \
    rm -r /cherrymusic/app/.git ; \
    #mkdir -p /cherrymusic/{.config/cherrymusic,.local/share/cherrymusic,Music,ssl} ; \
    mkdir -p /cherrymusic/.config/cherrymusic ; \
    mkdir -p /cherrymusic/.local/share/cherrymusic ; \
    mkdir -p /cherrymusic/Music ; \
    mkdir -p /cherrymusic/ssl ; \
    chown -R cherrymusic:cherrymusic /cherrymusic

VOLUME /cherrymusic/.config/cherrymusic /cherrymusic/.local/share/cherrymusic /cherrymusic/ssl /cherrymusic/Music
WORKDIR /cherrymusic
USER cherrymusic
EXPOSE 8080/tcp 8443/tcp

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["python3", "-u", "./app/cherrymusic"]

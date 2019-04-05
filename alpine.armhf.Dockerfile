FROM balenalib/raspberry-pi2-python:3.7

LABEL org.opencontainers.image.authors="Tobias Hargesheimer <docker@ison.ws>" \
	org.opencontainers.image.title="CherryMusic" \
	org.opencontainers.image.description="AlpineLinux with CherryMusic on arm arch" \
	org.opencontainers.image.licenses="Apache-2.0" \
	org.opencontainers.image.url="https://hub.docker.com/r/tobi312/rpi-cherrymusic" \
	org.opencontainers.image.source="https://github.com/Tob1asDocker/rpi-cherrymusic"

ARG CROSS_BUILD_START=":"
ARG CROSS_BUILD_END=":"

RUN [ ${CROSS_BUILD_START} ]

ENV APP_USER=pi

RUN apt-get update && apt-get install -y \
	git \
	lame \
	vorbis-tools \
	flac \
	faad \
	mpg123 \
	opus-tools \
	#ffmpeg \
	imagemagick \
	--no-install-recommends && \
	rm -rf /var/lib/apt/lists/* 

RUN pip3 install unidecode cherrypy

COPY source/run.sh /home/$APP_USER/
RUN chmod +x /home/$APP_USER/run.sh
 
RUN useradd -ms /bin/bash $APP_USER

RUN mkdir -p /home/$APP_USER/git && cd /home/$APP_USER/git && git clone https://github.com/devsnd/cherrymusic.git cherrymusic/
RUN mkdir -p /home/$APP_USER/Music && mkdir -p /home/$APP_USER/.config/cherrymusic && mkdir -p /home/$APP_USER/.local/share/cherrymusic && mkdir -p /home/$APP_USER/.ssl

COPY source/cherrymusic.conf /home/$APP_USER/.config/cherrymusic/cherrymusic.conf

RUN chown -R $APP_USER:$APP_USER /home/$APP_USER/

USER $APP_USER
#WORKDIR /home/$APP_USER/git/cherrymusic

VOLUME /home/$APP_USER/.config/cherrymusic /home/$APP_USER/.local/share/cherrymusic /home/$APP_USER/.ssl /home/$APP_USER/Music
EXPOSE 7600/tcp 7700/tcp

ENTRYPOINT ["/home/pi/run.sh"]
CMD python3 /home/pi/git/cherrymusic/cherrymusic

RUN [ ${CROSS_BUILD_END} ]
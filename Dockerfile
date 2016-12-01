#FROM resin/raspberrypi2-python:3.5
FROM tobi312/rpi-raspberrypi2-python:3.5

MAINTAINER Tobias Hargesheimer <docker@ison.ws>

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y \
	git \
	lame \
	vorbis-tools \
	flac \
	mpg123 \
	opus-tools \
	imagemagick \
	--no-install-recommends && \
	rm -rf /var/lib/apt/lists/* 

RUN pip3 install unidecode cherrypy

ENV APP_USER=pi 
RUN useradd -ms /bin/bash $APP_USER
RUN mkdir -p /home/$APP_USER/ && chown -R pi:pi /home/$APP_USER/
USER $APP_USER

RUN mkdir -p /home/$APP_USER/git && cd /home/$APP_USER/git && git clone https://github.com/devsnd/cherrymusic.git cherrymusic/

RUN mkdir -p /home/$APP_USER/Music && mkdir -p /home/$APP_USER/.config/cherrymusic && mkdir -p /home/$APP_USER/.local/share/cherrymusic && mkdir -p /home/$APP_USER/.ssl

COPY cherrymusic.conf /home/$APP_USER/.config/cherrymusic/cherrymusic.conf

COPY run.sh /home/$APP_USER/
RUN chmod +x /home/$APP_USER/run.sh

#WORKDIR /home/$APP_USER/git/cherrymusic

RUN [ "cross-build-end" ]

VOLUME /home/$APP_USER/.config/cherrymusic /home/$APP_USER/.local/share/cherrymusic /home/$APP_USER/.ssl /home/$APP_USER/Music
EXPOSE 7600/tcp 7700/tcp

ENTRYPOINT ["/home/pi/run.sh"]
CMD python3 /home/pi/git/cherrymusic/cherrymusic

# CherryMusic on Raspberry Pi / armhf

### Supported tags
-	`latest` (*It always uses the latest CherryMusic version from [github.com/devsnd/cherrymusic](https://github.com/devsnd/cherrymusic).*)

### What is CherryMusic?
CherryMusic is a open-source music streaming server written in python, that stream your own music collection to all your devices! For more information and downloads please visit [fomori.org/cherrymusic/](http://www.fomori.org/cherrymusic/) or [github.com/devsnd/cherrymusic](https://github.com/devsnd/cherrymusic).

### How to use this image
* ``` $ docker pull tobi312/rpi-cherrymusic ```
* Optional: ``` $ mkdir -p /home/pi/.config/cherrymusic && mkdir -p /home/pi/.local/share/cherrymusic && mkdir -p /home/pi/.ssl && touch /home/pi/.config/cherrymusic/cherrymusic.conf ``` and edit optional [cherrymusic.conf](https://github.com/TobiasH87Docker/rpi-cherrymusic/blob/master/cherrymusic.conf)
* Optional (SSL): 
	* ``` $ openssl req -x509 -newkey rsa:4086 -subj "/C=/ST=/L=/O=/CN=localhost" -keyout "ssl.key" -out "ssl.crt" -days 3650 -nodes -sha256 ```
	* ``` $ mv ssl.* /home/pi/.ssl/ ```
* ``` $ docker run --name cherrymusic -it -v /home/pi/.config/cherrymusic:/home/pi/.config/cherrymusic -v /home/pi/.local/share/cherrymusic:/home/pi/.local/share/cherrymusic -v /home/pi/.ssl:/home/pi/.ssl:ro -v /home/pi/Music:/home/pi/Music:ro -p 7600:7600 -p 7700:7700 tobi312/rpi-cherrymusic ```

or build it yourself
* ``` $ git clone https://github.com/TobiasH87Docker/rpi-cherrymusic.git && cd rpi-cherrymusic ```
* ``` $ docker build -t tobi312/rpi-cherrymusic . ```
* Optional: ``` $ mkdir -p /home/pi/.config/cherrymusic && mkdir -p /home/pi/.local/share/cherrymusic && mkdir -p /home/pi/.ssl && mkdir -p /home/pi/Music && cp cherrymusic.conf /home/pi/.config/cherrymusic/ ``` and edit optional [cherrymusic.conf](https://github.com/TobiasH87Docker/rpi-cherrymusic/blob/master/cherrymusic.conf)
* Optional (SSL)
* ``` $ docker run --name cherrymusic -it -v /home/pi/.config/cherrymusic:/home/pi/.config/cherrymusic:ro -v /home/pi/.local/share/cherrymusic:/home/pi/.local/share/cherrymusic -v /home/pi/.ssl:/home/pi/.ssl:ro -v /home/pi/Music:/home/pi/Music:ro -p 7600:7600 -p 7700:7700 tobi312/rpi-cherrymusic ```

* http://localhost:7600 or with SSL https://localhost:7700 (First call genarate a admin account.)

### This Image on
* [DockerHub](https://hub.docker.com/r/tobi312/rpi-cherrymusic/)
* [GitHub](https://github.com/TobiasH87Docker/rpi-cherrymusic)

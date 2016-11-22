# Dockerfile for CherryMusic on Raspberry Pi
* http://www.fomori.org/cherrymusic/
* https://github.com/devsnd/cherrymusic

Use:
* ``` git clone REPOSITORY && cd rpi-cherrymusic ```
* Optional: ``` mkdir -p /home/pi/.config/cherrymusic && mkdir -p /home/pi/.local/share/cherrymusic && mkdir -p /home/pi/.ssl && mkdir -p /home/pi/Music && cp cherrymusic.conf /home/pi/.config/cherrymusic/ ```
* ``` chmod +x run.sh ```
* ``` docker build -t rpi-cherrymusic . ```
* ``` docker run --name cherrymusic -it -v /home/pi/.config/cherrymusic:/home/pi/.config/cherrymusic:ro -v /home/pi/.local/share/cherrymusic:/home/pi/.local/share/cherrymusic -v /home/pi/.ssl:/home/pi/.ssl:ro -v /home/pi/Music:/home/pi/Music:ro -p 7600:7600 -p 7700:7700 rpi-cherrymusic ```
* http://localhost:7600

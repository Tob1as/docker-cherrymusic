# CherryMusic (Docker Image) 

### Supported tags and respective `Dockerfile` links
- [`alpine` (*Dockerfile*)](https://github.com/Tob1asDocker/rpi-cherrymusic/blob/master/alpine.Dockerfile)
- [`debian` (*Dockerfile*)](https://github.com/Tob1asDocker/rpi-cherrymusic/blob/master/debian.Dockerfile)
  
*It always uses the latest CherryMusic version from [master](https://github.com/devsnd/cherrymusic/tree/master)-branch from git.  
(branches: master=stable-version, devel=development-version)*

### What is CherryMusic?

![logo](https://raw.githubusercontent.com/devsnd/cherrymusic/master/res/img/favicon32.png)  [CherryMusic](https://github.com/devsnd/cherrymusic) is a music streaming server based on [CherryPy](https://github.com/cherrypy/cherrypy) and [jPlayer](https://github.com/jplayer/jPlayer). It plays the music inside your PC, smartphone, tablet, toaster or whatever device has a HTML5 compliant browser installed. For more information visit [github.com/devsnd/cherrymusic](https://github.com/devsnd/cherrymusic)

### How to use this image

* see [docker-compose.yml](https://github.com/Tob1asDocker/rpi-cherrymusic/blob/master/docker-compose.yml)-File
* Call http://localhost:8080 or with SSL https://localhost:8443  
(First call genarate a admin account!)

### This Image on
* [DockerHub](https://hub.docker.com/r/tobi312/rpi-cherrymusic/)
* [GitHub](https://github.com/Tob1asDocker/rpi-cherrymusic)
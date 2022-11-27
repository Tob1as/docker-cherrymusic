#!/bin/sh
set -eu

# https://github.com/devsnd/cherrymusic/blob/master/cherrymusicserver/pathprovider.py#L38
LOCKFILE=/cherrymusic/.local/share/cherrymusic/cherrymusic.pid
if [ -f $LOCKFILE ]; then
    echo ">> delete lockfile (from last start) ..."
    rm -f $LOCKFILE 
fi

# ToDO, settings over env:
# * load config from git as default config, when not exits
#   https://github.com/Tob1asDocker/rpi-cherrymusic/blob/master/cherrymusic.conf
# * replace settings in config (use: sed), important "basedir" set to /cherrymusic/Music

# exec CMD
echo ">> exec CMD: \"$@\""
exec "$@"

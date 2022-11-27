#!/bin/sh
set -eu

: "${CONFIG_DOWNLOAD_ENABLE:="1"}"
: "${CONFIG_DOWNLOAD_URL:="https://raw.githubusercontent.com/Tob1asDocker/rpi-cherrymusic/master/cherrymusic.conf"}"
: "${CONFIG_PATH:="/cherrymusic/.config/cherrymusic/cherrymusic.conf"}"

# https://github.com/devsnd/cherrymusic/blob/master/cherrymusicserver/pathprovider.py#L38
LOCKFILE=/cherrymusic/.local/share/cherrymusic/cherrymusic.pid
if [ -f $LOCKFILE ]; then
    echo ">> delete lockfile (from last start) ..."
    rm -f $LOCKFILE 
fi

if [ "$CONFIG_DOWNLOAD_ENABLE" -eq "1" -a ! -f "${CONFIG_PATH}" ] ; then
    echo ">> download config ..."
    wget -q ${CONFIG_DOWNLOAD_URL} -O ${CONFIG_PATH}
fi

# ToDO, settings over env:
# * replace settings in config (use: sed), important "basedir" set to /cherrymusic/Music
# * when enable ssl and no certficate found, then create self sign.

# exec CMD
echo ">> exec CMD: \"$@\""
exec "$@"

#!/bin/bash
set -e

#echo $APP_USER;
LOCKFILE=/home/$APP_USER/.local/share/cherrymusic/cherrymusic.pid
if [ -f $LOCKFILE ]; then
  rm -f $LOCKFILE 
fi

exec "$@"

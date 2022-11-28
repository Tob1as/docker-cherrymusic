#!/bin/sh
set -eu

# BASE
: "${CONFIG_DOWNLOAD_ENABLE:="1"}"
: "${CONFIG_DOWNLOAD_URL:="https://raw.githubusercontent.com/Tob1asDocker/rpi-cherrymusic/master/cherrymusic.conf"}"
: "${CONFIG_PATH:="/cherrymusic/.config/cherrymusic/cherrymusic.conf"}" # DO NOT CHANGE !
# CONFIG for cherrymusic.conf (settings will only changes when value is set and config is exists (from Download))
: "${MEDIA_BASEDIR:=""}"                    # default: none, recommended: /cherrymusic/Music
: "${MEDIA_TRANSCODE:=""}"                  # default: False
: "${MEDIA_FETCH_ALBUM_ART:=""}"            # default: False
: "${MEDIA_SHOW_SUBFOLDER_COUNT:=""}"       # default: True 
: "${MEDIA_MAXIMUM_DOWNLOAD_SIZE:=""}"      # default: 262144000  (byte)
: "${SEARCH_MAXRESULTS:=""}"                # default: 20
: "${SEARCH_LOAD_FILE_DB_INTO_MEMORY:=""}"  # default: False
: "${BROWSER_MAXSHOWFILES:=""}"             # default: 100
: "${BROWSER_PURE_DATABASE_LOOKUP:=""}"     # default: False
: "${SERVER_PORT:=""}"                      # default: 8080
: "${SERVER_IPV6_ENABLED:=""}"              # default: False
: "${SERVER_LOCALHOST_ONLY:=""}"            # default: False
: "${SERVER_ROOTPATH:=""}"                  # default: /   , example: /cherrymusic
: "${SERVER_LOCALHOST_AUTO_LOGIN:=""}"      # default: False
: "${SERVER_PERMIT_REMOTE_ADMIN_LOGIN:=""}" # default: True
: "${SERVER_KEEP_SESSION_IN_RAM:=""}"       # default: False
: "${SERVER_SESSION_DURATION:=""}"          # default: 1440
: "${SERVER_SSL_ENABLED:=""}"               # default: False
: "${SERVER_SSL_PORT:=""}"                  # default: 8443
: "${SERVER_SSL_CERTIFICATE:=""}"           # default: certs/server.crt, recommended: /cherrymusic/ssl/server.crt
: "${SERVER_SSL_PRIVATE_KEY:=""}"           # default: certs/server.key, recommended: /cherrymusic/ssl/server.key
: "${GENERAL_UPDATE_NOTIFICATION:=""}"      # default: True
# Other Settings
: "${SELF_SIGNED_CERT_CREATE:="0"}"  # create self-signed certificate, default: 0 (=False)
SERVER_SSL_CERTIFICATE_RECOMMENDED="/cherrymusic/ssl/server.crt"
SERVER_SSL_PRIVATE_KEY_RECOMMENDED="/cherrymusic/ssl/server.key"

#####

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

#####

if [ -n "$MEDIA_BASEDIR" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set basedir = ${MEDIA_BASEDIR} ..."
    sed -i "s|basedir =.*|basedir = ${MEDIA_BASEDIR}|g" ${CONFIG_PATH}
fi

if [ -n "$MEDIA_TRANSCODE" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set transcode = ${MEDIA_TRANSCODE} ..."
    sed -i "s|transcode =.*|transcode = ${MEDIA_TRANSCODE}|g" ${CONFIG_PATH}
fi

if [ -n "$MEDIA_FETCH_ALBUM_ART" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set fetch_album_art = ${MEDIA_FETCH_ALBUM_ART} ..."
    sed -i "s|fetch_album_art =.*|fetch_album_art = ${MEDIA_FETCH_ALBUM_ART}|g" ${CONFIG_PATH}
fi

if [ -n "$MEDIA_SHOW_SUBFOLDER_COUNT" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set show_subfolder_count = ${MEDIA_SHOW_SUBFOLDER_COUNT} ..."
    sed -i "s|show_subfolder_count =.*|show_subfolder_count = ${MEDIA_SHOW_SUBFOLDER_COUNT}|g" ${CONFIG_PATH}
fi

if [ -n "$MEDIA_MAXIMUM_DOWNLOAD_SIZE" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set maximum_download_size = ${MEDIA_MAXIMUM_DOWNLOAD_SIZE} ..."
    sed -i "s|maximum_download_size =.*|maximum_download_size = ${MEDIA_MAXIMUM_DOWNLOAD_SIZE}|g" ${CONFIG_PATH}
fi

if [ -n "$SEARCH_MAXRESULTS" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set maxresults = ${SEARCH_MAXRESULTS} ..."
    sed -i "s|maxresults =.*|maxresults = ${SEARCH_MAXRESULTS}|g" ${CONFIG_PATH}
fi

if [ -n "$SEARCH_LOAD_FILE_DB_INTO_MEMORY" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set load_file_db_into_memory = ${SEARCH_LOAD_FILE_DB_INTO_MEMORY} ..."
    sed -i "s|load_file_db_into_memory =.*|load_file_db_into_memory = ${SEARCH_LOAD_FILE_DB_INTO_MEMORY}|g" ${CONFIG_PATH}
fi

if [ -n "$SEARCH_MAXRESULTS" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set maxshowfiles = ${SEARCH_MAXRESULTS} ..."
    sed -i "s|maxshowfiles =.*|maxshowfiles = ${SEARCH_MAXRESULTS}|g" ${CONFIG_PATH}
fi

if [ -n "$BROWSER_PURE_DATABASE_LOOKUP" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set pure_database_lookup = ${BROWSER_PURE_DATABASE_LOOKUP} ..."
    sed -i "s|pure_database_lookup =.*|pure_database_lookup = ${BROWSER_PURE_DATABASE_LOOKUP}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_PORT" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set port = ${SERVER_PORT} ..."
    sed -i "s|port =.*|port = ${SERVER_PORT}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_IPV6_ENABLED" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set ipv6_enabled = ${SERVER_IPV6_ENABLED} ..."
    sed -i "s|ipv6_enabled =.*|ipv6_enabled = ${SERVER_IPV6_ENABLED}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_LOCALHOST_ONLY" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set localhost_only = ${SERVER_LOCALHOST_ONLY} ..."
    sed -i "s|localhost_only =.*|localhost_only = ${SERVER_LOCALHOST_ONLY}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_ROOTPATH" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set rootpath = ${SERVER_ROOTPATH} ..."
    sed -i "s|rootpath =.*|rootpath = ${SERVER_ROOTPATH}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_LOCALHOST_AUTO_LOGIN" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set localhost_auto_login = ${SERVER_LOCALHOST_AUTO_LOGIN} ..."
    sed -i "s|localhost_auto_login =.*|localhost_auto_login = ${SERVER_LOCALHOST_AUTO_LOGIN}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_PERMIT_REMOTE_ADMIN_LOGIN" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set permit_remote_admin_login = ${SERVER_PERMIT_REMOTE_ADMIN_LOGIN} ..."
    sed -i "s|permit_remote_admin_login =.*|permit_remote_admin_login = ${SERVER_PERMIT_REMOTE_ADMIN_LOGIN}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_KEEP_SESSION_IN_RAM" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set keep_session_in_ram = ${SERVER_KEEP_SESSION_IN_RAM} ..."
    sed -i "s|keep_session_in_ram =.*|keep_session_in_ram = ${SERVER_KEEP_SESSION_IN_RAM}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_SESSION_DURATION" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set session_duration = ${SERVER_SESSION_DURATION} ..."
    sed -i "s|session_duration =.*|session_duration = ${SERVER_SESSION_DURATION}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_SSL_ENABLED" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set ssl_enabled = ${SERVER_SSL_ENABLED} ..."
    sed -i "s|ssl_enabled =.*|ssl_enabled = ${SERVER_SSL_ENABLED}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_SSL_PORT" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set ssl_port = ${SERVER_SSL_PORT} ..."
    sed -i "s|ssl_port =.*|ssl_port = ${SERVER_SSL_PORT}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_SSL_CERTIFICATE" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set ssl_certificate = ${SERVER_SSL_CERTIFICATE} ..."
    sed -i "s|ssl_certificate =.*|ssl_certificate = ${SERVER_SSL_CERTIFICATE}|g" ${CONFIG_PATH}
    #sed -i "s|ssl_certificate =.*|ssl_certificate = ${SERVER_SSL_CERTIFICATE_RECOMMENDED}|g" ${CONFIG_PATH}
fi

if [ -n "$SERVER_SSL_PRIVATE_KEY" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set ssl_private_key = ${SERVER_SSL_PRIVATE_KEY} ..."
    sed -i "s|ssl_private_key =.*|ssl_private_key = ${SERVER_SSL_PRIVATE_KEY}|g" ${CONFIG_PATH}
    #sed -i "s|ssl_private_key =.*|ssl_private_key = ${SERVER_SSL_PRIVATE_KEY_RECOMMENDED}|g" ${CONFIG_PATH}
fi

if [ -n "$GENERAL_UPDATE_NOTIFICATION" -a -f "${CONFIG_PATH}" ]; then
    echo ">> set update_notification = ${GENERAL_UPDATE_NOTIFICATION} ..."
    sed -i "s|update_notification =.*|update_notification = ${GENERAL_UPDATE_NOTIFICATION}|g" ${CONFIG_PATH}
fi

####

if [ "$SELF_SIGNED_CERT_CREATE" -eq "1" -a ! -f "${SERVER_SSL_CERTIFICATE_RECOMMENDED}" -a ! -f "${SERVER_SSL_PRIVATE_KEY_RECOMMENDED}" ] ; then
    echo ">> create self-signed certificate ..."
    openssl req -x509 -newkey rsa:4086 -sha256 -days 3650 -nodes -subj "/C=no/ST=none/L=none/O=Linux\ Community/CN=CherryMusic" -keyout "${SERVER_SSL_PRIVATE_KEY_RECOMMENDED}" -out "${SERVER_SSL_CERTIFICATE_RECOMMENDED}"
fi

####

# exec CMD
echo ">> exec CMD: \"$@\""
exec "$@"

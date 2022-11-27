#!/bin/bash
# EXAMPLE, change the settings !

# Required package (on Debian/Ubuntu), install: sudo apt-get install cifs-utils

sudo mount -t cifs -o uid=1000,gid=1000,file_mode=0775,dir_mode=0775,username=USERNAME,password=PASSWORD //IP/and/path ${PWD}/Music/smbmusic

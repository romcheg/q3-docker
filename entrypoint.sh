#/bin/bash

set -uex

#./serverfiles/q3ded +set sv_punkbuster 0 +set fs_basepath /home/q3server/serverfiles +set dedicated 2 +set com_hunkMegs 32 +set net_ip 172.17.0.2 +set net_port 27960 +exec q3server.cfg +map q3dm17
./q3server start

tail -c+1 -f ./log/console/q3server-console.log

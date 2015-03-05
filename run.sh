#!/bin/sh

NOTEBOOKS_DIR=`find "${PWD}" -name notebooks -depth 1`

docker run -ditP -v "${NOTEBOOKS_DIR}:/root/notebooks" datasci

sleep 2

MACHINE=`docker ps | tail -n +2 | awk '{ print $1 }'`
IP=`boot2docker ip`
PORT=`docker port "${MACHINE}" | awk -F ':' '{ print $2 }'`

open -a 'Google Chrome' "http://${IP}:${PORT}"

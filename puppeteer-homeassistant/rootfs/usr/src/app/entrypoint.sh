#!/usr/bin/env bash
env || true

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"


while true;
do
    su user -c "PUPPETEER_EXECUTABLE_PATH=$PUPPETEER_EXECUTABLE_PATH ${SCRIPTPATH}/homeassistant.sh"
    # ${SCRIPTPATH}/homeassistant.sh
    sleep ${SLEEP:=60} || sleep 300
done
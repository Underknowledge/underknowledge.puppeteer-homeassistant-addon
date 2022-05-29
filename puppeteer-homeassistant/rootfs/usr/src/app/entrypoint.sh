#!/usr/bin/env bash
env || true

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
if [ -f /usr/bin/google-chrome ]; then
    export PUPPETEER_EXECUTABLE_PATH="/usr/bin/google-chrome"
elif [ -f /usr/bin/chromium-browser ]; then
    export PUPPETEER_EXECUTABLE_PATH="/usr/bin/chromium-browser"
elif [ -f /usr/bin/firefox ]; then
    export PUPPETEER_EXECUTABLE_PATH="/usr/bin/firefox"
fi

while true;
do
    su user -c "PUPPETEER_EXECUTABLE_PATH=$PUPPETEER_EXECUTABLE_PATH ${SCRIPTPATH}/homeassistant.sh"
    # ${SCRIPTPATH}/homeassistant.sh
    sleep ${SLEEP:=60} || sleep 300
done
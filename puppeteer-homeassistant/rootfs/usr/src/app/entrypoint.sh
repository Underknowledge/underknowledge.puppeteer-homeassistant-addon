#!/usr/bin/env bash
env || true

SCRIPTPATH="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
if [ -f /usr/bin/google-chrome ]; then
    export browser="/usr/bin/google-chrome"
elif [ -f /usr/bin/chromium-browser ]; then
    export browser="/usr/bin/chromium-browser"
elif [ -f /usr/bin/firefox ]; then
    export browser="/usr/bin/firefox"
fi

while true;
do
    ${SCRIPTPATH}/homeassistant.sh
    sleep ${SLEEP:=60} || sleep 300
done
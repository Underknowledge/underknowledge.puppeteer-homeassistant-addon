#!/usr/bin/env bash
env || true

while true;
do
    ./homeassistant.sh
    sleep ${SLEEP:=60} || sleep 300
done
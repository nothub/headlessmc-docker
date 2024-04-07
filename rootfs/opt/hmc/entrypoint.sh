#!/usr/bin/env sh

set -eu

addgroup \
    --gid "${PGID}" \
    --system \
    "hmc" 1> /dev/null 2> /dev/null

adduser \
    --uid "${PUID}" \
    --system \
    --disabled-password \
    --ingroup "hmc" \
    --home "/work" \
    "hmc" 1> /dev/null 2> /dev/null

if test ! -f "/work/HeadlessMC/config.properties"; then
    mkdir -p "/work/HeadlessMC"
    cp "/opt/hmc/config.defaults.properties" "/work/HeadlessMC/config.properties"
fi

if test -n "${ADDR}"; then
    if test -z "${PORT}"; then
        PORT="25565"
    fi
    echo >&2 "target server: ${ADDR}:${PORT}"
    gameargs="--quickPlayMultiplayer ${ADDR}:${PORT} --server ${ADDR} --port ${PORT}"
    sed -Ei "s/hmc\.gameargs\s*=.*/hmc.gameargs=${gameargs}/g" "/work/HeadlessMC/config.properties"
fi

find "/opt/hmc/" -type "f" -exec chmod "o+r" "{}" \;
chown -R "hmc:hmc" "/work"

cd "/work"
runuser --user "hmc" --group "hmc" -- java -jar "/opt/hmc/launcher.jar" --command "${@}"

#!/usr/bin/env sh

set -eu

addgroup \
    --gid "${PGID}" \
    --system \
    "hmc" 1>/dev/null 2>/dev/null

adduser \
    --uid "${PUID}" \
    --system \
    --disabled-password \
    --ingroup "hmc" \
    --home "/work" \
    "hmc" 1>/dev/null 2>/dev/null

if test ! -f "/work/HeadlessMC/config.properties"; then
    mkdir -p "/work/HeadlessMC"
    cp "/opt/hmc/config.defaults.properties" "/work/HeadlessMC/config.properties"
fi

find "/opt/hmc/" -type "f" -exec chmod "o+r" "{}" \;
chown -R "hmc:hmc" "/work"

cd "/work"
runuser --user "hmc" --group "hmc" -- java -jar "/opt/hmc/launcher.jar" --command "${@}"

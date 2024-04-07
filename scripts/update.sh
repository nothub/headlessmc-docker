#!/usr/bin/env sh

set -eu

# workdir is repository root
cd "$(dirname "$(realpath "$0")")/.."

version="$(curl -fsSL \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -H "Accept: application/vnd.github+json" \
    https://api.github.com/repos/3arthqu4ke/HeadlessMc/releases/latest \
    | jq -r '.tag_name')"

if grep -F "HMC_VERSION=\"${version}\"" Dockerfile 1> /dev/null; then
    echo >&2 "already on latest version: ${version}"
    exit 0
else
    echo >&2 "updating to new version: ${version}"
fi

file="$(mktemp)"
curl -fsSL -o "${file}" "https://github.com/3arthqu4ke/HeadlessMc/releases/download/${version}/headlessmc-launcher-${version}.jar"
hash="$(sha256sum "${file}" | awk '{  print $1}')"
rm -f "${file}"

sed -Ei "s/^ARG HMC_VERSION=\".+\"$/ARG HMC_VERSION=\"${version}\"/" Dockerfile
sed -Ei "s/^ARG HMC_CHECKSUM=\".+\"$/ARG HMC_CHECKSUM=\"${hash}\"/" Dockerfile

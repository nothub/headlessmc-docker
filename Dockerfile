FROM debian:12-slim

ARG HMC_VERSION="2.6.1"
ARG HMC_CHECKSUM="5be45065065d663da472fb084b3d869a969dc966ec10ccda41aec8656479e781"
ARG HMC_URL="https://github.com/3arthqu4ke/HeadlessMc/releases/download/${HMC_VERSION}/headlessmc-launcher-linux-x64"

ADD "${HMC_URL}" /usr/local/bin/headlessmc
RUN echo "${HMC_CHECKSUM} /usr/local/bin/headlessmc" | sha256sum -c - \
 && chmod +x /usr/local/bin/headlessmc

COPY rootfs/ /

# even tho hmc can download jvms on its own now, we distribute
# some directly with the image because it is more convenient
# then caching jvm downloads between container runs.
RUN apt-get update                              \
 && apt-get upgrade -qy --with-new-pkgs         \
 && apt-get install -qy --no-install-recommends \
    apt-transport-https                         \
    ca-certificates                             \
    gpg                                         \
    tini                                        \
 && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/adoptium.gpg] https://packages.adoptium.net/artifactory/deb bookworm main' > /etc/apt/sources.list.d/adoptium.list \
 && cat /usr/share/keyrings/adoptium.asc | gpg --dearmor > /usr/share/keyrings/adoptium.gpg \
 && rm -f /usr/share/keyrings/adoptium.asc      \
 && apt-get update                              \
 && apt-get install -qy --no-install-recommends \
    temurin-17-jdk                              \
    temurin-21-jdk                              \
 && apt-get clean -qy                           \
 && apt-get autoremove -qy                      \
 && rm -rf /var/lib/apt/lists/*

ENV PUID=1000
ENV PGID=1000

ENV ADDR=""
ENV PORT=""

ENTRYPOINT ["tini", "-v", "--", "/opt/hmc/entrypoint.sh"]

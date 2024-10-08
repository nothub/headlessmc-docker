FROM debian:12-slim

ARG HMC_VERSION="2.2.0"
ARG HMC_CHECKSUM="0b1c27828ce9f47fe400aef1a75e82803759c9d82001414b9b937f728af87c51"
ARG HMC_URL="https://github.com/3arthqu4ke/HeadlessMc/releases/download/${HMC_VERSION}/headlessmc-launcher-wrapper-${HMC_VERSION}.jar"

ADD "${HMC_URL}" /opt/hmc/launcher.jar
RUN echo "${HMC_CHECKSUM} /opt/hmc/launcher.jar" | sha256sum -c -

COPY rootfs/ /

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
    temurin-8-jdk                               \
    temurin-11-jdk                              \
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

FROM debian:12-slim

ARG HMC_VERSION="1.10.2"
ARG HMC_CHECKSUM="ca852045884b2d562ca362f80e2999d19805638fbbc0f8800dfa5c5d6490afc6"
ARG HMC_URL="https://github.com/3arthqu4ke/HeadlessMc/releases/download/${HMC_VERSION}/headlessmc-launcher-${HMC_VERSION}.jar"

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
    wget

RUN wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | gpg --dearmor | tee /etc/apt/trusted.gpg.d/adoptium.gpg > /dev/null \
 && echo  "deb https://packages.adoptium.net/artifactory/deb bookworm main" | tee /etc/apt/sources.list.d/adoptium.list

RUN apt-get update                              \
 && apt-get install -qy --no-install-recommends \
    temurin-21-jre                              \
 && apt-get clean -qy                           \
 && apt-get autoremove -qy                      \
 && rm -rf /var/lib/apt/lists/*

ENV PUID=1000
ENV PGID=1000

ENV ADDR=""
ENV PORT=""

ENTRYPOINT ["tini", "-v", "--", "/opt/hmc/entrypoint.sh"]

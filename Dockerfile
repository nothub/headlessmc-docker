FROM debian:12-slim

ARG HMC_VERSION="1.10.3"
ARG HMC_CHECKSUM="126f9fe7fa5651e2df382fdd87d3faa868bb21be356cf694bed9c19eaa038079"
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

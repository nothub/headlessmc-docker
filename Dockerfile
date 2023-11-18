FROM debian:12-slim

ARG HMC_VERSION="1.7.3"
ARG HMC_CHECKSUM="015011429d659ac4b39bb137acf284cecbd92997eb7b0f15f083870610a0b3ba"
ARG HMC_URL="https://github.com/3arthqu4ke/HeadlessMc/releases/download/${HMC_VERSION}/headlessmc-launcher-${HMC_VERSION}.jar"

ADD "${HMC_URL}" /opt/hmc/launcher.jar
RUN echo "${HMC_CHECKSUM} /opt/hmc/launcher.jar" | sha256sum -c -

COPY entrypoint.sh /opt/hmc/entrypoint.sh
COPY config.defaults.properties /opt/hmc/config.defaults.properties

RUN apt-get update                              \
 && apt-get upgrade -qy --with-new-pkgs         \
 && apt-get install -qy --no-install-recommends \
    openjdk-17-jre-headless                     \
    tini                                        \
 && apt-get clean -qy                           \
 && apt-get autoremove -qy                      \
 && rm -rf /var/lib/apt/lists/*

ENV PUID=1000
ENV PGID=1000

ENTRYPOINT ["tini", "-v", "--", "/opt/hmc/entrypoint.sh"]

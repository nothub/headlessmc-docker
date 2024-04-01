FROM debian:12-slim

ARG HMC_VERSION="1.9.1"
ARG HMC_CHECKSUM="16a88b58e145d8fdf13d3a08961b69517bd5b54bdef7c578c9588442e8b9e501"
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

ENV ADDR=""
ENV PORT=""

ENTRYPOINT ["tini", "-v", "--", "/opt/hmc/entrypoint.sh"]

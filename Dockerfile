FROM debian:12-slim

ARG HMC_VERSION="1.9.2"
ARG HMC_CHECKSUM="5a18a93140e15b08d93d8f3a65258c252055e5644db24915f1809679995f9cb1"
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

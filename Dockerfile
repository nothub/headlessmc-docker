FROM debian:12-slim

ARG HMC_VERSION="1.9.5"
ARG HMC_CHECKSUM="956ead6e791075f11724349656a699e9c410f813a103934b055e2caa1fdf0ddc"
ARG HMC_URL="https://github.com/3arthqu4ke/HeadlessMc/releases/download/${HMC_VERSION}/headlessmc-launcher-${HMC_VERSION}.jar"

ADD "${HMC_URL}" /opt/hmc/launcher.jar
RUN echo "${HMC_CHECKSUM} /opt/hmc/launcher.jar" | sha256sum -c -

COPY rootfs/ /

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

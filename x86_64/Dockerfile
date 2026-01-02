FROM fedora:43
LABEL maintainer="mshazninazeer@gmail.com"

ARG USER=choreouser
ARG USER_ID=10786
ARG USER_GROUP=choreo
ARG USER_GROUP_ID=10786
ARG USER_HOME=/home/${USER}
ARG APP_NAME=license-generator
ARG VERSION=1-x86_64
ARG SERVER_NAME=${APP_NAME}-${VERSION}
ARG APP_SERVER=${USER_HOME}/${SERVER_NAME}
ARG SERVER_DIST_URL=https://www.dropbox.com/scl/fi/lwkakzbzye9bt779afevj/license-generator-1-x86_64.zip?rlkey=dzfi3jv926fz2cwyc0g876zr8&st=9yhfjxfr&dl=0

ARG MOTD="\n\
Hello there. Welcome to License Generator.\n\
-------------------------------------------------------------------------------------- \n\
This Docker container contains runnable License Generator.\n\
-------------------------------------------------------------------------------------- \n"

RUN addgroup -g 11786 choreo && \
    adduser --disabled-password  --no-create-home --uid 11786 --ingroup choreo choreouser \
    && echo '[ ! -z "${TERM}" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc; echo "${MOTD}" > /etc/motd

RUN \
    dnf -y update \
    && dnf -y install unzip \
        wget

RUN \
    wget -O ${APP_SERVER}.zip "${SERVER_DIST_URL}" \
    && unzip -d ${USER_HOME} ${APP_SERVER}.zip \
    && rm -f ${APP_SERVER}.zip

RUN \
    dnf -y remove wget \
    && dnf -y remove unzip \
    && dnf -y clean all

USER 11786
WORKDIR ${APP_SERVER}/bin

ENV WORKING_DIRECTORY=${APP_SERVER} \
    USER_HOME=${USER_HOME}

COPY --chmod=0755 container-entrypoint.sh ${WORKING_DIRECTORY}/bin

ENTRYPOINT ["./container-entrypoint.sh"]

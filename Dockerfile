FROM fedora:43
LABEL maintainer="mshazninazeer@gmail.com"

ARG USER=hydrogen
ARG USER_ID=10786
ARG USER_GROUP=electron
ARG USER_GROUP_ID=10786
ARG USER_HOME=/home/${USER}
ARG APP_NAME=license-generator
ARG VERSION=-0.1-x86_64
ARG SERVER_NAME=${APP_NAME}-${VERSION}
ARG APP_SERVER=${USER_HOME}/${SERVER_NAME}
ARG SERVER_DIST_URL=https://www.dropbox.com/scl/fi/m95kmhw0h43ju9zj9zaoy/license_generator.zip?rlkey=mj8ikd5jpi4uaml2rbywcksy1&st=qbifj5j6&dl=0

ARG MOTD="\n\
Hello there. Welcome to License Generator.\n\
-------------------------------------------------------------------------------------- \n\
This Docker container contains runnable License Generator.\n\
-------------------------------------------------------------------------------------- \n"

RUN \
    groupadd --system -g ${USER_GROUP_ID} ${USER_GROUP} \
    && useradd --system --create-home --home-dir ${USER_HOME} --no-log-init -g ${USER_GROUP_ID} -u ${USER_ID} ${USER} \
    && echo '[ ! -z "${TERM}" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc; echo "${MOTD}" > /etc/motd

RUN \
    dnf -y update \
    && dnf -y install unzip \
        wget

RUN \
    wget --no-check-certificate -O ${APP_SERVER}.zip "${SERVER_DIST_URL}" \
    && unzip -d ${USER_HOME} ${APP_SERVER}.zip \
    && chown ${USER}:${USER_GROUP} -R ${APP_SERVER} \
    && rm -f ${APP_SERVER}.zip

RUN \
    dnf -y remove wget \
    && dnf -y remove unzip \
    && dnf -y clean all

USER ${USER_ID}
WORKDIR ${APP_SERVER}/bin

ENV WORKING_DIRECTORY=${APP_SERVER} \
    USER_HOME=${USER_HOME}

COPY --chown=${USER}:${USER_GROUP} container-entrypoint.sh ${WORKING_DIRECTORY}/bin

ENTRYPOINT ["./container-entrypoint.sh"]
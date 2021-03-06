FROM ubuntu:focal

ARG PACKAGE_VERSION=""

LABEL maintainer="Roman Prykhodchenko"
LABEL authors="Roman Prykhodchenko"
LABEL description="Quake 3 Arena server managed with Linux GSM."
LABEL version="${PACKAGE_VERSION}"

ENV DEBIAN_FRONTEND noninteractive
RUN dpkg --add-architecture i386 && \
    apt -y update && \
    apt -y --no-install-recommends install \
        locales ca-certificates file python3 iproute2 wget bsdmainutils unzip binutils bc jq tmux netcat lib32gcc1 lib32stdc++6 xz-utils curl && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ARG Q3_USER="q3server"
ENV Q3_USER=$Q3_USER

RUN useradd -d "/home/${Q3_USER}" -m -G tty -s /bin/bash "${Q3_USER}" && \
    curl -L https://linuxgsm.sh > "/home/${Q3_USER}/linuxgsm.sh" && \
    chown "${Q3_USER}" "/home/${Q3_USER}/linuxgsm.sh" && \
    chmod 0700 "/home/${Q3_USER}/linuxgsm.sh" && \
    cd "/home/${Q3_USER}/" && \
    su - "${Q3_USER}" -c "./linuxgsm.sh q3server && ./q3server auto-install"

ADD entrypoint.sh "/home/${Q3_USER}/entrypoint.sh"

USER $Q3_USER
WORKDIR "/home/${Q3_USER}/"

ENTRYPOINT "./entrypoint.sh"

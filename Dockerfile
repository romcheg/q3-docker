FROM ubuntu:trusty

ARG PACKAGE_VERSION=""

LABEL maintainer="Roman Prykhodchenko"
LABEL authors="Roman Prykhodchenko"
LABEL description="Quake 3 Arena server managed with Linux GSM."
LABEL version="${PACKAGE_VERSION}"

RUN dpkg --add-architecture i386 && \
    sudo apt update && \
    sudo apt install wget bsdmainutils unzip binutils bc jq tmux netcat lib32gcc1 lib32stdc++6 xz-utils && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ENV Q3_USER q3server

RUN useradd -d "/home/${Q3_USER}" -m -s /bin/false "${Q3_USER}" 
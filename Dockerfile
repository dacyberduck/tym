FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update
RUN apt-get install -y build-essential autoconf libgtk-3-dev libvte-2.91-dev liblua5.3-dev libluajit-5.1-dev libpcre2-dev git xvfb tzdata

RUN mkdir -p /var/app
ADD . /var/app
WORKDIR /var/app

ARG EXTRA_CONF=
RUN autoreconf -fvi
RUN ./configure $EXTRA_CONF
RUN make
RUN make check
CMD xvfb-run -a ./src/tym -u ./lua/e2e.lua

FROM debian:buster AS builder

ARG FIO_VERSION=3.20

RUN apt update && apt install -y build-essential git libssl-dev libcurl4-openssl-dev
RUN git clone git://git.kernel.dk/fio.git

WORKDIR fio
RUN git checkout fio-$FIO_VERSION
RUN ./configure && make && make install

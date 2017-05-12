FROM ubuntu:14.04

ENV VERSION 1.2.8p21_0

ADD https://mathias-kettner.de/support/1.2.8p21/check-mk-raw-${VERSION}.trusty_amd64.deb /

ENTRYPOINT ls -al /

FROM ubuntu:17.04

ENV VERSION 1.2.8p21_0

ADD https://mathias-kettner.de/support/1.2.8p22/check-mk-raw-1.2.8p22_0.yakkety_amd64.deb .

ENTRYPOINT ls -al /

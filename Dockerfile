FROM ubuntu:16.04
MAINTAINER jan.szczyra@ista.com

ENV VERSION 1.2.8p21
ENV PACKAGE check-mk-raw-${VERSION}_0.xenial_amd64.deb
ENV URL https://mathias-kettner.de/support/${VERSION}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget \
      gdebi \
    && rm -rf /var/lib/apt/lists/*

RUN wget --quiet --no-check-certificate $URL/$PACKAGE && \
    dpkg -i $PACKAGE ; \
    apt-get update && \
    apt-get -f -y install

ENV SITE monitoring

RUN omd create $SITE --no-init -umonitoring -gmonitoring && \
    omd config $SITE set TMPFS off && \
    omd config $SITE set DEFAULT_GUI check_mk && \
    omd config $SITE set APACHE_TCP_ADDR 0.0.0.0 && \
    omd config $SITE set LIVESTATUS_TCP on && \
    omd config $SITE set LIVESTATUS_TCP_PORT 6557

USER monitoring

COPY ./docker-entrypoint.sh /

EXPOSE 5000 6556 6557

WORKDIR /omd/sites/$SITE

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]

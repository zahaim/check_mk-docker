FROM ubuntu:16.04
MAINTAINER jan.szczyra@ista.com

ENV VERSION 1.2.8p21
ENV PACKAGE check-mk-raw-${VERSION}_0.xenial_amd64.deb
ENV URL https://mathias-kettner.de/support/${VERSION}

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget \
      vim \
      telnet \
    && rm -rf /var/lib/apt/lists/*

RUN wget --quiet --no-check-certificate $URL/$PACKAGE && \
    dpkg -i $PACKAGE ; \
    apt-get update && \
    apt-get -f -y install

RUN dpkg -i /opt/omd/versions/${VERSION}.cre/share/check_mk/agents/check-mk-agent_${VERSION}-1_all.deb ; \
  apt-get update && \
  apt-get -f -y install

COPY ./docker-entrypoint.sh /

EXPOSE 5000 6556 6557

WORKDIR /omd/sites

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]

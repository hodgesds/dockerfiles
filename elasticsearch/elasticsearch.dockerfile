FROM centos:latest
MAINTAINER Daniel Hodges <hodges.daniel.scott@gmail.com>
LABEL Description="Elasticsearch Dockerfile" Version="2.X" OS="Centos:latest"

ADD ./startup.sh /opt/

RUN cd /opt/ && curl -O \
    "https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.3.1/elasticsearch-2.3.1.rpm"  && \
    rpm -ivh elasticsearch-2.3.1.rpm && \
    yum -y install wget && \
    wget --no-cookies --no-check-certificate \
        --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm" && \
    rpm -ivh jdk-8u66-linux-x64.rpm && \
    rm -rf *.rpm

RUN mkdir -p /usr/share/elasticsearch/config && \
    cp /etc/elasticsearch/elasticsearch.yml /usr/share/elasticsearch/config/ && \
    chown -R elasticsearch /usr/share/elasticsearch && \
    chsh -s /bin/bash elasticsearch


ENTRYPOINT su elasticsearch && /opt/startup.sh

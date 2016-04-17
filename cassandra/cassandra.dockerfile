FROM centos:latest
MAINTAINER Daniel Hodges <hodges.daniel.scott@gmail.com>
LABEL Description="Cassandra Dockerfile" DATABASE="cassandra" Version="3.5" OS="Centos:latest"

ADD ./startup.sh /opt/
RUN cd /opt/ && curl \
    http://mirrors.ocf.berkeley.edu/apache/cassandra/3.5/apache-cassandra-3.5-bin.tar.gz \
    | tar xvz && \
    yum -y install wget && \
    mv apache-cassandra* cassandra && \
    rm -rf *.tar.gz  && \
    wget --no-cookies --no-check-certificate \
        --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm" && \
    rpm -ivh jdk-8u66-linux-x64.rpm && \
    rm -rf *.rpm

RUN groupadd cassandra && useradd -g cassandra cassandra && \
    chown -R cassandra /opt/cassandra

ENTRYPOINT su cassandra && /opt/startup.sh

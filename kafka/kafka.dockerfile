FROM centos:latest
MAINTAINER Daniel Hodges <hodges.daniel.scott@gmail.com>
LABEL Description="Kafka Dockerfile" Version="3.5" OS="Centos:latest"

ADD ./startup.sh /opt/
RUN cd /opt/ && curl \
    http://mirrors.ocf.berkeley.edu/apache/kafka/0.9.0.1/kafka_2.11-0.9.0.1.tgz \
    | tar xvz && \
    yum -y install wget && \
    mv kafka* kafka && \
    rm -rf *.tar.gz  && \
    wget --no-cookies --no-check-certificate \
        --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" \
        "http://download.oracle.com/otn-pub/java/jdk/8u66-b17/jdk-8u66-linux-x64.rpm" && \
    rpm -ivh jdk-8u66-linux-x64.rpm && \
    rm -rf *.rpm

RUN groupadd kafka && useradd -g kafka kafka && \
    chown -R kafka /opt/kafka

ENTRYPOINT su kafka && /opt/startup.sh

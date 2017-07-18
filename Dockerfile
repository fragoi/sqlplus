FROM centos
MAINTAINER Fra

## Install dependencies
RUN yum update -y && \
    yum install -y net-tools libaio

## Instaclient packages
ADD ./packages /tmp

## Install packages
RUN rpm -Uvh /tmp/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm && \
    rpm -Uvh /tmp/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm

## Register libraries
RUN echo "/usr/lib/oracle/12.2/client64/lib/" > /etc/ld.so.conf.d/oracle.conf && \
    ldconfig

## Create user
RUN useradd ln

USER ln
WORKDIR /home/ln

CMD sqlplus64 $URL

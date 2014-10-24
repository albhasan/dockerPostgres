# POSTGRES
#
# VERSION 1.0
#
#
#
#
#
#
#PORT MAPPING
#SERVICE                DEFAULT         MAPPED
#ssh                    22                      48901
#Postgresql     5432            48902


FROM ubuntu:12.04
MAINTAINER Alber Sanchez


# install
RUN apt-get -qq update && apt-get install --fix-missing -y --force-yes \
        openssh-server \
        sudo \
        wget \
        nano \
        postgresql-9.1 \
        postgresql-contrib \ 
        ssh


# Set environment
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN env


# Configure users
RUN echo 'root:xxxx.xxxx.xxxx' | chpasswd
RUN echo 'postgres:xxxx.xxxx.xxxx' | chpasswd


# Configure SSH
RUN mkdir /var/run/sshd
RUN sed -i 's/22/48901/g' /etc/ssh/sshd_config
RUN echo 'StrictHostKeyChecking no' >> /etc/ssh/ssh_config


# Configure Postgres
RUN echo 'host    all    all    0.0.0.0/0    md5' >> /etc/postgresql/9.1/main/pg_hba.conf
RUN sed -i 's/5432/48902/g' /etc/postgresql/9.1/main/postgresql.conf
RUN sed -i 's/localhost/*/g' /etc/postgresql/9.1/main/postgresql.conf
RUN sed -i 's/#listen_addresses/listen_addresses/g' /etc/postgresql/9.1/main/postgresql.conf
ADD containerSetup.sh /containerSetup.sh
RUN chown root:root /containerSetup.sh
RUN chmod +x /containerSetup.sh

# Restarting services
RUN stop ssh
RUN start ssh
RUN /etc/init.d/postgresql restart


EXPOSE 48901
EXPOSE 48902


CMD    ["/usr/sbin/sshd", "-D"]

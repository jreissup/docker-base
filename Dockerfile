FROM ubuntu:focal

ARG build_date

LABEL org.label-schema.name="ubuntu" \ 
      org.label-schema.description="Ubuntu Focal base image" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.vcs-url="https://github.com/jreissup/docker-base" \
      org.label-schema.schema-version="1.0" \
      maintainer="jreissup"

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends --allow-unauthenticated \
        unzip \
        ca-certificates \
        openjdk-11-jre-headless \
        wget \
        git \
        gnupg \
        netcat \
        supervisor \
        openssh-server \
        net-tools \
        netcat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN echo 'root:jreissup' | chpasswd
RUN mkdir /var/run/sshd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
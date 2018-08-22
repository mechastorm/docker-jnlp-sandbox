FROM jenkins/jnlp-slave
MAINTAINER Shih Oon Liong <shih.liong@samsung.com>
LABEL Description="Base image for running Jenkin Jobs on" Vendor="Jenkins project" Version="0.0.0"

USER root
RUN apt-get update && apt-get -y install sudo

RUN adduser jenkins sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENTRYPOINT ["jenkins-slave"]

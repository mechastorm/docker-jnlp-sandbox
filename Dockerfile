FROM jenkins/jnlp-slave
MAINTAINER Shih Oon Liong <github@liong.ca>
LABEL Description="Base image for running Jenkin Jobs on" Vendor="Jenkins project" Version="0.0.0"

USER root
RUN apt-get update && apt-get -y install sudo

RUN adduser jenkins sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER jenkins
CMD /bin/bash

ENTRYPOINT ["jenkins-slave"]

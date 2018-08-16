FROM jenkins/jnlp-slave
MAINTAINER Shih Oon Liong <github@liong.ca>
LABEL Description="Base image for running Jenkin Jobs on" Vendor="Jenkins project" Version="0.0.0"

ENTRYPOINT ["jenkins-slave"]

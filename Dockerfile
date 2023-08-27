FROM ubuntu:latest

RUN apt-get update && \
    apt-get upgrade -y
RUN apt-get install sudo -y && apt-get install tcpdump -y
RUN addgroup --gid 1000 ubuntu && useradd -u 1000 ubuntu -g ubuntu
RUN echo "ubuntu ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
WORKDIR /home/ubuntu
USER 1000
FROM ubuntu:24.04

RUN apt-get update && \
    apt-get upgrade -y
RUN apt-get install sudo tcpdump net-tools curl gnupg ca-certificates apt-transport-https dnsutils -y
RUN curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.34/deb/Release.key | gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg \
    && chmod 644 /etc/apt/keyrings/kubernetes-apt-keyring.gpg
RUN echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.34/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list \
    && sudo chmod 644 /etc/apt/sources.list.d/kubernetes.list
RUN apt-get update && apt-get install kubectl -y

RUN addgroup --gid 5000 sysadmin && useradd -u 5000 sysadmin -g sysadmin
RUN echo "sysadmin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN apt-get install netcat-traditional -y
RUN apt-get install openssh-client -y
WORKDIR /home/sysadmin
USER 5000

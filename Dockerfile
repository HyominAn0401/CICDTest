FROM ubuntu:22.04

# 필수 패키지 설치
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    gnupg \
    software-properties-common \
    python3 \
    python3-pip \
    awscli \
    bash

# HashiCorp GPG 키 및 Packer 설치
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y packer

SHELL ["/bin/bash", "-c"]
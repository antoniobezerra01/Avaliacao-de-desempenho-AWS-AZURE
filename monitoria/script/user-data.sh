#!/bin/bash

# Atualização do sistema
apt-get update -y && apt-get upgrade -y

# Instalação do git
apt-get install git -y

# clone do repositório
git clone https://github.com/antoniobezerra01/Avaliacao-de-desempenho-AWS-AZURE.git

# Instalação do Docker
apt-get install ca-certificates curl -y
install -m 0755 -d /etc/apt/keyrings 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc 
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Instalação do docker-compose
curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Iniciando o docker
systemctl start docker
systemctl enable docker

# instalação serviços
apt-get install iperf -y
apt-get install apache2-utils -y

# Subindo containers
cd Avaliacao-de-desempenho-AWS-AZURE/monitoria/docker
docker-compose -f monitoria.yaml up -d

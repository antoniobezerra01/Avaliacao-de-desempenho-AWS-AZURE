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

# Instalação serviços
apt-get install iperf -y
apt-get install apache2-utils -y
apt-get install fio -y
apt-get install sysbench -y

# Configurando node_exporter
cd /Avaliacao-de-desempenho-AWS-AZURE/aplicacao
wget https://github.com/prometheus/node_exporter/releases/download/v1.3.1/node_exporter-1.3.1.linux-amd64.tar.gz
tar -xvf node_exporter-1.3.1.linux-amd64.tar.gz
cp /Avaliacao-de-desempenho-AWS-AZURE/aplicacao/node_exporter-1.3.1.linux-amd64/node_exporter /usr/local/bin
useradd --no-create-home --shell /bin/false node_exporter
chown node_exporter:node_exporter /usr/local/bin/node_exporter
/bin/cp /Avaliacao-de-desempenho-AWS-AZURE/aplicacao/node-exporter/etc/systemd/system/node_exporter.service /etc/systemd/system/
rm -f /Avaliacao-de-desempenho-AWS-AZURE/aplicacao/node_exporter-1.3.1.linux-amd64.tar.gz
rm -rf /Avaliacao-de-desempenho-AWS-AZURE/aplicacao/node_exporter-1.3.1.linux-amd64

# Subindo node_exporter
systemctl daemon-reload 
systemctl start node_exporter
systemctl enable node_exporter

# Subindo containers
cd /Avaliacao-de-desempenho-AWS-AZURE/aplicacao/docker
docker-compose -f aplicacao.yaml up -d

#!/bin/bash

sudo apt update
sleep 5
sudo apt install nginx -y
sudo systemctl enable nginx
sleep 5

# Kill Ngnix from runing on port:80 (I'm too lazy to rebuild frontend docker):
sudo systemctl stop nginx

# Install Docker From Docker's Online Documentation
# Add Docker's official GPG key:
echo "Installing Docker..."
sudo apt-get update
sudo apt-get -y install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sleep 5

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
sleep 5

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker
sleep 3

# DuckDNS Domain Ip Update:
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/working-with-ip-addresses.html
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")
MY_PUBLIC_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

# Domain Ip Update
echo url="https://www.duckdns.org/update?domains=manac&token=8fc8cc1b-883c-420e-91a2-cc4d7f1f4f63&ip=$MY_PUBLIC_IP" | curl -k -K -
sleep 3

# Clone services repo
echo "Cloning Repo..."
git clone https://github.com/ManasseTegGbegnohou/420-414-Epreuve-Finale-Services.git
cd 420-414-Epreuve-Finale-Services/

# Start all Docker Images
echo "Starting Dockers..."
sudo docker compose down
sleep 5
sudo docker system prune -a --volumes -f
sleep 15
sudo docker compose up -d

# See what's up with Traefik if Services not running
# docker logs traefik
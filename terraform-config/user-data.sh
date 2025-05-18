#!/bin/bash

sudo apt update
sleep 1
sudo apt install nginx -y
sudo systemctl enable nginx
sleep 3
# Kill Ngnix from runing on port:80 (Im too lazy to rebuild frontend docker)
sudo systemctl stop nginx

# Install Docker From Docker's Online Documentation
# Add Docker's official GPG key:
echo "Installing Docker..."
sudo apt-get update
sudo apt-get -y install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
sleep 3

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 
sleep 3

# Enable and start Docker service
sudo systemctl enable docker
sudo systemctl start docker
sleep 3
# Clone repo
echo "Cloning Repo..."
git clone https://github.com/ManasseTegGbegnohou/420-414-Epreuve-Finale-Services.git
cd 420-414-Epreuve-Finale-Services/

# Start all images
echo "Starting Dockers..."
sudo docker compose down
sleep 3
sudo docker system prune -a --volumes -f
sleep 15
sudo docker compose up -d

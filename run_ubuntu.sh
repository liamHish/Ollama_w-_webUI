#!/bin/bash

# Installing Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Update the package list
sudo apt-get update

# Install necessary dependencies
sudo apt-get install -y curl gnupg lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add Docker's official repository for ARM architecture
echo \
  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the package list again
sudo apt-get update

# Install Docker Engine and components
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Verify that Docker is installed correctly
sudo systemctl start docker
sudo systemctl enable docker
sudo docker run hello-world

# Run the open-webui container
sudo docker run -d --network=host -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://127.0.0.1:11434 --name open-webui --restart always ghcr.io/open-webui/open-webui:main

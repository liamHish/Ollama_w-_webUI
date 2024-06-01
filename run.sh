#!/bin/bash

# Installing Ollama
curl -fsSL https://ollama.com/install.sh | sh

# Update the package list
sudo apt-get update

# Install necessary dependencies
sudo apt-get install -y ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings

# Add Docker's Repository  <---
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker's official repository for ARM architecture
echo \
  "deb [arch=arm64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
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

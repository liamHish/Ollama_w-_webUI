#!/bin/bash

# Install Docker if it's not already installed
if ! command -v docker &> /dev/null; then
    echo "Docker could not be found, installing now..."
    apt update && \
    apt install -y docker-ce docker-ce-cli containerd.io
else
    echo "Docker is already installed."
fi

# Pull the Ollama and WebUI images from their respective Docker Hub repositories (assuming they exist)
docker pull ollamalabs/ollama:latest &> /dev/null
docker pull webui_project/webui:latest &> /dev/null

# Run both containers in detached mode simultaneously
docker run --name ollama-container -d ollamalabs/ollama:latest
docker run --name webui-container -d webui_project/webui:latest

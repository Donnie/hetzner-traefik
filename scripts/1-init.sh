#!/bin/bash

sudo apt-get update

## Add history search
echo "\"\e[A\": history-search-backward" | sudo tee -a /etc/inputrc
echo "\"\e[B\": history-search-forward" | sudo tee -a /etc/inputrc

bind -f /etc/inputrc

# Install podman if it is not already there
if ! command -v podman &> /dev/null; then
    echo "Installing podman..."
    apt-get update
    apt-get install -y podman
fi

# Display podman info
which podman
podman --version

# Install minikube only if it is not already there
if ! command -v minikube &> /dev/null; then
    echo "Installing minikube..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_arm64.deb
    sudo dpkg -i minikube_latest_arm64.deb
    rm minikube_latest_arm64.deb
fi

# Display minikube info
which minikube
minikube version

# Install kubectl only if it is not already there
if ! command -v kubectl &> /dev/null; then
    echo "Installing kubectl..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
fi

# Display kubectl info
which kubectl
kubectl version --client

# Install Helm only if it is not already there
if ! command -v helm &> /dev/null; then
    echo "Installing Helm..."
    curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
    chmod 700 get_helm.sh
    ./get_helm.sh
    rm get_helm.sh
fi

# Display helm info
which helm
helm version

# Install Caddy only if it is not already there
if ! command -v caddy &> /dev/null; then
    echo "Installing Caddy..."
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
    curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
    sudo apt update
    sudo apt install -y caddy
fi

# Display caddy info
which caddy
caddy version

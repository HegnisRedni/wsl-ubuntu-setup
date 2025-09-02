#!/bin/bash
# install-tools.sh - Installs Python, Docker, K8s (Minikube), Terraform, Ansible in Ubuntu WSL

set -e  # Exit on error

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing Python (latest via apt)..."
sudo apt install python3 python3-pip python3-venv -y
python3 --version

echo "Installing Docker..."
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER
docker --version

echo "Installing Kubernetes (Minikube + kubectl)..."
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube start --driver=docker
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install kubectl /usr/local/bin/kubectl
kubectl version --client

echo "Installing Terraform..."
sudo apt install unzip -y
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt update
sudo apt install terraform -y
terraform --version

echo "Installing Ansible..."
sudo apt install ansible -y
ansible --version

echo "All installations complete! Log out/in for Docker group changes. Run 'minikube status' to check K8s."

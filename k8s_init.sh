#!/bin/bash

echo "                                                     "
echo "██╗  ██╗ █████╗ ███████╗    ██╗███╗   ██╗██╗████████╗"
echo "██║ ██╔╝██╔══██╗██╔════╝    ██║████╗  ██║██║╚══██╔══╝"
echo "█████╔╝ ╚█████╔╝███████╗    ██║██╔██╗ ██║██║   ██║   "
echo "██╔═██╗ ██╔══██╗╚════██║    ██║██║╚██╗██║██║   ██║   "
echo "██║  ██╗╚█████╔╝███████║    ██║██║ ╚████║██║   ██║   "
echo "╚═╝  ╚═╝ ╚════╝ ╚══════╝    ╚═╝╚═╝  ╚═══╝╚═╝   ╚═╝   "


## Banner function
banner()
{
  echo "+----------------------------------------------------------------------+"
  printf " %-40s \n" "`date`"
  echo "                                         "
  printf "`tput bold` %-40s `tput sgr0`\n" "$@"
  echo "+----------------------------------------------------------------------+"
}


# Log file
LOGFILE="/var/log/k8s_init.log"

# Redirect all stdout and stderr to logfile
exec > >(tee -a $LOGFILE) 2>&1

# ANSI colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Initialize Kubernetes version variable
K8S_VERSION=""

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --version) K8S_VERSION="$2"; shift ;;
        *) echo -e "${RED}Unknown parameter passed: $1${NC}"; exit 1 ;;
    esac
    shift
done

# Check if version was provided
if [ -z "$K8S_VERSION" ]; then
    echo -e "${RED}No Kubernetes version specified. Use --version to specify the version.${NC}"
    exit 1
fi
echo ""

echo -e "${GREEN}Starting Kubernetes node setup with Kubernetes version ${K8S_VERSION}...${NC}"
echo ""

# Update and upgrade packages
banner "Updating and upgrading system packages..."
if ! apt update && apt upgrade -y; then
    echo -e "${RED}Failed to update and upgrade system packages.${NC}" >&2
    exit 1
fi
echo ""

# Install necessary packages
banner "Installing necessary packages..."
if ! apt-get install -y apt-transport-https ca-certificates curl software-properties-common gnupg2; then
    echo -e "${RED}Failed to install necessary packages.${NC}" >&2
    exit 1
fi
echo ""

# Add Kubernetes signing key
banner "Creating the Keyrings Directory for K8s ${K8S_VERSION}..."
if ! mkdir -p -m 755 /etc/apt/keyrings; then
        echo -e "${RED}Failed to create Keyrings Directory.${NC}" >&2
        exit 1
else
    echo "OK"        
fi
echo ""

banner "Adding Kubernetes signing key for version ${K8S_VERSION}..."
if ! curl -fsSL https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/Release.key | gpg --dearmor --yes -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg; then
    echo -e "${RED}Failed to download and install Kubernetes signing key for version ${K8S_VERSION}.${NC}" >&2
    exit 1
else
    echo "OK"
fi
echo ""

# Add Kubernetes apt repository
banner "Adding Kubernetes APT repository for version ${K8S_VERSION}..."
if ! echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/${K8S_VERSION}/deb/ /" | tee /etc/apt/sources.list.d/kubernetes.list; then
    echo -e "${RED}Failed to add Kubernetes APT repository for version ${K8S_VERSION}.${NC}" >&2
    exit 1
else
    echo "OK"
fi
echo ""

# Disable swap
banner "Disabling swap..."
sed -i '/ swap / s/^/#/' /etc/fstab
if ! swapoff -a; then
    echo -e "${RED}Failed to disable swap.${NC}" >&2
    exit 1
else
    echo "OK"
fi
echo ""

# Load necessary kernel modules
banner "Configuring kernel modules..."
cat <<EOF | tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
if ! modprobe overlay || ! modprobe br_netfilter; then
    echo -e "${RED}Failed to load kernel modules.${NC}" >&2
    exit 1
fi
echo ""

banner "Configuring kernel modules for containerd..."
cat <<EOF | tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
echo ""

# Configure sysctl
banner "Configuring & Applying sysctl for Kubernetes..."
cat <<EOF | tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF
if ! sysctl --system; then
    echo -e "${RED}Failed to apply sysctl settings.${NC}" >&2
    exit 1
fi
echo ""

# Install Containerd
banner "Installing Containerd..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
if ! apt update || ! apt install containerd.io -y; then
    echo -e "${RED}Failed to install containerd.${NC}" >&2
    exit 1
fi
echo ""

# Configure containerd
banner "Configuring containerd..."
mkdir -p /etc/containerd
if ! containerd config default > /etc/containerd/config.toml; then
    echo -e "${RED}Failed to configure containerd.${NC}" >&2
    exit 1
else
    echo "OK"
fi
echo ""

# Restart and enable containerd
banner "Restart Containerd..."
if ! systemctl restart containerd; then
    echo -e "${RED}Failed to restart containerd.${NC}" >&2
    exit 1
else
    echo "OK"
fi
echo ""

banner "Enable Containerd..."
if ! systemctl enable containerd; then
    echo -e "${RED}Failed to enable containerd service.${NC}" >&2
    exit 1
else
    echo "OK"
fi
echo ""

banner "Status for Containerd"
if ! systemctl status containerd; then
    echo -e "${RED}Failed to enable containerd service.${NC}" >&2
    exit 1
fi
echo ""

# Install kubelet, kubeadm, and kubectl
banner "Installing kubelet, kubeadm, and kubectl..."
if ! apt install kubelet kubeadm kubectl -y; then
    echo -e "${RED}Failed to install Kubernetes components.${NC}" >&2
    exit 1
fi
echo ""

echo -e "${GREEN}Kubernetes node setup completed successfully with version ${K8S_VERSION}.${NC}"
echo ""
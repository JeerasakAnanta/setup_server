#!/bin/bash
# Ubuntu server setup script
# Author: jeerasak ananta 
# Date: 2025-09-01

# Update and upgrade the system
echo "Updating the system..."
sudo apt update && sudo apt upgrade -y

# Install essential packages
echo "Installing essential packages..."
sudo apt install -y \
  curl \
  wget \
  git \
  vim \
  ufw \
  net-tools \
  build-essential \
  software-properties-common

# Set the hostname (customize as needed)
read -p "Enter the hostname for the server: " HOSTNAME
echo "Setting hostname to $HOSTNAME..."
sudo hostnamectl set-hostname $HOSTNAME

# Enable Firewall
echo "Setting Up Firewall..."
sudo ufw allow OpenSSH
sudo ufw enable
sudo ufw status

# Install and enable fail2ban for security
echo "Installing fail2ban..."
sudo apt install -y fail2ban
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Install a basic web server (optional, uncomment if needed)
# echo "Installing Nginx..."
# sudo apt install -y nginx
# sudo systemctl enable nginx
# sudo systemctl start nginx

# Install Docker (optional, uncomment if needed)
# echo "Installing Docker..."
# sudo apt install -y docker.io
# sudo systemctl enable docker
# sudo systemctl start docker

# Print completed setup message
echo "Ubuntu server setup is complete!"
echo "Reboot your server if required."

exit 0
#!/bin/bash

# before_install.sh - Executed before the application is installed
# This script prepares the environment for the new deployment

echo "Starting before_install phase..."

# Stop any existing services
echo "Stopping existing services..."
sudo systemctl stop ci-cd-demo-app || true
sudo pkill -f "python.*app.py" || true

# Clean up previous installation
echo "Cleaning up previous installation..."
sudo rm -rf /home/ec2-user/ci-cd-demo-app.bak
if [ -d "/home/ec2-user/ci-cd-demo-app" ]; then
    sudo mv /home/ec2-user/ci-cd-demo-app /home/ec2-user/ci-cd-demo-app.bak
fi

# Update system packages
echo "Updating system packages..."
sudo yum update -y

# Install Python and pip if not present
echo "Installing Python and dependencies..."
sudo yum install -y python3 python3-pip

# Install system dependencies
sudo yum install -y gcc python3-devel

echo "before_install phase completed successfully"
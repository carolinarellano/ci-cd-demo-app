#!/bin/bash

# after_install.sh - Executed after the application is installed
# This script sets up the application environment

echo "Starting after_install phase..."

# Set working directory
cd /home/ec2-user/ci-cd-demo-app

# Set proper ownership
echo "Setting file permissions..."
sudo chown -R ec2-user:ec2-user /home/ec2-user/ci-cd-demo-app
chmod +x scripts/*.sh

# Install Python dependencies
echo "Installing Python dependencies..."
sudo pip3 install -r requirements.txt

# Create application log directory
echo "Creating log directory..."
sudo mkdir -p /var/log/ci-cd-demo-app
sudo chown ec2-user:ec2-user /var/log/ci-cd-demo-app

# Create systemd service file
echo "Creating systemd service..."
sudo tee /etc/systemd/system/ci-cd-demo-app.service > /dev/null <<EOF
[Unit]
Description=CI/CD Demo App
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user/ci-cd-demo-app
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=3
Environment=PORT=5000
Environment=ENVIRONMENT=production

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd daemon
sudo systemctl daemon-reload
sudo systemctl enable ci-cd-demo-app

echo "after_install phase completed successfully"
#!/bin/bash

# start_server.sh - Starts the application service
# This script starts the CI/CD demo application

echo "Starting start_server phase..."

# Set working directory
cd /home/ec2-user/ci-cd-demo-app

# Set environment variables
export PORT=5000
export ENVIRONMENT=production

# Start the application using systemd
echo "Starting CI/CD Demo App service..."
sudo systemctl start ci-cd-demo-app

# Wait a moment for the service to start
sleep 5

# Check if service is running
if sudo systemctl is-active --quiet ci-cd-demo-app; then
    echo "CI/CD Demo App service started successfully"
    echo "Service status:"
    sudo systemctl status ci-cd-demo-app --no-pager
else
    echo "Failed to start CI/CD Demo App service"
    echo "Service status:"
    sudo systemctl status ci-cd-demo-app --no-pager
    echo "Service logs:"
    sudo journalctl -u ci-cd-demo-app --no-pager -n 20
    exit 1
fi

echo "start_server phase completed successfully"
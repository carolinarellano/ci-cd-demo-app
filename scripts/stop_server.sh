#!/bin/bash

# stop_server.sh - Stops the application service
# This script stops the CI/CD demo application

echo "Starting stop_server phase..."

# Stop the application using systemd
echo "Stopping CI/CD Demo App service..."
sudo systemctl stop ci-cd-demo-app || true

# Kill any remaining processes
echo "Killing any remaining application processes..."
sudo pkill -f "python.*app.py" || true

# Wait a moment for processes to stop
sleep 3

# Verify service is stopped
if sudo systemctl is-active --quiet ci-cd-demo-app; then
    echo "Warning: Service is still running"
    sudo systemctl status ci-cd-demo-app --no-pager
else
    echo "✓ CI/CD Demo App service stopped successfully"
fi

echo "stop_server phase completed successfully"
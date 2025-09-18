#!/bin/bash

# validate_service.sh - Validates that the application is running correctly
# This script performs health checks on the deployed application

echo "Starting validate_service phase..."

# Wait for the application to be fully ready
echo "Waiting for application to be ready..."
sleep 10

# Define the application URL
APP_URL="http://localhost:5000"

# Function to test an endpoint
test_endpoint() {
    local endpoint=$1
    local expected_status=$2
    
    echo "Testing endpoint: $endpoint"
    
    # Make HTTP request and capture response
    response=$(curl -s -w "%{http_code}" -o /tmp/response.txt "$APP_URL$endpoint")
    http_code="${response: -3}"
    
    if [ "$http_code" = "$expected_status" ]; then
        echo "✓ $endpoint returned status $http_code (expected $expected_status)"
        return 0
    else
        echo "✗ $endpoint returned status $http_code (expected $expected_status)"
        echo "Response body:"
        cat /tmp/response.txt
        return 1
    fi
}

# Test application endpoints
echo "Performing health checks..."

# Test home endpoint
test_endpoint "/" "200"
home_test=$?

# Test health endpoint
test_endpoint "/health" "200"
health_test=$?

# Test status endpoint
test_endpoint "/api/status" "200"
status_test=$?

# Test 404 endpoint
test_endpoint "/nonexistent" "404"
not_found_test=$?

# Check if all tests passed
if [ $home_test -eq 0 ] && [ $health_test -eq 0 ] && [ $status_test -eq 0 ] && [ $not_found_test -eq 0 ]; then
    echo "✓ All health checks passed successfully"
    echo "Application is running and responding correctly"
    
    # Show application logs
    echo "Recent application logs:"
    sudo journalctl -u ci-cd-demo-app --no-pager -n 10
    
    echo "validate_service phase completed successfully"
    exit 0
else
    echo "✗ Some health checks failed"
    echo "Application may not be working correctly"
    
    # Show detailed logs for debugging
    echo "Application logs:"
    sudo journalctl -u ci-cd-demo-app --no-pager -n 20
    
    exit 1
fi
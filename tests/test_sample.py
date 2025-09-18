#!/usr/bin/env python3
"""
Test suite for the CI/CD demo application.
"""

import pytest
import json
from app import app

@pytest.fixture
def client():
    """Create a test client for the Flask application."""
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client

def test_home_endpoint(client):
    """Test the home endpoint returns correct response."""
    response = client.get('/')
    assert response.status_code == 200
    
    data = json.loads(response.data)
    assert data['message'] == 'Welcome to CI/CD Demo App!'
    assert data['status'] == 'healthy'
    assert data['version'] == '1.0.0'

def test_health_endpoint(client):
    """Test the health check endpoint."""
    response = client.get('/health')
    assert response.status_code == 200
    
    data = json.loads(response.data)
    assert data['status'] == 'healthy'
    assert data['service'] == 'ci-cd-demo-app'

def test_status_endpoint(client):
    """Test the status endpoint."""
    response = client.get('/api/status')
    assert response.status_code == 200
    
    data = json.loads(response.data)
    assert data['status'] == 'running'
    assert 'environment' in data
    assert 'port' in data

def test_invalid_endpoint(client):
    """Test that invalid endpoints return 404."""
    response = client.get('/invalid')
    assert response.status_code == 404
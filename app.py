#!/usr/bin/env python3
"""
Simple Flask web application for CI/CD demo.
"""

from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/')
def home():
    """Home endpoint that returns a welcome message."""
    return jsonify({
        'message': 'Welcome to CI/CD Demo App!',
        'status': 'healthy',
        'version': '1.0.0'
    })

@app.route('/health')
def health():
    """Health check endpoint."""
    return jsonify({
        'status': 'healthy',
        'service': 'ci-cd-demo-app'
    })

@app.route('/api/status')
def status():
    """Status endpoint with environment information."""
    return jsonify({
        'status': 'running',
        'environment': os.environ.get('ENVIRONMENT', 'development'),
        'port': os.environ.get('PORT', '5000')
    })

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 5000))
    debug = os.environ.get('DEBUG', 'False').lower() == 'true'
    app.run(host='0.0.0.0', port=port, debug=debug)
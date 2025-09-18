#!/bin/bash 
set -e 
curl -fsS http://localhost:8080/ | grep "Hello CI/CD"
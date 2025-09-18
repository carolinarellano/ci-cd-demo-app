#!/bin/bash 
set -e 
systemctl stop demo.service || true 
mkdir -p /opt/app 
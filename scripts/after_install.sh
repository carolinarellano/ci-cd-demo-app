#!/bin/bash 
set -e 
cd /opt/app 
python3 -m pip install --upgrade pip 
pip3 install -r requirements.txt 
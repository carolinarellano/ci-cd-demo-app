#!/bin/bash 
set -e 
 
cat >/etc/systemd/system/demo.service <<'EOF' 
[Unit] 
Description=Demo Flask App 
After=network.target 
 
[Service] 
WorkingDirectory=/opt/app 
ExecStart=/usr/bin/python3 /opt/app/app.py 
Restart=always 
User=root 
 
[Install] 
WantedBy=multi-user.target 
EOF 
 
systemctl daemon-reload 
systemctl enable demo.service 
systemctl restart demo.service
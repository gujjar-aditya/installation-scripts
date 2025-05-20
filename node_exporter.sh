#! /bin/bash

set -e

NODE_EXPORTER_VERSION="1.6.1"

# Create user
sudo useradd --no-create-home --shell /bin/false node_exporter || true

# Download Node Exporter
cd /tmp
wget https://github.com/prometheus/node_exporter/releases/download/v${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
tar -xzf node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64.tar.gz
cd node_exporter-${NODE_EXPORTER_VERSION}.linux-amd64

# Install binary
sudo cp node_exporter /usr/local/bin/
sudo chown node_exporter:node_exporter /usr/local/bin/node_exporter

# Create systemd service
sudo tee /etc/systemd/system/node_exporter.service > /dev/null <<EOF
[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target
EOF

# Start and enable Node Exporter
sudo systemctl daemon-reload
sudo systemctl enable --now node_exporter

echo "Node Exporter installed and running at http://<your-server-ip>:9100"

# Step 1: Update and install dependencies
sudo apt update
sudo apt install -y software-properties-common curl gnupg2

# Step 2: Add Grafana GPG key (secure method)
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://packages.grafana.com/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/grafana.gpg

# Step 3: Add Grafana APT repository
echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://packages.grafana.com/oss/deb stable main" | sudo tee /etc/apt/sources.list.d/grafana.list

# Step 4: Update and install Grafana
sudo apt update
sudo apt install -y grafana

# Step 5: Enable and start Grafana service
sudo systemctl enable --now grafana-server

# Step 6: Check status
sudo systemctl status grafana-server

# Step 7: Access UI
echo "Visit http://<your-server-ip>:3000 to log in with admin / admin"

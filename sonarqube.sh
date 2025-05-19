#!/bin/bash

# Exit on error
set -e

echo "1. Installing JDK 17..."
sudo yum install -y java-17-amazon-corretto-devel

echo "2. Creating sonarqube user..."
sudo useradd sonarqube || true
echo "Set a password manually using: sudo passwd sonarqube"

echo "3. Adding sonarqube user to sudoers (wheel group)..."
sudo usermod -aG wheel sonarqube

echo "4. Downloading SonarQube 10.1.0.73491..."
cd /tmp
wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-10.1.0.73491.zip

echo "5. Moving ZIP to /opt..."
sudo mv sonarqube-10.1.0.73491.zip /opt/
cd /opt

echo "6. Unzipping..."
sudo unzip -q sonarqube-10.1.0.73491.zip
sudo rm -f sonarqube-10.1.0.73491.zip

echo "7. Changing ownership..."
sudo chown -R sonarqube:sonarqube sonarqube-10.1.0.73491

echo "8. Starting SonarQube..."
sudo -u sonarqube bash -c "cd /opt/sonarqube-10.1.0.73491/bin/linux-x86-64 && ./sonar.sh start"

echo "9. Checking SonarQube status..."
sudo -u sonarqube bash -c "cd /opt/sonarqube-10.1.0.73491/bin/linux-x86-64 && ./sonar.sh status"

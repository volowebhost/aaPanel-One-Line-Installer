#!/bin/bash

# One-line installation script for aaPanel
echo "Detecting OS and installing aaPanel..."

# Detect OS and set package manager
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        centos|rhel|almalinux|rocky) PKG_MGR="yum -y";;
        ubuntu|debian) PKG_MGR="apt -y";;
        *) echo "Unsupported OS"; exit 1;;
    esac
else
    echo "OS detection failed. Exiting."
    exit 1
fi

# Update system and install dependencies
$PKG_MGR update && $PKG_MGR install curl wget sudo

# Download and install aaPanel
URL="https://www.aapanel.com/script/install_7.0_en.sh"
if command -v curl >/dev/null 2>&1; then
    curl -ksSO "$URL"
else
    wget --no-check-certificate -O install_7.0_en.sh "$URL"
fi

echo "y" | bash install_7.0_en.sh aapanel

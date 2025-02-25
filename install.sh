#!/bin/bash

echo "Detecting OS and installing aaPanel..."

# Detect OS
if [ -f /etc/os-release ]; then
    . /etc/os-release
    case "$ID" in
        centos|rhel|almalinux|rocky) 
            PKG_UPDATE="/usr/bin/yum update -y"
            PKG_INSTALL="/usr/bin/yum install -y"
            ;;
        ubuntu|debian) 
            PKG_UPDATE="/usr/bin/apt update -y"
            PKG_INSTALL="/usr/bin/apt install -y"
            ;;
        *) 
            echo "Unsupported OS"
            exit 1
            ;;
    esac
else
    echo "OS detection failed. Exiting."
    exit 1
fi

# Ensure package manager exists
if ! command -v yum >/dev/null 2>&1 && ! command -v apt >/dev/null 2>&1; then
    echo "No compatible package manager found. Exiting."
    exit 1
fi

# Update system and install dependencies
eval "$PKG_UPDATE"
eval "$PKG_INSTALL curl wget sudo"

# Download and install aaPanel
URL="https://www.aapanel.com/script/install_7.0_en.sh"
if command -v curl >/dev/null 2>&1; then
    curl -ksSO "$URL"
else
    wget --no-check-certificate -O install_7.0_en.sh "$URL"
fi

# Execute the installer
echo "y" | bash install_7.0_en.sh aapanel

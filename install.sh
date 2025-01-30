#!/bin/bash

# One-line installation script for aaPanel
echo "Detecting OS and installing aaPanel..." && (source /etc/os-release && case "$ID" in centos|rhel|almalinux|rocky) PKG_MGR=yum;; ubuntu|debian) PKG_MGR=apt;; *) echo "Unsupported OS" && exit 1;; esac) && $PKG_MGR update -y && $PKG_MGR install -y curl wget sudo && URL="https://www.aapanel.com/script/install_7.0_en.sh" && (command -v curl >/dev/null 2>&1 && curl -ksSO "$URL" || wget --no-check-certificate -O install_7.0_en.sh "$URL") && echo "y" | bash install_7.0_en.sh aapanel

#!/bin/sh

# Check if running as root
if [ "$(id -u)" -eq 0 ]; then
    echo "Error: Please run this script as a normal user (without sudo)"
    echo "The script will prompt for your password when needed"
    exit 1
fi

# Enable exit on error after root check
set -e

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    else
        echo "unknown"
    fi
}

DISTRO=$(detect_distro)
echo "Detected distribution: $DISTRO"
echo

# Check if running on Pop!_OS
if [ "$DISTRO" != "pop" ]; then
    echo "Error: This script is designed specifically for Pop!_OS"
    echo "Detected distribution: $DISTRO"
    echo
    echo "This script will only run on Pop!_OS to ensure proper NVIDIA driver installation"
    exit 1
fi

sudo apt install -y system76-driver-nvidia
sudo apt install -y nvidia-cuda-toolkit
nvcc -V

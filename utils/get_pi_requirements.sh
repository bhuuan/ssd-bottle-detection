#!/bin/bash

# Update package list and upgrade all packages
sudo apt-get update
sudo apt-get -y upgrade

# Get packages required for OpenCV
sudo apt-get -y install libjpeg-dev libtiff-dev libpng-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install qt5-default
sudo apt-get -y install libatlas-base-dev

# Install OpenCV (older version due to compatibility issues)
pip3 install opencv-python==3.4.11.41

# Get Python version
version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')

# Function to install TensorFlow Lite Runtime
install_tflite_runtime() {
    local version=$1
    local url_base="https://github.com/google-coral/pycoral/releases/download/v2.0.0"
    if [ "$version" == "3.5" ]; then
        url_base="https://github.com/google-coral/pycoral/releases/download/release-frogfish"
    fi
    pip3 install "${url_base}/tflite_runtime-2.5.0.post1-cp${version}-cp${version}m-linux_armv7l.whl"
}

# Install TensorFlow Lite Runtime based on Python version
case $version in
    "3.9"|"3.8"|"3.7"|"3.6"|"3.5")
        install_tflite_runtime $version
        ;;
    *)
        echo "Unsupported Python version: $version"
        ;;
esac

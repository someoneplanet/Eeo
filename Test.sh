#!/bin/bash

# Update and upgrade Termux packages
echo "Updating and upgrading Termux packages..."
pkg update && pkg upgrade -y

# Install necessary Termux packages
echo "Installing Termux dependencies..."
pkg install -y proot-distro x11-repo

# Install Debian using proot-distro
echo "Installing Debian distribution..."
proot-distro install debian

# Log into Debian and install necessary software
echo "Setting up Debian with required packages..."
proot-distro login debian <<EOF
    echo "Updating and upgrading Debian..."
    apt update && apt upgrade -y

    echo "Installing software and tools..."
    apt install -y curl wget git nano vim unzip zip htop screen tmux neofetch lynx w3m firefox-esr chromium xorg x11-utils x11-apps xfce4 xfce4-goodies openssh-client openssh-server net-tools nmap traceroute build-essential gcc g++ make python3 python3-pip ffmpeg vlc gimp rsync rar unrar p7zip-full tree synaptic apt-file ncdu gparted glances tigervnc xrdp libreoffice evince

    echo "Cleaning up unnecessary packages..."
    apt autoremove -y && apt autoclean -y

    echo "Updating apt-file cache..."
    apt-file update

    echo "Debian setup complete! To start the VNC server, use:"
    echo "vncserver :1"
EOF

# Completion message
echo "Setup complete! Log into Debian with 'proot-distro login debian' and start the VNC server with 'vncserver :1'. Connect to the server using 'localhost:1'."
 

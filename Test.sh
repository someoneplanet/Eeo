#!/bin/bash

# Update and upgrade Termux packages
echo "Updating and upgrading Termux..."
pkg update && pkg upgrade -y

# Install necessary Termux packages
echo "Installing Termux dependencies..."
pkg install -y proot-distro x11-repo

# Install Debian using proot-distro
echo "Installing Debian distribution..."
proot-distro install debian

# Log into Debian and install necessary software
echo "Setting up Debian with all required packages..."
proot-distro login debian <<EOF
    echo "Updating and upgrading Debian..."
    apt update && apt upgrade -y

    echo "Installing software and tools..."
    apt install -y curl wget git nano vim unzip zip htop screen tmux neofetch lynx w3m firefox-esr chromium xorg x11-utils x11-apps xfce4 xfce4-goodies openssh-client openssh-server net-tools nmap traceroute build-essential gcc g++ make python3 python3-pip ffmpeg vlc gimp rsync rar unrar p7zip-full tree synaptic apt-file ncdu gparted glances tigervnc-server xrdp libreoffice evince

    echo "Cleaning up unnecessary packages..."
    apt autoremove -y && apt autoclean -y

    echo "Updating apt-file cache..."
    apt-file update

    echo "Configuring VNC server..."
    mkdir -p ~/.vnc
    echo '#!/bin/bash' > ~/.vnc/xstartup
    echo 'startxfce4 &' >> ~/.vnc/xstartup
    chmod +x ~/.vnc/xstartup
    tightvncserver :1

    echo "Debian setup complete! You can log in and start the VNC server using:"
    echo "proot-distro login debian"
    echo "tightvncserver :1"
EOF

# Completion message
echo "Setup complete! Use a VNC client to connect to 'use a vnc like realvnc or something to connect to localhost:1 I think it's that?'."

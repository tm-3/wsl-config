# Copy Files

if (( $EUID != 0 )); then

    sudo usr/local/bin/update.sh
    exit
fi

# Proxy - Prompt

# Run Apt Update/Upgrade

tm-update

# Configure Environment
echo "set bell-style none" >> /etc/inputrc

# Install Basic Linux Packages

# Install NVM


# Install Latest Node

# Prompt for additional versions



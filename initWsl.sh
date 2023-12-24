#!/bin/bash -i

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Copy Files

read -N1 -p 'This will copy all scripts into /usr/local/bin/wslDev and make them executable. Would you like to proceed? (y/N) ' COPY_SCRIPTS
echo

if [ $COPY_SCRIPTS = "y" ] 
then
    sudo mkdir -p /usr/local/bin/wslDev
    sudo cp $DIR/*.sh /usr/local/bin/wslDev
    sudo chmod +x /usr/local/bin/wslDev/*.sh
else 
    exit
fi

# PATH

read -N1 -p 'Would you like to include /usr/local/bin/wslDev in your path? (y/N) ' INCLUDE_IN_PATH
echo

if [ $INCLUDE_IN_PATH = "y" ] 
then 

    sudo echo "export PATH=\$PATH:/usr/local/bin/wslDev" >> $HOME/.profile     
fi

source ~/.profile

# Proxy - Prompt 

read -N1 -p 'Would you like to set up a proxy? (y/N) ' PROXY_CHOICE
echo
if [ $PROXY_CHOICE = "y" ]
 then
    read -p 'Enter your proxy address: ' PROXY_ADRESS
    echo "This did nothing. I have not set this up yet."
fi

# Run Apt Update/Upgrade

read -N1 -p 'Would you like to update linux? (y/N) ' UPDATE_LINUX
echo

if  [ $UPDATE_LINUX = "y" ]
then 
    sudo /usr/local/bin/wslDev/update.sh
fi

# Configure Environment

# I am not giving you a choice here. The bell is dumb.

echo -e "set bell-style none" >> $HOME/.inputrc

# Not sure this is necessary, but on the DEBIAN wsl distro, nano doesn't show color highlighting.

find /usr/share/nano/ -iname "*.nanorc" -exec echo include {} \; >> $HOME/.nanorc
# Install Basic Linux Packages

sudo apt install git libc6 libstdc++6 python2-minimal ca-certificates tar curl wget

# Setup cURL and wget to ignore things they shouldn't ignore
# I should solve this someday 
echo "check_certificate = off" >> $HOME/.wgetrc
echo "insecure" >> $HOME/.curlrc
# Install NVM

# wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
# chmod 777 $HOME/.nvm 

# source ~/.bashrc

# nvm install --lts
# npm config set strict-ssl false


# git config

echo
echo "git configuration"

git config --global --replace-all http.sslverify false

read -p "Name: " NAME
read -p "Email: " EMAIL

git config --global --replace-all user.name "$NAME"
git config --global --replace-all user.email "$EMAIL"


# NPM Global Packages 

npm install -g @microsoft/rush eslint esm generator-code http-server ts-node typescript yo 


source ~/.bashrc
source ~/.profile

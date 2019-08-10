sudo apt-get update
sudo apt-get upgrade

sudo apt install git libc6 libstdc++6 python-minimal ca-certificates tar curl wget


# I should solve this someday 
echo "check_certificate = off" >> $HOME/.wgetrc
echo insecure >> $HOME/.curlrc
git config --global http.sslVerify false


# Why is this ever on by default? What is wrong with people?
sudo echo "set bell-style none" >> /etc/inputrc

# Install NVM
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash


nvm install latest


npm config set strict-ssl false
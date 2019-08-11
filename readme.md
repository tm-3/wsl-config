# WSL Config

## Description 

I am not highly skilled with linux, but I definitely prefer using it to other operating systems. WSL gives me a nice playground so that I can work and not worry about messing up my main computer. That being said, I tend to screw up my WSL instance frequently and I needed a way to start from a good configuration.  

This is my basic setup for configuring WSL on Windows 10. It contains all of the scripts and configuration settings I use when working on a new machine or reinstalling WSL.

I have not thoroughly tested this, but it works on `Ubuntu` and `Debian` WSL distros.

## Functions

* Updates all packages
* Disables the bell when you make a keyboard mistake
* Installs these packages:
  * git 
  * libc6 
  * libstdc++6 
  * python-minimal 
  * ca-certificates 
  * tar 
  * curl 
  * wget
* Configures wget to ignore SSL
* Configures cURL to ignore SSL
* Installs NVM
* Installs the latest LTS version of `nodejs`
* Configures NPM to ignore SSL


## Installation

Clone this repo into a location of your choice and run the `initWsl.sh` script. You will be prompted for some information along the way.

## Scripts

Script|Purpose
--|--
`initWSL.sh`|Initial setup of the WSL instance. It copies all necessary scripts to `/usr/local/bin/wslDev`. 
`update.sh`|Responsible for updating all of the packages in the WSL instance. Cleans/Purges old packages.

 ## TODO

 * Separate linux package out to another script
 * Separate global NPM package install to another script
 * Proxy Configuration
 * Fix the SSL configuration
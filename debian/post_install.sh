#!/bin/bash

## Post Install Debian
## version: 10.2


# Update
sudo apt -y update && sudo apt -y upgrade

# Base
sudo apt -y install curl nano wget git build-essential

# Ufw
sudo apt install ufw && sudo ufw enable


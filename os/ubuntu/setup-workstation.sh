
cd ~/Downloads
###############################
# Update package repositories #
###############################
sudo apt-get update


####################################
# Install package management tools #
####################################

#################
# Install utils #
#################
sudo apt install -y curl

sudo apt-get install -y --no-install-recommends make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

sudo apt-get install -y htop

## Flameshot (replace for PrintScreen)
sudo apt install -y flameshot
echo "[Flameshot - Optional] Setup the screenshot keybind to PrintScr: https://flameshot.org/docs/guide/key-bindings/#on-ubuntu-and-other-gnome-based-distros"
#####################
# Install dev tools #
#####################

## Install git
sudo apt install -y git

## Install Github CLI
(type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
	&& sudo apt update \
	&& sudo apt install gh -y

## Post-setup for SSH keys
sudo chmod 700 -R ~/.ssh
sudo chmod 600 -R ~/.ssh/*
sudo chown $USER ~/.ssh/known_hosts
sudo chmod go-w ~/.ssh/config


## Install terminator
# https://github.com/gnome-terminator/terminator/blob/master/INSTALL.md

sudo add-apt-repository ppa:mattrose/terminator -y
sudo apt-get update
sudo apt install terminator -y

## Install zsh and oh-my-zsh

### Install zsh
### https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
sudo apt install zsh -y

### Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

## Install brew
export NONINTERACTIVE=1 \ 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo >> /home/caue/.bashrc
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/caue/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

### Install libs required by brew
brew install gcc

## Install VS Code
# TODO: automate install from https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
# sudo dpkg -i code_1.105.1-1760482543_amd64.deb

## [DEVOPS]
### Install docker
# https://docs.docker.com/engine/install/ubuntu/

# Clean up old installed docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Post install setup
# https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

### AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

## Helm
brew install helm
brew install helm-docs

### K8s
brew install kubectx
brew install k9s

## [Python]

### Install pyenv
brew install pyenv
brew install pyenv-virtualenv

### Install pipx
brew install pipx
pipx ensurepath

## [NODE]
brew install nvm
brew install yarn

## [JAVA]
### Install sdkman
curl -s "https://get.sdkman.io" | bash

## [RUST]
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile default

## [GO]
# TODO: Automate golang download: https://go.dev/dl/
#curl "https://go.dev/dl/go1.25.4.linux-amd64.tar.gz" -o "golang.tar.gz"
#sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf golang.tar.gz

## DATABASES
## dbeaver
sudo snap install dbeaver-ce

####################
# Install AI tools #
####################
snap install chatgpt-desktop

####################
#   Install apps   #
####################
snap install spotify
snap install notion-snap-reborn

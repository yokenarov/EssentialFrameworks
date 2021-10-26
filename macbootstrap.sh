#!/usr/bin/env bash
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
NC='\033[0m'
#Check if you have the CommandLineTools.
if [[ -d "/Library/Developer/CommandLineTools" ]]
then
echo -e "${GREEN}CommandLineTools are already installed on this machine.${NC}"
else
#Install them if you don't.
echo -e "${YELLOW}Installing X-Code Command Line Tools${NC}"
xcode-select --install
fi

#Check if you alread have such a directory.
if [[ -a "/Users/jordankenarov/.dotfiles" ]]
then
echo -e "${GREEN}You already have the essential files from the repository.${NC}"
else
#Install it if you don't.
echo -e "${YELLOW}Cloning remote repository with essential files...${NC}"
git clone https://github.com/yokenarov/Essentials.git ~/.dotfiles
fi

#Check if you already have a .zshrc file.
if [[ -a "/Users/$USER/.zshrc" ]]
then
echo -e "${RED}You already a .zshrc file. Should I replace it? (y/n)${NC}"
fi
#Ask if you want the current .zshrc file to be removed.
read SHOULDREMOVEZSHRC
if [[ $SHOULDREMOVEZSHRC == *"y"* ]]
then
echo -e "${YELLOW}Removing old .zshrc file.${NC}"
rm -i ~/.zshrc
echo -e "${YELLOW}Adding new .zshrc file.${NC}"
ln -s ~/.dotfiles/.dotfiles/.zshrc ~/.zshrc
echo -e "${GREEN}New .zshrc file has been replaced.${NC}"
else
ln -s ~/.dotfiles/.dotfiles/.zshrc ~/.zshrc
echo -e "${GREEN}A new .zshrc file has been created.${NC}"
fi

echo -e "${GREEN}Syncing and linking original dot files from the repository and creating new ones for your OS.${NC}"
#Create a symlink between the original file located in the repository and the .zhsrc file in your home directory.
echo -e "${GREEN}Adding cmt command to bash...${NC}"
ln -s ~/.dotfiles/.dotfiles/cmt.sh /usr/local/bin/cmt.sh
echo -e "${GREEN}Adding opn command to bash...${NC}"
ln -s ~/.dotfiles/.dotfiles/opn.sh /usr/local/bin/opn.sh

#Check if you have Homebrew installed.
if [[ -d "/usr/local/Homebrew/bin" ]]
then
echo -e "${GREEN}You already have Homebrew installed.${NC}"
else
echo -e "${YELLOW}Installing Homebrew...${NC}"
#Install it if you don't.
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#Bundle the neccessary repos and casks u need.
echo "Installing brew repos from the BrewFile."
brew bundle --file ~/.dotfiles/.dotfiles/BrewFile
fi
sudo gem install cocoapods
echo -e "${GREEN}Successfuly installed all the required tools and configurations.${NC}"

#!/usr/bin/env bash
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
RED='\033[1;31m'
CYAN='\033[0;36m'
NC='\033[0m'
git status


echo -e "${RED}Should I stage the changes? (y/n)${NC}"
read SHOULDSTAGE
if [[ $SHOULDSTAGE == *"y"* ]]
then
git add .
git status
else
echo -e "${RED}Exiting...${NC}"
exit 0
fi

echo -e "${CYAN}What's your commit message?${NC}"
read MESSAGE
git commit -m"${MESSAGE}"

echo -e "${YELLOW}Do you want to push to remote repository? (y/n)${NC}"
read MESSAGE_1
if [[ $MESSAGE_1 == *"y"* ]]
then
echo -e "${GREEN}Pushing to remote${NC}"
git push
echo -e "${GREEN}DONE!${NC}"
else
echo -e "${ORANGE}Changes haven't been pushed to repository.${NC}"
fi 

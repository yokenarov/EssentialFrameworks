#!/usr/bin/env bash
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
HASFINISHEDADDINGPROJECT=$false
echo -e "${YELLOW}What should your new workspace be called?${NC}"
read WORKSPACENAME
echo -e "${GREEN}Creating workspace ${WORKSPACENAME}...${NC}"
mkdir ${WORKSPACENAME}.xcworkspace
cd ${WORKSPACENAME}.xcworkspace
mkdir xcshareddata
mkdir xcuserdata
touch contents.xcworkspacedata



echo $'<?xml version=\"1.0\" encoding=\"UTF-8\"?>' >> contents.xcworkspacedata
echo "<Workspace" >> contents.xcworkspacedata
echo $'   version = \"UTF-8\">' >> contents.xcworkspacedata

while [[ !$HASFINISHEDADDINGPROJECT ]]
do
echo -e "${YELLOW}Drag and drop your .xcodeproj or give me a path to its location...${NC}"
read PATHTOPROJECT
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:${PATHTOPROJECT}\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata
echo -e "${YELLOW}Do you need to add more projects (y/n)?${NC}"
read ANSWER
if [[ $ANSWER == *"n"* ]]
then
break
fi
done
echo -e "${YELLOW}Do you need to add Pods to your project (y/n)?${NC}"
read ANSWER
if [[ $ANSWER == *"y"* ]]
then
echo -e "${YELLOW}Drag and drop your pods .xcodeproj or give me a path to its location...${NC}"
read PATHTOPODSPROJECT
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:${PATHTOPODSPROJECT}\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata
fi 
echo "</Workspace>" >> contents.xcworkspacedata

echo -e "${GREEN}Linking all projects...${NC}"
cd xcshareddata
echo $'<?xml version=\"1.0\" encoding=\"UTF-8\"?>' >> IDEWorkspaceChecks.plist
echo $'<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">' >> IDEWorkspaceChecks.plist
echo $'<plist version=\"UTF-8\">' >> IDEWorkspaceChecks.plist
echo "<dict>" >> IDEWorkspaceChecks.plist
echo "<key>IDEDidComputeMac32BitWarning</key>" >> IDEWorkspaceChecks.plist
echo "<true/>" >> IDEWorkspaceChecks.plist
echo "</dict>" >> IDEWorkspaceChecks.plist
echo "</plist>" >> IDEWorkspaceChecks.plist
cd ..
cd xcuserdata
mkdir $USER.xcuserdata
echo -e "${GREEN}Done.${NC}"
cd ..
cd ..
echo -e "${GREEN}You can find your project in: $PWD ${NC}"
#~/Documents/BladiBla/BladiBla.xcodeproj

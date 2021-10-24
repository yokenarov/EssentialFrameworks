#!/usr/bin/env bash
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
NC='\033[0m'
echo -e "${YELLOW}What should your new workspace be called?${NC}"
read WORKSPACENAME
echo -e "${GREEN}Creating workspace ${WORKSPACENAME}...${NC}"
mkdir ${WORKSPACENAME}.xcworkspace
cd ${WORKSPACENAME}.xcworkspace
mkdir xcshareddata
mkdir xcuserdata
touch contents.xcworkspacedata
echo -e "${YELLOW}Drag and drop your .xcodeproj or give me a path to its location...${NC}"
read PATHTOPROJECT
echo -e "${GREEN}Linking all projects...${NC}"
echo $'<?xml version=\"1.0\" encoding=\"UTF-8\"?>' >> contents.xcworkspacedata
echo "<Workspace" >> contents.xcworkspacedata
echo $'   version = \"UTF-8\">' >> contents.xcworkspacedata

echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:${PATHTOPROJECT}\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata

echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:GenericViews/GenericViews.xcodeproj\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:Essentials/Essentials.xcodeproj\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:NetworkingAPI/NetworkingAPI.xcodeproj\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata

echo "</Workspace>" >> contents.xcworkspacedata

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

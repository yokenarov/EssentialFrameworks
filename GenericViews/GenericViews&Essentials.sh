#!/usr/bin/env bash
mkdir GenericViews2.xcworkspace
cd GenericViews2.xcworkspace
mkdir xcshareddata
mkdir xcuserdata
touch contents.xcworkspacedata
echo $'<?xml version=\"1.0\" encoding=\"UTF-8\"?>' >> contents.xcworkspacedata
echo "<Workspace" >> contents.xcworkspacedata
echo $'   version = \"UTF-8\">' >> contents.xcworkspacedata
if [[ $# -ne 0 ]] ; then 
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:$1\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata
fi
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:GenericViews.xcodeproj\">" >> contents.xcworkspacedata
echo $'   </FileRef>' >> contents.xcworkspacedata
echo $'   <FileRef' >> contents.xcworkspacedata
echo "      location = \"group:../Essentials/Essentials.xcodeproj\">" >> contents.xcworkspacedata
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
 
#../../Documents/BladiBla/BladiBla.xcodeproj

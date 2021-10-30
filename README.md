# EssentialsFramework
This Repo contains three standalone frameworks meant for any general purpose coding along with some setup/helper scripts.

There are two ways to get started.  

1. Assuming you are trying to test out the Example project run the assembleWorkspace script. 
Open terminal and cd into the cloned project directory then run:

sudo cmod +x assembleExampleWorkspace.sh 

This will make the script executable. It will prompt you for your password and then enter it. If you are unsure wether or not to run the script feel free to inspect it before you enable execution of the script. 
After that run: 

./assembleExampleWorkSpace.sh

This will create a workspace with all three projects linked and dependencies fixed. 
Now open the workspace change the target to ExampleWorkspace, select the device you want it to run on and run it. 

Thats all!

2. Assuming you want to try the standalone libraries on existing projects, I got you covered with another script for creating a workspace. 
NOTE: The GenericViews framework expects the Essentials framework as a dependency. So if you plan to use it you will have to include it in the script as well. 

Now for creating a common workspace open terminal and cd into the cloned project directory then run:

sudo cmod +x createWorkspace.sh 

It will prompt you again for your password. 

When you are finished with that, all thats left to do is run the script and follow its instructions. 
There is one catch, if your existing project uses Cocoapods, you will have to pay attention to the instructions on what to do when importing them into the workspace.

First it will ask you for the name of the workspace - enter a name of your chosing. 
Second it will ask you to either type the location of the project that you want to import or simple you can just drag the .xcodeproj (not .xcworkspace) to the terminal. In these steps, you will only add the .xcodeproj directories that you want to assemble in the workspace.
When you are done with adding the .xcodeproj files and when it asks you if you want to include more projects type n into the terminal. After that it will ask you if you have any Pods to integrate as well, if yes press y and drag the Pods.xcodeproj from your project's Pods directory into the terminal and press enter. 

Now since its a new workspace, you will have to include the frameworks into your own project in order to get a build going. 
Go to your project in Xcode -> General -> scroll to Frameworks and embbeded libraries -> Click the + and add the frameworks that you have imported. 

That should be it. 
This is how it should look like: 
![Alt text](Example_Project_SS.png?raw=true)


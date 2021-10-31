# EssentialsFramework
This Repo contains three standalone frameworks meant for any general purpose coding along with some setup/helper scripts and an example project that combines all of them.

To get started, there are two paths you can go on.
  
*The first one*
Assuming you are trying to test out the Example project run the assembleWorkspace script. 
Open terminal and cd into the cloned project directory then run:

![Alt text](assemblingWorkspace.png?raw=true)

> cd Frameworks
> sudo chmod +x assembleExampleWorkspace

This will make the script executable. It will prompt you for your password and you will have to enter it. If you are unsure wether or not to run the script feel free to inspect it before you enable execution its execution. 
After that run: 

>> ./assembleExampleWorkspace.sh

This will create a workspace with all four projects linked and dependencies fixed. 

Now open the workspace change the target to ExampleWorkspace, select the device you want it to run on and Build and Run it. 

Thats all!

*The second one*
Assuming you want to try the standalone libraries on existing projects, I got you covered with another script for creating a common workspace. 
NOTE: The GenericViews framework expects the Essentials framework as a dependency. So if you plan to use it you will have to include it in the script as well. 

Now for creating a common workspace open terminal and cd into the cloned project directory then run:

sudo cmod +x createWorkspace.sh 

It will prompt you again for your password. 

When you are finished with that, all thats left to do is run the script and follow its instructions. 
 
That should be it. 

This is how it should look like: 
![Alt text](Example_Project_SS.png?raw=true)


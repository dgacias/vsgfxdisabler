# vsgfxdisabler
Vampire Survivors Graphical Effects disabler

This powershell script will allow you to disable individual effects of your liking to be able to see more screen and also gain more FPS due to less artifacts being drawn. You can restore the original files within the application.

![](/vsgfxdisabler.png)

## INSTALLATION
Download vsgfxdisabler.ps1 and place it in your "img" directory. In my case the path is [Vampire survivors installation dir]\resources\app\.webpack\renderer\assets\img\
It should be the directory that contains the items.json, items.png, vfx.json and vfx.png files.


Right click on the powershell file and select "Run with powershell". Wait some seconds for the program to load all the images from the game and you can start disabling the effects you do not want to see on screen.

Remember to save the changes! (It may take some seconds, wait until a popup is displayed)

NOTE: Reenabling the checkboxes actually do nothing even if you save at this moment, please restore the original file and disable again the effects you do not want to see.
If you restore any original files, close and open the program again to refresh the changes.

## TROUBLESHOOTING
If the script does not run for you, probably you have powershell execute restrictions, try this.

Open the folder where you have the script, right click on the blank part of the folder and open a terminal.

Type:
powershell .\vsgfxdisabler.ps1

It should say what the error is without closing the window.
If the problem is that the policy of the machine do not allow to run powershell scripts (most likely), then do this:

Right click on the windows button, open a powershell (administrator)
Execute this command:
Set-ExecutionPolicy Bypass

If permissions was the problem, then you should be able to right click and run the powershell script as intended.
Beware that by default windows protects you from doing this because you might download a malware script from the internet (mine is safe, you can see the code for yourself).

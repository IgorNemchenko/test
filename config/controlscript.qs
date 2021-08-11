function Controller()
{
    //installer.addWizardPage( component, "CustomIntroduction", QInstaller.Introduction );

    //installer.removeWizardPageItem(component, "CancelButton");


    var widget = gui.pageById(QInstaller.Introduction); // get the introduction wizard page
    if (widget != null) {
        widget.packageManagerCoreTypeChanged.connect(onPackageManagerCoreTypeChanged);
    }
}

onPackageManagerCoreTypeChanged = function()
{
    console.log("Is Updater: " + installer.isUpdater());
    console.log("Is Uninstaller: " + installer.isUninstaller());
    console.log("Is Package Manager: " + installer.isPackageManager());
}

Controller.prototype.IntroductionPageCallback = function()
{
    var widget = gui.currentPageWidget(); // get the current wizard page
    if (widget != null) {
        //widget.title = "Hello."; // set the page title
        //widget.MessageLabel.setText("New Message."); // set the welcome text
        widget.hide();

    }
}

/*Controller.prototype.TargetDirectoryPageCallback = function()
{
    gui.clickButton(buttons.NextButton); // automatically click the Next button
}*/

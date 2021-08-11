/**************************************************************************
**
** Copyright (C) 2020 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Installer Framework.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
**************************************************************************/

function Component()
{
    // constructor
    //installer.setDefaultPageVisible(QInstaller.Introduction, 0);
    //installer.setDefaultPageVisible(QInstaller.LicenseCheck, 0);
    installer.setDefaultPageVisible(QInstaller.ComponentSelection, 0);
    //installer.setDefaultPageVisible(QInstaller.TargetDirectory, 0);
    installer.setDefaultPageVisible(QInstaller.ReadyForInstallation, 0);
	//component.loaded.connect(this, Component.prototype.loaded);
	//installer.addWizardPage( component, "Page", QInstaller.TargetDirectory );
    /*if (!installer.addWizardPage( component, "widget", QInstaller.TargetDirectory ))
        console.log("Could not add the dynamic page.");*/

}

Component.prototype.createOperations = function()
{
  component.createOperations();
  if (systemInfo.productType === "windows")
  {
    try 
    {
		// Desktop shortcut.
		component.addOperation("CreateShortcut", 
			"@TargetDir@/chrome.exe",// target
			"@DesktopDir@/chrome.lnk",// link-path
			"workingDirectory=@TargetDir@",// working-dir
			"iconPath=@TargetDir@/chrome.exe",
			"iconId=0",// icon
			"description=Start sgbrowser");// description
		
		// StartMenu shortcut.		
		component.addOperation("CreateShortcut",
			"@TargetDir@/chrome.exe",
			"@StartMenuDir@/chrome.lnk",
            "workingDirectory=@TargetDir@",
			"iconPath=@TargetDir@/chrome.exe",
            "iconId=0",
			"description=Start sgbrowser");
		
		// StartMenu uninstaller shortcut.
		component.addOperation("CreateShortcut",
			"@TargetDir@/sgbrowseruninstaller.exe",
			"@StartMenuDir@/sgbrowser_uninstall.lnk",
            "workingDirectory=@TargetDir@",
			"iconPath=@TargetDir@/sgbrowseruninstaller.exe",
            "iconId=0",
			"description=Uninstall sgbrowser");
    }
    catch (e) 
    {
      print(e);
    }
  }
}

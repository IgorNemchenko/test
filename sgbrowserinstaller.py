import argparse, os, shutil, subprocess, time
from termcolor import colored
from pathlib import Path
import glob

#
# Few helper function for printing messages.
#

def PrintError(text: str):
    print(colored(text, "red"))

def PrintInfo(text: str):
    print(colored(text, "green"))

def PrintWarning(text: str):
    print(colored(text, "yellow"))

#
# Script body.
#

print("Building installer...")

parser = argparse.ArgumentParser()

# Required parameters.
parser.add_argument("--src", type=str,
    help="path to sgbrowser build directory'",
    required=True)

args = parser.parse_args()

chromium_installer = ("ninja -C {} mini_installer").format(args.src)

subprocess.run(chromium_installer)

mini_installer_path = args.src + "/gen/chrome/installer/mini_installer/mini_installer/temp_installer_archive/Chrome-bin";
installer_data = "./packages/com.sgbrowser/data";
shutil.rmtree(installer_data)
shutil.copytree(mini_installer_path, installer_data)

luxand_dll = Path(args.src).parent.parent
luxand_dll = luxand_dll / "extensions/browser/api/sgebrowser/Luxand/bin/win64/facesdk.dll"
shutil.copy(luxand_dll, Path(glob.glob(installer_data + "/*/")[0]) / "facesdk.dll")

#print(glob.glob(installer_data + "/*/")) 
qt_builder_path = ("{}/../../Tools/QtInstallerFramework/4.1/bin/binarycreator")
qt_builder_path = qt_builder_path.format(os.environ['QTDIR'])
installer_command = ("{} -c {} -p {} {}")
installer_command = installer_command.format(
	qt_builder_path, 
	"config/config.xml", 
	"packages",
	"SGBrowserInstaller.exe")

subprocess.run(installer_command)
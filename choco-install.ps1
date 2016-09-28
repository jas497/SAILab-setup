
# Commented entries were broken.  Might be fixed.

choco install -y chocolateygui
choco install -y git
choco install -y firefox
choco install -y notepadplusplus
choco install -y emacs # might get 64-bit 25.1 soon, but 24.5 for now
choco install -y sublimetext3
choco install -y classic-shell
choco install -y putty
choco install -y 7zip.install
choco install -y greenshot

choco install -y python # v3.x

choco install -y miktex
choco install -y texstudio

choco install -y vlc
choco install -y curl
choco install -y nodejs.install

#region Android
# manual config may be needed to get SDK
$dirAndroidSDK = 'C:\AndroidSDK\'
Try { mkdir $dirAndroidSDK -ea Stop } Catch { echo "Have you run this script before?" }

choco install -y androidstudio -params '"/PinnedToTaskbar:true"'
choco install -y adb
# still need this:
# http://www.howtogeek.com/125769/how-to-install-and-use-abd-the-android-debug-bridge-utility/

$pathKey = 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
$oldPath = (Get-ItemProperty $pathKey).Path
$newPath = $dirAndroidSDK + "tools;" + $dirAndroidSDK + "platform-tools;" + $oldPath
Set-ItemProperty -Path $pathKey -Name Path -Value $newPath
#endregion

# Uses AHK to trigger installing drivers for USB (manual may be requried)
choco install -y arduino --allow-empty-checksums

# Broken on our systems
# choco install -y visualstudio2015community

<# Installed as prerequisites
jre8
jdk8
autohotkey.portable
android-sdk
#>




#region Weekly upgrade
# FIXME correct the password before running this file
$A = New-ScheduledTaskAction –Execute "choco upgrade all -y"
$T = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 4am
$S = New-ScheduledTaskSettingsSet
$D = New-ScheduledTask -Action $A -Trigger $T -Settings $S
Register-ScheduledTask ChocolateyWeeklyUpgrade -InputObject $D -User "$env:USERDOMAIN\$env:USERNAME" -Password 'password'
#endregion

# Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -DisableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
$controlFoldersKey = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $controlFoldersKey Hidden 1
Set-ItemProperty $controlFoldersKey HideFileExt 0
Set-ItemProperty $controlFoldersKey ShowStatusBar 1
Set-ItemProperty $controlFoldersKey SeparateProcess 1
Set-ItemProperty $controlFoldersKey DontPrettyPath 0

Stop-Process -processname explorer

echo "\n\n\n\n"
echo "Arduino IDE has driver issues.  Please attend to them."
echo "ADB is not fully installed.  Please fix that with the web page that just opened."
Start-Process "firefox.exe" "http://www.howtogeek.com/125769/how-to-install-and-use-abd-the-android-debug-bridge-utility/"

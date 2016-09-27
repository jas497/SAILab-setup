
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

# manual config may be needed to get SDK
Try { mkdir C:\AndroidSDK\ -ea Stop } Catch { echo "Have you run this script before?" }
choco install -y androidstudio -params '"/PinnedToTaskbar:true"'
choco install -y adb
echo "Remember to put the SDK in the shared directory."

# Uses AHK to trigger installing drivers for USB (manual may be requried)
choco install -y arduino --allow-empty-checksums

# Broken on our systems
# choco install -y visualstudio2015community

# FIXME correct the password before running this file
$A = New-ScheduledTaskAction –Execute "choco upgrade all -y"
$T = New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 4am
$S = New-ScheduledTaskSettingsSet
$D = New-ScheduledTask -Action $A -Trigger $T -Settings $S
Register-ScheduledTask ChocolateyWeeklyUpgrade -InputObject $D -User "$env:USERDOMAIN\$env:USERNAME" -Password 'password'

# Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -DisableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced'
Set-ItemProperty $key Hidden 1
Set-ItemProperty $key HideFileExt 0
Set-ItemProperty $key ShowStatusBar 1
Stop-Process -processname explorer

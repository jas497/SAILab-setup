

# Commented entries were broken.  Might be fixed.

choco install -y chocolateygui
choco install -y git
choco install -y firefox
choco install -y notepadplusplus
choco install -y classic-shell
choco install -y putty
choco install -y 7zip.install
choco install -y greenshot

choco install -y python # v3.x

choco install -y miktex
choco install -y texstudio

choco install -y androidstudio -params '"/PinnedToTaskbar:true"'
choco install -y adb
# choco install -y arduino
# choco install -y visualstudio2015community

$A = New-ScheduledTaskAction –Execute "choco upgrade all"
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

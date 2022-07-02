# Script to automate Windows updates

#get the module
Import-Module PSWindowsUpdate\2.2.0.3\PSWindowsUpdate.dll

# Checks if folder AutoUpdates already exists on the server. If it doesn't it creates it
$ChkPath = "C:\AutoUpdates"
$PathExists = Test-Path $ChkPath
If ($PathExists -eq $false)
{
    mkdir C:\AutoUpdates
    mkdir C:\AutoUpdates\History
    mkdir C:\AutoUpdates\KBs
}
else
{
    # Do nothing
}


# Installs windows updates

# Gets latest Windows updates
Get-WindowsUpdate | Out-File C:\AutoUpdates\History\"$((Get-Date).ToString('dd-MM-yyyy_HH.mm.ss'))_updates".txt

#Installs updates, accepts all automatically and reboots.
Get-WindowsUpdate -Install -AcceptAll -AutoReboot

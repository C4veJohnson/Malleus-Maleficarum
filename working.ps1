# Script to automatically install Windows updates

Set-ExecutionPolicy Bypass -Scope Process -Force

Import-Module PSWindowsUpdate\2.2.0.3\PSWindowsUpdate.dll

# Checks if folder "AutoUpdates already exists on the server. If it doesn't it creates it."
$ChkPath = "C:\AutoUpdates"
$PathExists = Test-Path $ChkPath
If ($PathExists -eq $false)
{
    mkdir C:\AutoUpdates
    mkdir C:\AutoUpdates\History
}
else
{
    # Do nothing
}


$ChkFile = "C:\AutoUpdates\Progress.txt"
$FileExists = Test-Path $ChkFile
If ($FileExists -eq $false)
{
    New-Item C:\AutoUpdates\Progress.txt
    Set-Content C:\AutoUpdates\Progress.txt -Value 0
}
else
{
    # Do nothing
}



# Reads the file for status
# This is the logic used to control the installation status of the server.
$Status = Get-Content C:\AutoUpdates\Progress.txt -First 1

If ($Status -eq 0) 
{
    # Installs required modules
    Import-Module -Name PSWindowsUpdate\2.2.0.3\PSWindowsUpdate.dll
    # Sets Progress file to 1, to indicate modules etc. are installed.
    Set-Content C:\AutoUpdates\Progress.txt -Value 1
    # Gets latest Windows updates
    Get-WindowsUpdate | Out-File C:\AutoUpdates\History\Updates_"$((Get-Date).ToString('dd-MM-yyyy_HH.mm.ss'))".txt

    #Installs updates, accepts all automatically and reboots.
    Get-WindowsUpdate -Install -AcceptAll -AutoReboot
}
elseif ($Status -eq 1)
{
    # Installs windows updates
    # Gets latest Windows updates
    Get-WindowsUpdate | Out-File C:\AutoUpdates\History\Updates_"$((Get-Date).ToString('dd-MM-yyyy_HH.mm.ss'))".txt

    #Installs updates, accepts all automatically and reboots.
    Get-WindowsUpdate -Install -AcceptAll -AutoReboot
}

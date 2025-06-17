<#
.SYNOPSIS
    This PowerShell script sets the screen saver timeout to 900 seconds (15 minutes).

.NOTES
    Author          : Delvin Williams  
    LinkedIn        : linkedin.com/in/delvinwilliams/  
    GitHub          : github.com/delvinwilliams  
    Date Created    : 2025-06-17  
    Last Modified   : 2025-06-17  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-UC-000030

.TESTED ON
    Date(s) Tested  :  
    Tested By       :  
    Systems Tested  :  
    PowerShell Ver. : 

.USAGE
    Run this script as Administrator.
    Example:
    PS C:\> .\Remediate-WN10-UC-000030.ps1
#>

# Set screen saver timeout to 900 seconds (15 minutes)
try {
    $registryPath = "HKCU:\Control Panel\Desktop"
    $name = "ScreenSaveTimeOut"
    $desiredTimeout = "900"

    Set-ItemProperty -Path $registryPath -Name $name -Value $desiredTimeout
    Write-Host "Screen saver timeout successfully set to 900 seconds." -ForegroundColor Green
}
catch {
    Write-Error "Failed to set screen saver timeout. Error: $_"
}

<#
.SYNOPSIS
    This PowerShell script ensures a password is required when resuming from the screen saver.

.NOTES
    Author          : Delvin Williams  
    LinkedIn        : linkedin.com/in/delvinwilliams/  
    GitHub          : github.com/delvinwilliams  
    Date Created    : 2025-06-17  
    Last Modified   : 2025-06-17  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-UC-000040

.TESTED ON
    Date(s) Tested  :  
    Tested By       :  
    Systems Tested  : Windows 10, Windows 11  
    PowerShell Ver. : 5.1+

.USAGE
    Run this script as the logged-in user or enforce via GPO.
    Example:
    PS C:\> .\Remediate-WN10-UC-000040.ps1
#>

# Require password on resume from screen saver
try {
    $regPath = "HKCU:\Control Panel\Desktop"
    $name = "ScreenSaverIsSecure"
    $value = "1"

    Set-ItemProperty -Path $regPath -Name $name -Value $value
    Write-Host "Screen saver secure resume (password required) is now enabled." -ForegroundColor Green
}
catch {
    Write-Error "Failed to enable secure resume. Error: $_"
}

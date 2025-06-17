<#
.SYNOPSIS
    This PowerShell script disables the built-in Guest account on a Windows system.

.NOTES
    Author          : Delvin Williams
    LinkedIn        : linkedin.com/in/delvinwilliams/  
    GitHub          : github.com/delvinwilliams 
    Date Created    : 2025-06-17  
    Last Modified   : 2025-06-17  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-SO-000030

.TESTED ON
    Date(s) Tested  :  
    Tested By       :  
    Systems Tested  :   
    PowerShell Ver. : 

.USAGE
    Run this script as Administrator.
    Example:
    PS C:\> .\Remediate-WN10-SO-000030.ps1
#>

# Disable the built-in Guest account
try {
    $guest = Get-LocalUser -Name "Guest"

    if ($guest.Enabled) {
        Disable-LocalUser -Name "Guest"
        Write-Host "Guest account has been disabled." -ForegroundColor Green
    } else {
        Write-Host "Guest account is already disabled." -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Failed to disable Guest account. Error: $_"
}

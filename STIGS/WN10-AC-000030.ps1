<#
.SYNOPSIS
    This PowerShell script configures the system to enforce a password history of 24 passwords.

.NOTES
    Author          : Delvin Williams  
    LinkedIn        : linkedin.com/in/delvinwilliams/  
    GitHub          : github.com/delvinwilliams  
    Date Created    : 2025-06-17  
    Last Modified   : 2025-06-17  
    Version         : 1.0  
    CVEs            : N/A  
    Plugin IDs      : N/A  
    STIG-ID         : WN10-AC-000030

.TESTED ON
    Date(s) Tested  :  
    Tested By       :  
    Systems Tested  :   
    PowerShell Ver. : 

.USAGE
    Run this script as Administrator.
    Example:
    PS C:\> .\Remediate-WN10-AC-000030.ps1
#>

# Enforce password history (set to 24 passwords)
try {
    secedit /export /cfg "$env:TEMP\secpol.cfg"

    $lines = Get-Content "$env:TEMP\secpol.cfg"
    $updated = $false

    $newLines = $lines | ForEach-Object {
        if ($_ -match "^PasswordHistorySize") {
            $updated = $true
            "PasswordHistorySize = 24"
        } else {
            $_
        }
    }

    if (-not $updated) {
        $newLines += "PasswordHistorySize = 24"
    }

    $newLines | Set-Content "$env:TEMP\secpol.cfg"
    secedit /configure /db secedit.sdb /cfg "$env:TEMP\secpol.cfg" /quiet

    Write-Host "Password history policy updated to remember last 24 passwords." -ForegroundColor Green
}
catch {
    Write-Error "Failed to enforce password history. Error: $_"
}

<#
.SYNOPSIS
    This PowerShell script ensures that Windows 10 account lockout duration will be configured to 15 minutes or greater.

.NOTES
    Author          : Delvin Williams
    LinkedIn        : linkedin.com/in/delvinwilliams/
    GitHub          : github.com/delvinwilliams
    Date Created    : 2025-05-29
    Last Modified   : 2024-05-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script in PowerShell (preferably as Administrator). No parameters are needed.

    Example:
    PS C:\> .\Check-LockoutDuration-WN10-AC-000005.ps1

    What it does:
    - Exports the current local security policy.
    - Checks the value of "Account lockout duration".
    - Compares it to the STIG requirement (WN10-AC-000005):
        * If the duration is less than 15 minutes and not 0 → this is a finding.
        * If it is 0 (manual admin unlock) → not a finding.
        * If it is 15 or more → not a finding.
    - Outputs the result to the screen.
#>

# Define the registry path
Open gpedit.msc and navigate to:
    "Local Computer Policy >> Computer Configuration >> Windows Settings >> Security Settings >> Account Policies >> Account Lockout Policy"

# Requirement:
    - If "Account lockout duration" is less than 15 minutes (and not 0), it is a finding.
    - If set to 0, manual unlock by admin is required (this is NOT a finding).
#>

# Export the local security policy to a temp file
$cfgPath = "$env:TEMP\secpol.cfg"
secedit /export /cfg $cfgPath | Out-Null

# Read the lockout duration value
$cfg = Get-Content $cfgPath
$lockoutLine = $cfg | Where-Object { $_ -match "LockoutDuration" }

# Parse the value
if ($lockoutLine) {
    $duration = ($lockoutLine -split "=")[1].Trim()
    $minutes = [int]$duration

    if ($minutes -eq 0) {
        Write-Output "Account lockout duration is set to 0 (admin must unlock). This is NOT a finding."
    }
    elseif ($minutes -lt 15) {
        Write-Output "Account lockout duration is $minutes minutes. This IS a finding (must be 15 or more)."
    }
    else {
        Write-Output "Account lockout duration is $minutes minutes. This is NOT a finding."
    }
} else {
    Write-Output "Could not read LockoutDuration from local security policy. Manual check recommended."
}

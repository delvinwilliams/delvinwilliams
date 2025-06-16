<#
.SYNOPSIS
    This PowerShell script enables Windows Defender SmartScreen for Microsoft Edge to comply with STIG ID WN10-CC-000360.

.NOTES
    Author          : Delvin Williams
    LinkedIn        : linkedin.com/in/delvinwilliams/
    GitHub          : github.com/delvinwilliams
    Date Created    : 2025-06-16
    Last Modified   : 2025-06-16
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000360

.TESTED ON
    Date(s) Tested  : 2025-06-16
    Tested By       : Delvin Williams
    Systems Tested  : Windows 10 Pro x64 (Build 19045)
    PowerShell Ver. : 5.1

.USAGE
    Run this script with administrative privileges to ensure SmartScreen is enabled for Microsoft Edge.
    Example:
    PS C:\> .\Enable-SmartScreenEdge-WN10-CC-000360.ps1
#>

# Define registry path and value
$registryPath = "HKLM:\Software\Policies\Microsoft\MicrosoftEdge\PhishingFilter"
$propertyName = "EnabledV9"
$desiredValue = 1

# Create the registry path if it doesn't exist
if (-Not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $registryPath -Name $propertyName -Value $desiredValue -Type DWord

# Confirm change
Write-Host "STIG WN10-CC-000360 remediated: SmartScreen for Microsoft Edge has been enabled." -ForegroundColor Green

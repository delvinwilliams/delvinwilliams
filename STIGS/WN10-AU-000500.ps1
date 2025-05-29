<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Delvin Williams
    LinkedIn        : linkedin.com/in/delvinwilliams/
    GitHub          : github.com/delvinwilliams
    Date Created    : 2025-05-28
    Last Modified   : 2024-05-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    This script checks and sets the maximum size of the Windows Application event log to 32 MB (32768 KB)
    to comply with STIG ID WN10-AU-000500.

    Run the script in an elevated PowerShell session (as Administrator).

    Example:

    PS C:\> .\Set-AppEventLogMaxSize.ps1

    No parameters are required. The script will:
    - Create the registry key if it does not exist
    - Set "MaxSize" to 32768 KB under:
      HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application

    You can verify the setting manually by checking Event Log policy or the registry path above. 
#>

# Define the registry path
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application"

# Check if the key exists; if not, create it
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the MaxSize value to 0x00008000 (32768 in decimal)
Set-ItemProperty -Path $registryPath -Name "MaxSize" -Value 32768 -Type DWord

# Output confirmation
Write-Output "MaxSize set to 32768 (0x00008000) under $registryPath"

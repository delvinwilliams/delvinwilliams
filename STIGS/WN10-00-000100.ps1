<#
.SYNOPSIS
    This PowerShell script checks whether IIS or Hostable Web Core is installed on Windows 10, as required by STIG ID: WN10-00-000100.

.NOTES
    Author          : Delvin Williams
    LinkedIn        : linkedin.com/in/delvinwilliams/
    GitHub          : github.com/delvinwilliams
    Date Created    : 2025-05-29
    Last Modified   : 2024-05-29
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000100

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Run this script in PowerShell (preferably as Administrator). No parameters are needed.

    What it does:
    - Checks for the installation of "Internet Information Services" (IIS) and "Internet Information Services Hostable Web Core".
    - If either feature is enabled, it will be reported as a finding.
    - If neither is enabled, it confirms compliance with the STIG.

    IIS is not installed by default on Windows 10. The STIG requires verification that neither "Internet Information Services" nor "Internet Information Services Hostable Web Core" are installed.
    If an application requires IIS or a subset to function, it must be documented with the ISSO and comply with all applicable IIS STIGs.
#>

# Define feature names to check
$features = @(
    "IIS-WebServerRole",            # Full IIS role
    "IIS-WebServer",                # Web Server feature
    "IIS-HostableWebCore"           # Hostable Web Core

)

# Store any findings
$findings = @()

Write-Output "Checking IIS components per STIG ID: WN10-00-000100..."

foreach ($feature in $features) {
    $featureStatus = Get-WindowsOptionalFeature -Online -FeatureName $feature -ErrorAction SilentlyContinue
    if ($featureStatus.State -eq "Enabled") {
        $findings += "$feature is installed. This IS a finding."
    }
}

if ($findings.Count -eq 0) {
    Write-Output "PASS: Neither IIS nor Hostable Web Core are installed. System is compliant with WN10-00-000100."
} else {
    $findings | ForEach-Object { Write-Output "FINDING: $_" }
    Write-Output "`nRECOMMENDATION: If IIS or Hostable Web Core is required by an application, ensure it is documented with the ISSO and all applicable IIS STIG requirements are addressed."
}

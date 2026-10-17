
Write-Host "================================"
Write-Host "Windows Security Audit Tool"
Write-Host "================================"


Write-Host ""
Write-Host "Checking Windows Defender Status..."


Get-MpComputerStatus | 
    Select-Object AntivirusEnabled, RealTimeProtectionEnabled |
    Format-Table -AutoSize

Write-Host ""
Write-Host "Checking Windows Firewall Status.."

Get-NetfirewallProfile | Select-Object Name, Enabled | Format-Table -AutoSize


Write-Host ""
Write-Host "Checking Running Windows Services..."

Get-Service | Where-Object {$_.Status -eq "Running"} |
    Select-Object -First 10 Name, DisplayName, Status |
    Format-Table -AutoSize

Write-Host ""
Write-Host "Checking Recent Windows Security Events..."

try {
    Get-WinEvent -FilterHashtable @{
        LogName = "Security"
        Id = 4624, 4625
    } -MaxEvents 10 -ErrorAction Stop |
        Select-Object TimeCreated, Id |
        Format-Table -AutoSize
}
catch {
    Write-Host "Unable to retrieve security events."
    Write-Host "The log may require administrator access or contain no matching events."
}


Write-Host ""
Write-Host "Generating Security Audit Report..."

$reportPath = Join-Path $PSScriptRoot "security_audit_report.txt"

"Windows Security Audit Report" | Out-File -FilePath $reportPath
"Generated: $(Get-Date)" | Out-File -FilePath $reportPath -Append
"================================" | Out-File -FilePath $reportPath -Append

" " | Out-File -FilePath $reportPath -Append
"Windows Defender Status" | Out-File -FilePath $reportPath -Append

Get-MpComputerStatus |
    Select-Object AntivirusEnabled, RealTimeProtectionEnabled |
    Format-Table -AutoSize |
    Out-File -FilePath $reportPath -Append

" " | Out-File -FilePath $reportPath -Append
"Windows Firewall Status" | Out-File -FilePath $reportPath -Append

Get-NetFirewallProfile |
    Select-Object Name, Enabled |
    Format-Table -AutoSize |
    Out-File -FilePath $reportPath -Append

" " | Out-File -FilePath $reportPath -Append
"Running Windows Services" | Out-File -FilePath $reportPath -Append

Get-Service |
    Where-Object {$_.Status -eq "Running"} |
    Select-Object -First 10 Name, DisplayName, Status |
    Format-Table -AutoSize |
    Out-File -FilePath $reportPath -Append

" " | Out-File -FilePath $reportPath -Append
"Recent Windows Security Events" | Out-File -FilePath $reportPath -Append

try {
    Get-WinEvent -FilterHashtable @{
        LogName = "Security"
        Id = 4624, 4625
    } -MaxEvents 10 -ErrorAction Stop |
        Select-Object TimeCreated, Id |
        Format-Table -AutoSize |
        Out-File -FilePath $reportPath -Append
}
catch {
    "Unable to retrieve security events." |
        Out-File -FilePath $reportPath -Append
}

Write-Host "Report created successfully."


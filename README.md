
# Windows Security Audit Tool

## Overview
A PowerShell-based security auditing tool that checks
Windows security settings and generates a text report.

This project demonstrates Windows administration,
PowerShell scripting, and basic security monitoring.

## Features
- Check Windows Defender antivirus status
- Check real-time protection status
- Review Windows Firewall profiles
- List running Windows services
- Retrieve recent Windows Security login events
- Generate a security audit report automatically

## Technologies Used
- Windows
- PowerShell
- Windows Defender
- Windows Event Logs
- Git and GitHub

## How to Run
1. Open Windows PowerShell as Administrator.
2. Navigate to the project folder.
3. Run the script:

   .\security_audit.ps1

Note: PowerShell execution policy may need to allow
trusted local scripts. Security event log access may
require administrator privileges.

## Security Events
- Event ID 4624: Successful logon
- Event ID 4625: Failed logon attempt

The script retrieves the 10 most recent matching
security events.

## Report Generation
The script generates a file named:

security_audit_report.txt

This file contains the results of the security checks.

## Privacy
Generated audit reports are excluded from Git using
.gitignore to avoid publishing local system information.

## Purpose
This project was developed to practice PowerShell
automation, Windows security administration,
and basic security auditing.

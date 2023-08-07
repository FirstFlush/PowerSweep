# PowerSweep - Windows Privilege Escalation Vector Finder

PowerSweep is a PowerShell module designed to identify potential privilege escalation vectors on Windows systems. It can be useful for CTF challenges, security evaluations, and learning PowerShell scripting. Please note that this project is a work in progress and should not be solely relied upon for security assessments.

## Features

Service Permissions Scanning: Identifies insecure service permissions that could lead to privilege escalation.
Service Path Scanning: Identifies potential service path vulnerabilities.
High-Privilege Rights Detection: Highlights access control entries (ACEs) that grant high-privilege rights.
Windows Security Center Information: Retrieves information about installed antivirus and antispyware products.

## Installation

Clone the PowerSweep repository to your local machine.
Import the module into your PowerShell session using the Import-Module cmdlet.

```powershell
Import-Module path\to\PowerSweep.psm1
```

**Important:** To import a PowerShell module without specifying the full path, you need to place the module files in a directory specified in your PSModulePath environment variable. To view these directories, simply type:

```powershell
$env:PSModulePath
```

Verify Module has been loaded successfully:

```powershell
Get-Module
Get-Command -module PowerSweep
```

## Contributions

Contributions to this project are welcome! If you find any issues or have suggestions for improvements, please feel free to submit a pull request or create an issue in the repository.

## Disclaimer

This project is intended for educational purposes and self-assessment of security. Do not solely rely on it for critical security evaluations. The project is in active development, and there may be false positives or other limitations.

## License

This project is licensed under the MIT License.

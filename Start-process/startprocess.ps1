## Set-ExecutionPolicy RemoteSigned
## Press A
Start-Process -FilePath "C:\Program Files (x86)\Mozilla Thunderbird\thunderbird.exe"
Start-Process -FilePath "C:\windows\system32\WindowsPowerShell\v1.0\powershell.exe" -Verb RunAs

## Issue "& .\startprocess.ps1"
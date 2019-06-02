# powershellUD-demo

# This is an intro into powershell.

Taking data found from powershell and feeding it into a dashboard

To get started open an admin power shell terminal.
```
Install-Module UniversalDashboard.Community -AcceptLicense

git clone git@github.com:digikin/powershellUD-demo.git

cd powershellUD-demo

.\dataUD.ps1
```

If you get an error trying to install the module because of the powershell version.
You have to check your module version of powershellget.
Open the folder C:\Program Files\WindowsPowerShell\Modules\PowerShellGet

You should only have version 2.1.4 inside of that folder.  If you have anything less just move it out of the directory and reissue the commands.  

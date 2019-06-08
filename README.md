# powershellUD-demo

# This is an intro into powershell.

Taking data found from powershell by using basic commands and feeding it into a dashboard

I have included perf_demo.ps1 to show how the performance metric can be found using powershell.

```powershell
$Counters = @(
    '\network adapter(killer e2500 gigabit ethernet controller _4)\packets sent/sec'
    '\network adapter(killer e2500 gigabit ethernet controller _4)\packets received/sec'
    '\Memory\Available MBytes'
    '\Memory\% Committed Bytes In Use'
    '\logicaldisk(c:)\free megabytes'
    '\logicaldisk(d:)\free megabytes'
    '\process(idle)\% processor time'
    '\process(system)\% processor time'
    '\processor(_total)\% idle time'
)

Get-Counter -Counter $Counters -MaxSamples 5 | ForEach {
    $_.CounterSamples | ForEach {
        [pscustomobject]@{
            TimeStamp = $_.TimeStamp
            Path = $_.Path
            Value = $_.CookedValue
        }
    }
} | Export-Csv -Path perf.csv -NoTypeInformation
```


Then this is used to with the small script to export to a csv file where I can present the information with graphs. 

## Excell Dashboard preview 
![Excell Dashboard](/assets/images/excel-dashboard.PNG "Excell dashboard preview")



To get started open an admin power shell terminal.

```powershell
Install-Module UniversalDashboard.Community -AcceptLicense

git clone https://github.com/digikin/powershellUD-demo.git

cd powershellUD-demo

.\dataUD.ps1

Name  Port Running DashboardService
----  ---- ------- ----------------
Demo 10001    True UniversalDashboard.Services.DashboardService

Start-Process http://localhost:10001
```

If you get an error trying to install the module because of the powershell version.
You have to check your module version of powershellget.
Open the folder C:\Program Files\WindowsPowerShell\Modules\PowerShellGet

You should only have version 2.1.4 inside of that folder.  If you have anything less just move it out of the directory and reissue the commands.  

## Dashboard preview 
![PoshUD Dashboard](/assets/images/dashboard.PNG "PoshUD preview")

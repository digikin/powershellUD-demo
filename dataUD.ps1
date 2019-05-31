$Theme = Get-UDTheme Azure

$Footer = New-UDFooter -Copyright 'I dont care copy the crap out of this: by Eric Stumbo' -Links $Link
$Link = New-UDLink -text 'GitHub' -Url 'https://github.com/digikin/'
##I tried to set up a scheduler because no matter what I tried I cant get this dashboard to pull data.  SO I am trying to Cache the info.
$Schedule = New-UDEndpointSchedule -Every 1 -Second
$Endpoint = New-UDEndpoint -Schedule $Schedule -Endpoint {
    $Cache:Computers = Get-Counter '\Processor(_Total)\% Processor Time' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue
}


$dataUD = New-UDDashboard -Title "ITPro Camp Demo" -Theme $Theme -Footer $Footer -Content {
    New-UDCard -Fontcolor 'black' -Title "Hello, ITPro camp!" 
    New-UDRow {
        New-UDColumn -LargeSize 2 -Content { }
        New-UDColumn -LargeSize 4 -Content {
            New-UDChart -Title "Localhost - CPU (% processor time)" -Type Line -AutoRefresh -RefreshInterval 5 -Endpoint {
                $Cache:Computers | Out-UDChartData -DataProperty "MB" -LabelProperty "Date"
            }
            New-UdMonitor -Title "$ServerOne - CPU (% processor time)" -Type Line -DataPointHistory 20 -RefreshInterval 5 -ChartBackgroundColor '#80FF6B63' -ChartBorderColor '#FFFF6B63'  -Endpoint {
                Get-Counter -ComputerName $ServerOne '\Processor(_Total)\% Processor Time' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
            }

        }
        New-UDColumn -LargeSize 4 -Content {
            New-UdMonitor -Title "LocalHost - Memory (Available MB)" -Type Doughnut -ChartBackgroundColor '#80FF6B63' -ChartBorderColor '#FFFF6B63'  -Endpoint {
                Get-Counter '\logicaldisk(_total)\% free space' -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
            }
            New-UDChart -Title "Threads by Process" -Type Doughnut -RefreshInterval 5 -Endpoint {  
                Get-Process | ForEach-Object { [PSCustomObject]@{ Name = $_.Name; Threads = $_.Threads.Count } } | Out-UDChartData -DataProperty "Threads" -LabelProperty "Name"  
            } -Options @{  
                legend = @{  
                    display = $false  
                }  
            }           
        }
        New-UDColumn -LargeSize 2 -Content { }
    }

}
Start-UDDashboard -Port 10001 -Dashboard $dataUD -EndPoint $EndPoint -Name 'Demo' 
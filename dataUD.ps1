$Theme = New-UDTheme -Name "Azure2" -Definition @{
    UDDashboard = @{
        BackgroundColor = "#333333"
        FontColor       = "#FFFFF"
    }
    UDNavBar    = @{
        BackgroundColor = "#1c1c1c"
        FontColor       = "#55b3ff"
    }
    UDCard      = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDChart     = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDMonitor   = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDTable     = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDGrid      = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDCounter   = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDInput     = @{
        BackgroundColor = "#252525"
        FontColor       = "#FFFFFF"
    }
    UDFooter    = @{
        BackgroundColor = "#1c1c1c"
        FontColor       = "#55b3ff"
    }
}

$Footer = New-UDFooter -Copyright 'I dont care copy the crap out of this: by Eric Stumbo' -Links $Link
$Link = New-UDLink -text 'GitHub' -Url 'https://github.com/digikin/'


$dataUD = New-UDDashboard -Title "ITPro Camp Demo" -Theme $Theme -Footer $Footer -Content {
    New-UDCard -Fontcolor 'black' -Title "Hello, ITPro camp!" 
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content { }
        New-UDColumn -Size 6 -Content {              
            New-UDMonitor -Title "Processor (% Time)" -Type Line -DataPointHistory 100 -RefreshInterval 5 -Endpoint {
                Get-Counter "\Processor(*)\% Processor Time" -ErrorAction SilentlyContinue | Select-Object -ExpandProperty CounterSamples | Select-Object -ExpandProperty CookedValue | Out-UDMonitorData
            }
        }
    }
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content { }
        New-UDColumn -Size 6 -Content {              
            New-UDMonitor -Title "Network (IO Read Bytes/sec)" -Type Line -DataPointHistory 100 -RefreshInterval 1 -Endpoint {
                ((Get-Counter "\network adapter(killer e2500 gigabit ethernet controller _4)\packets sent/sec").countersamples).CookedValue | Out-UDMonitorData
            }
        }
    }
    New-UDRow -Columns {
        New-UDColumn -Size 3 -Content { }
        New-UDColumn -Size 6 -Content {   
            New-UDChart -Title "Threads by Process" -Type Doughnut -RefreshInterval 5 -Endpoint {  
                Get-Process | ForEach-Object { [PSCustomObject]@{ Name = $_.Name; Threads = $_.Threads.Count } } | Out-UDChartData -DataProperty "Threads" -LabelProperty "Name"  
            } -Options @{  
                legend = @{  
                    display = $false  
                }  
            }
        }
    }
}
Start-UDDashboard -Port 1001 -Dashboard $dataUD -Name 'Demo' -AutoReload
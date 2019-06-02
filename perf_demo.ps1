Get-Help Counter
Get-Help Counter -examples

$cpu = (Get-Counter -ListSet *).Paths
$cpu

$p = Get-Counter -Counter "\Processor(_Total)\% Processor Time"
$q = Get-Counter -Counter "\Process(idle)\% processor time"
$r = Get-Counter -Counter "\logicaldisk(_total)\% free space"
$p.CounterSamples
$q.CounterSamples
$r.CounterSamples



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


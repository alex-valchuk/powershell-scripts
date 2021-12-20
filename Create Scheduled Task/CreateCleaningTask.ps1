$action = New-ScheduledTaskAction -Execute "$($pwd)\AdobeActivationCodeCleaner.exe" -Argument "7"
$trigger = New-ScheduledTaskTrigger -Daily -At 8am
$taskName = "Clean Outdated Adobe Device Activation Codes"

$task = Get-ScheduledTask | Where-Object { $_.TaskName -eq $taskName } | Select-Object -First 1
if ($null -ne $task) {
    $task | Unregister-ScheduledTask -Confirm:$false
    Write-Host "Previous version of task '$taskName' was removed" -ForegroundColor Yellow
}
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $taskName -Description "This task removes outdated adobe device activation codes."
Write-Host "Task '$taskName' was created" -ForegroundColor Yellow

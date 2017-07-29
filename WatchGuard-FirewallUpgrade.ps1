#Requires -Version 3.0
<#Simple PowerShell script for autoupdating WatchGuard firewalls
        - Howto:
        1) Just change your credentials below
        2) Make sure the firewall.txt file exists and contains the path to each firewall,
        one address per line written like this https://X.X.X.X:8080/system/upgrade
        check file for example
        3) Rightclick the WatchGuard-FirewallUpgrade.ps1 script and select "Run with PowerShell"
        4) The script will open InternetExplorer and update all firewalls.
        5) a success-update.log and/or failed-update.log will be written in the same
        folder so you know if everything have worked out fine.
        6) This script have just gotten a few improvments and more can for sure be made along the way ;)
        // Best RGDS André - Nadox AB - www.nadox.se
 #>
 
$credential = Get-Credential -Message 'Write username and password for firewall' -UserName 'admin'

$time = (Get-Date).ToString('yyyy-MM-dd HH:mm:ss')
Write-Output -InputObject "$time - Starting upgrading firewalls"
$firewalls = Get-Content -Path '.\firewalls.txt'

$ie = new-object -ComObject InternetExplorer.Application
$ie.Visible = $true

foreach($firewall in $firewalls)
{
    $ie.Navigate2($firewall)

    while ($ie.Busy -eq $true){Start-Sleep -seconds 4} # Wait for page to load

    $overridelink = $ie.Document.getElementById('overridelink').Click()

    start-sleep -Seconds 3

    $IE.Document.getElementById('username').value=$credential.UserName 
    $IE.Document.getElementByID('password').value=$credential.Password
    $submit = $ie.Document.getElementById('submit').Click()

    start-sleep -Seconds 5

    $direct_upgrade = $ie.Document.getElementById('direct_upgrade').Click()

    start-sleep -Seconds 55 # time we wait for the upgrade to complete

    If (!$error)
    {Write-Output -InputObject $firewall | out-file -append -filepath '.\success-update.log'}
    Else
    {Write-Output -InputObject $firewall | out-file -append -filepath '.\failed-update.log'}
}
Write-Output -InputObject "$time - Finished upgrading firewalls"
# Write-Warning 'If you are done - PUSH enter'
# pause
Get-Process -Name iexplore | Foreach-Object { $null = $_.CloseMainWindow() } | stop-process -Force
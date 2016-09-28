# WatchGuard-FirewallUpgrade
Simple PowerShell script for autoupdating WatchGuard firewalls
- Howto:
1) Just change your credentials in WatchGuard-FirewallUpgrade.ps1
2) Make sure the firewall.txt file exists and contains the path to each firewall,
   one address per line written like this https://X.X.X.X:8080/system/upgrade
   check file for example.
3) Rightclick the WatchGuard-FirewallUpgrade.ps1 script and select "Run with PowerShell"
4) The script will open InternetExplorer and update all firewalls.
5) a success-update.log and/or failed-update.log will be written in the same
   folder so you know if everything have worked out fine.
6) This script have just gotten a few improvments and more can for sure be made along the way ;)
// Best RGDS André - Nadox AB - www.nadox.se

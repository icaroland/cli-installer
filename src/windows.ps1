"starting to install Icaro!"

$JavaVersion = 0

try
{
    $JavaVersion = [int](Get-Command java | Select-Object -ExpandProperty Version | Select-Object -ExpandProperty Major)
}
catch
{
    throw "java 11+ is required to install Icaro!"
}

if ($JavaVersion -lt 11)
{
    throw "Error: the java version in use should be 11+, current: $JavaVersion"
}

Get-ChildItem -Path ~/icaro -Recurse | Remove-Item -force -recurse
Remove-Item ~/icaro -ErrorAction SilentlyContinue
New-Item -Path "~/" -Name "icaro" -ItemType "directory"

$profilePath = $profile.CurrentUserAllHosts
if (!(Test-Path $profilePath))
{
    New-Item -ItemType File -Path $profilePath -Force
}
Add-Content -Path $profilePath -Value "`$env:ICARO_HOME = `"~/icaro`""
Add-Content -Path $profilePath -Value "New-Alias -Name icaro -Value java -jar ~/icaro/cli/entrypoint.jar"

. $profilePath

Get-ChildItem env:ICARO_HOME
Get-Alias -Name icaro
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

Get-ChildItem -Force -LiteralPath ~

[System.Environment]::SetEnvironmentVariable('ICARO_HOME', '~/icaro', 'User')
. $Profile.CurrentUserAllHosts
gci env:* | sort-object name

Get-Content -Path $Profile.CurrentUserAllHosts
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
New-Item -Path '~/icaro/lang' -ItemType Directory
New-Item -Path '~/icaro/cli/core' -ItemType Directory

$profilePath = $profile.CurrentUserAllHosts
if (!(Test-Path $profilePath))
{
    New-Item -ItemType File -Path $profilePath -Force
}
Add-Content -Path ~/icaro/env.ps1 -Value "`$env:ICARO_HOME = `"~/icaro`""
Add-Content -Path ~/icaro/env.ps1 -Value "New-Alias -Name `'icaro`' -Value `'java -jar ~/icaro/cli/entrypoint.jar`'"

if (-not(Select-String -Path $profilePath -Pattern ". ~/icaro/env.ps1" -Quiet))
{
    Add-Content -Path $profilePath -Value ". ~/icaro/env.ps1"
}
. $profilePath

Invoke-WebRequest -Verbose -Uri "https://github.com/icaroland/cli-entrypoint/releases/latest/download/entrypoint.jar" -OutFile "~/icaro/cli/entrypoint.jar"

function downloadLastVersion
{
    param (
        $repoName,
        $icaroTargetFolder
    )

    $repoName, $icaroTargetFolder

    #    $lastVersion = ""
    #
    #    try
    #    {
    #        $lastVersionUrl = (Invoke-WebRequest -Uri "https://github.com/icaroland/$repoName/releases/latest" -MaximumRedirection 0 -ErrorAction:SilentlyContinue).Headers.Location
    #        $lastVersion = Split-Path -Path $lastVersionUrl -Leaf
    #    }
    #    catch
    #    {
    #        $lastVersion = Split-Path -Path $_.Exception.Response.Headers.Location -Leaf
    #    }
    #
    #    Invoke-WebRequest -Verbose -Uri "https://github.com/icaroland/$repoName/releases/download/$lastVersion/$lastVersion.jar" -OutFile "~/icaro/$icaroTargetFolder/$lastVersion.jar"

}

downloadLastVersion("cli-core", "cli/core")

downloadLastVersion("lang", "lang")

Get-ChildItem -Path '~/icaro' -Recurse | Format-List -Property FullName
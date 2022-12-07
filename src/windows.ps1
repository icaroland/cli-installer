"starting to install Icaro!"

$JavaVersion = 0

try
{
    $JavaVersion = [int](Get-Command jav | Select-Object -ExpandProperty Version | Select-Object -ExpandProperty Major)
}
catch
{
    throw "java 11+ is required to install Icaro!"
}

if ($JavaVersion -lt 11)
{
    throw "Error: the java version in use should be 11+, current: $JavaVersion"
}

$JavaVersion


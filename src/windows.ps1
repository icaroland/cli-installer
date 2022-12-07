"starting to install Icaro!"

$JavaVersion = [int](Get-Command java | Select-Object -ExpandProperty Version | Select-Object -ExpandProperty Major)

If ($JavaVersion -ne $null)
{
    throw "java 11+ is required to install Icaro!"
}


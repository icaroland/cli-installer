#"starting to install Icaro!"
#
#$JavaVersion = 0
#
#try
#{
#    $JavaVersion = [int](Get-Command java | Select-Object -ExpandProperty Version | Select-Object -ExpandProperty Major)
#}
#catch
#{
#    throw "java 11+ is required to install Icaro!"
#}
#
#if ($JavaVersion -lt 11)
#{
#    throw "Error: the java version in use should be 11+, current: $JavaVersion"
#}
#
#Get-ChildItem -Path ~/icaro -Recurse | Remove-Item -force -recurse
#Remove-Item ~/icaro -ErrorAction SilentlyContinue
#New-Item -Path "~/" -Name "icaro" -ItemType "directory"
#
#new-item -type file -path $profile -force
##[System.Environment]::SetEnvironmentVariable('ICARO_HOME', '~/icaro', [System.EnvironmentVariableTarget]::Machine)
#. $profile
##$Env:ICARO_HOME = "~/icaro"
##$Env:ICARO_HOME

Get-Content -Path $profile
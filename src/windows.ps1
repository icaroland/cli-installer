"starting to install Icaro!"

#If ((Get-Command java | Select-Object -ExpandProperty Version | Select-Object Major).toString() -ne $null)
#{
#    $OutlookAccounts | Sort-Object -Property Size_MB -Descending | out-file c:\test.txt;
#}

(Get-Command java | Select-Object -ExpandProperty Version | Select-Object -ExpandProperty Major).toString()

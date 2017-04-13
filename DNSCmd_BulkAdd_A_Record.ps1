Param(
  [string]$Zone,
  [string]$DnsServer,
  [string]$DiffFile,
  [string]$logfile
  
)

#Este script sirve para agregar de manera masiva los registros descriptos en un archivo .csv
#
#Utilización:
#
# .\DNSCmd_BulkAdd_A_Record.ps1 -Zone contoso.com -DnsServer srvdc1.contoso.com -DiffFile "C:\GitHub\DNS\FindDiff\Diff.csv" -LogFile "C:\GitHub\DNS\FindDiff\log.txt"

#variables para probar los parametros
#$logfile = "c:\temp\Add_records_list.txt"
#$DiffFile = "C:\GitHub\DNS\FindDiff\Diff.csv"
#$DnsServer = "srvdc1.contoso.com"
#$Zone = "contoso.com"

#Ejemplo del output que debe tener el csv file
####################### CSV SETTINGS ###################################
# Name	    Type      Data	            Timestamp                      #
# srvap1	Host (A)  161.131.192.223	?4/?10/?2017 5:00:00 AM        #
# srvap2	Host (A)  161.131.192.228	?4/?5/?2017 7:00:00 AM         #
########################################################################

clear-host

# Utils 1
$y = "yellow"
$w = "white"
$c = "cyan"
$g = "green"

# DNS Variables 
$type       = "A"

# Read the csv file 

$list    = $DiffFile 
$lcount  = (Import-CSV -Path $list).count
$list_1  = Import-CSV -Path $list 

# (0)
write-host -f $w "===========$d============="
write-host -f $c " Importing Records        "
write-host -f $w "===========$d============="
write-host $null

# (1)
Write-host -f $y "1_.Checking to make sure CSV file exist"

# Check to make sure csv file exit if not
If (Test-Path $list ){
  Write-host -f $y " (a)_Located CSV File"
}Else{
  write-host -f $r " (b)_CSV File cannot be located"
  write-host -f $r " (c)_Script will exit in 5 seconds"
  exit
}
write-host $null
Write-host -f $y "a_.Lcoated $Lcount DNS Records"
Write-host -f $y "b_.Will read first 3 records"

# Reading first record to show CSV headers
Write-host "##############CSV Columns#######################"
$list_1 | Select-Object -First 1 | ft -AutoSize
Write-host "################################################"
write-host $null

# (2)
Write-host -f $y "2_.Starting Bulk DNS change"
$list_1 | ForEach{ 

# Adding Records
#<paratz> In my code I won't add a PTR Record
#dnscmd.exe $_.dnsserver /RecordAdd $_.zone $_.name /createPTR $_.type $_.IP 

#And in my code I need to Age this record:

dnscmd.exe $DnsServer /RecordAdd $Zone $_.Name /Aging $Type $_.Data

# Providing Information 
write-Host -f $g  "$("$_.name") added successfully on $($_."Zone")" 

# write to Output results
write "$("$_.name") added successfully" | Out-File -Append $logfile
}

write-host $null
# (3)
Write-host -f $y "3_.Total $Lcount DNS Records Added."
Write-host -f $y "4_.Log file is located on "
Write-host -f $w "$logfile"

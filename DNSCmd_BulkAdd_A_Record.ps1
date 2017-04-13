####################### CSV SETTINGS ##################################
# HostName  IP            type   Zone         dnsserver               #
# Server1   10.11.12.101   A     contoso.com   srvdc1.contoso.com    #
# Server2   10.11.12.102   A     contoso.com   srvdc1.contoso.com    #
# Server3   10.11.12.103   A     contoso.com   srvdc1.contoso.com    #
# Server4   10.11.12.104   A     contoso.com   srvdc1.contoso.com    #
# Server5   10.11.12.105   A     contoso.com   srvdc1.contoso.com    #
#                                                                     #
#######################################################################

clear-host

# Utils 1
$y = "yellow"
$w = "white"
$c = "cyan"
$g = "green"

# DNS Variables 
$zone       = "contoso.com"
$type       = "A"
$Dns_Server = "srvdc1.contoso.com"
$d          = "DNS Records"

# Read the csv file 
$logfile = "c:\temp\dns\Add_records_list.txt"
$list    = "c:\temp\dns\DNS_Bulk_import.csv" 
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

dnscmd.exe $_.dnsserver /RecordAdd $_.zone $_.name /Aging $_.type $_.IP 

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

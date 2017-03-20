Param(
  [string]$DomainName,
  [string]$InputLogPath,
  [string]$DNSServerName
)

#Example Run: .\Disable-ScavengingOnRecord.ps1 -DNSServerName dc01.contoso.com -DomainName contoso.com -InputLogPath C:\DNSData\Log.txt

Start-Transcript

Get-Content -Path $InputLogPath | ForEach-Object {  

$DNSRecord = "$_.$DomainName"

#Cambiar por Nombre de Registro
$record = Get-WmiObject -ComputerName $DNSServerName -Namespace 'root\MicrosoftDNS' -Class MicrosoftDNS_AType -filter "OwnerName='$DNSRecor'"
$record.timeStamp = 0 # checkbox is unchecked,  3579756 is checked
$record.psbase.put()

}

Stop-Transcript

#Cambiar por IP
#$record = Get-WmiObject -ComputerName dnsServerName -Namespace 'root\MicrosoftDNS' -Class MicrosoftDNS_AType -filter "IPAddress='192.168.168.1'"
#$record.timeStamp = 0 # checkbox is unchecked,  3579756 is checked
#$record.psbase.put()



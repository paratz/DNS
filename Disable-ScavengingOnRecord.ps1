
#Cambiar por IP
$record = Get-WmiObject -ComputerName dnsServerName -Namespace 'root\MicrosoftDNS' -Class MicrosoftDNS_AType -filter "IPAddress='192.168.168.1'"
$record.timeStamp = 0 # checkbox is unchecked,  3579756 is checked
$record.psbase.put()

#Cambiar por Nombre de Registro
$record = Get-WmiObject -ComputerName dnsServerName -Namespace 'root\MicrosoftDNS' -Class MicrosoftDNS_AType -filter "OwnerName='TMG.fabrikam.com.ar'"
$record.timeStamp = 0 # checkbox is unchecked,  3579756 is checked
$record.psbase.put()

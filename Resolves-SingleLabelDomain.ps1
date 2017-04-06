# This script will input a list of names, and then it will perform a dns lookup for different names:
# zone name = the name on the list + dnssuffix
# www name = the zone name with www. at the beginning of the string
# intranet name = the name on the file, with a domain name appended
#
# example:
#
# .\Resolves-SingleLabelDomain.ps1 -InputLogPath C:\temp\zones.txt -OutputLogPath C:\temp\Results.csv -DominName contoso.com -DnsSuffix bg
#
# if the file zones.txt contains 2 lines: "domain1" and "domain2", it will resolve the following names:
#
# domain1.bg
# www.domain1.bg
# domain1.contoso.com
# domain2.bg
# www.domain2.bg
# domain2.contoso.com
#
# and it will sabe the results to file "Results.csv"

Param(
  
  #Inputlog path is a file that lists the single label name for the zone
  [string]$InputLogPath,

  [string]$OutputLogPath,

  #Domain name is the domain that will be appended to resolve the shortname
  [string]$DomainName,

  #this is the top level domain name that needs to be added to the single label domain
  [string]$dnssuffix

)

Start-Transcript

Get-Content -Path $InputLogPath | ForEach-Object {  

$FQDNName = "$_.$dnssuffix"

Resolve-DnsName -Name $FQDNName | Export-Csv -Path $OutputLogPath -Append -NoTypeInformation -Force

$wwwURL = "www.$_.$dnssuffix"

Resolve-DnsName -Name $wwwURL | Export-Csv -Path $OutputLogPath -Append -NoTypeInformation -Force

$IntranetName = "$_.$DomainName"

Resolve-DnsName -Name $IntranetName | Export-Csv -Path $OutputLogPath -Append -NoTypeInformation -Force

}

Stop-Transcript
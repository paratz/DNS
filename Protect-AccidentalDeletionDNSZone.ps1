$DomainDN = "DC=contoso,DC=com"

#Para corroborar
Get-ADObject -Filter ‘ObjectClass -like “dnszone”‘ -SearchScope Subtree -SearchBase “DC=DomainDnsZones,$DomainDN” -properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $False} | fl 
Get-ADObject -Filter ‘ObjectClass -like “dnszone”‘ -SearchScope Subtree -SearchBase “ForestDnsZones,$DomainDN” -properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $False} | fl

#Para solucionar
Get-ADObject -Filter ‘ObjectClass -like “dnszone”‘ -SearchScope Subtree -SearchBase “DC=DomainDnsZones,$DomainDN” -properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $False} | Set-ADObject –ProtectedFromAccidentalDeletion $true
Get-ADObject -Filter ‘ObjectClass -like “dnszone”‘ -SearchScope Subtree -SearchBase “ForestDnsZones,$DomainDN” -properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $False} | Set-ADObject –ProtectedFromAccidentalDeletion $true

#Para corroborar nuevamente
Get-ADObject -Filter ‘ObjectClass -like “dnszone”‘ -SearchScope Subtree -SearchBase “DC=DomainDnsZones,$DomainDN” -properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $False} | fl 
Get-ADObject -Filter ‘ObjectClass -like “dnszone”‘ -SearchScope Subtree -SearchBase “ForestDnsZones,$DomainDN” -properties ProtectedFromAccidentalDeletion | where {$_.ProtectedFromAccidentalDeletion -eq $False} | fl

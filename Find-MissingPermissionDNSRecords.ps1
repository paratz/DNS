Param(
  [string]$DomainName,
  [string]$ADIntegrationType,
  [string]$LogPath

)

#Este script busca
#Example Run: .\Find-MissingPermissionDNSRecords.ps1 -DomainName fabrikam.com.ar -ADIntegrationType Domain -LogPath C:\DNSData\Log.txt

$ErrorActionPreference = "SilentlyContinue"

#$DomainName = ‘fabrikam.com.ar’
#$AdIntegrationType = ‘Domain’

$DomainDn = (Get-AdDomain).DistinguishedName
$DomainNetbios = (Get-AdDomain).NetBIOSName

#$ADObject = Get-ADObject "DC=$DNSRecord,DC=$DomainName,CN=MicrosoftDNS,DC=$AdIntegrationType`DnsZones,$DomainDn"

$ADObject = Get-ChildItem "AD:DC=$DomainName,CN=MicrosoftDNS,DC=$AdIntegrationType`DnsZones,$DomainDn"

$ADObject | ForEach-Object {

if ($SamAccountName = (Get-ADComputer $_.Name -Properties SamAccountName).SAMAccountName) {

        $RegistroAChequear = "AD:" + $_.DistinguishedName

        $Acl = Get-Acl -Path $RegistroAChequear

        If (!($Acl.Access | Where-Object {$_.IdentityReference -eq $DomainNetBios + "\" + $Samaccountname})) {
 
           Write-Host "No existe ACL - " + $_.Name
           $_.Name | Out-File -FilePath $LogPath -Append
 
        }
 
        else {
   
           Write-Host "Existe ACL - " + $_.Name
 
        }
    }

}

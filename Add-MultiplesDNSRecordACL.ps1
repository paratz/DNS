Param(
  [string]$DomainName,
  [string]$ADIntegrationType,
  [string]$LogPath
)

#Example Run: .\Add-MultiplesDNSRecordACL.ps1 -DomainName fabrikam.com.ar -ADIntegrationType Domain -LogPath C:\DNSData\Log.txt

Start-Transcript

$DomainDn = (Get-AdDomain).DistinguishedName

Get-Content -Path $LogPath | ForEach-Object {  

$ADObject = Get-ADObject "DC=$_,DC=$DomainName,CN=MicrosoftDNS,DC=$AdIntegrationType`DnsZones,$DomainDn"

$Sid = (Get-ADComputer $_ -Properties ObjectSID).ObjectSID.Value

$ComputerAccount = New-Object System.Security.Principal.SecurityIdentifier($Sid)

$ModifyRights = 'CreateChild, DeleteChild, ListChildren, ReadProperty, DeleteTree, ExtendedRight, Delete, GenericWrite, WriteDacl, WriteOwner'

$Right = "Allow"

$AccessRule = New-Object System.DirectoryServices.ActiveDirectoryAccessRule($ComputerAccount, $ModifyRights, $Right)

$Acl = Get-Acl -Path "AD:$ADObject"

$Acl.AddAccessRule($AccessRule)

Set-Acl -Path "ActiveDirectory:://RootDSE/$($AdObject.DistinguishedName)" -AclObject $Acl

}
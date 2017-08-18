$count = 0

$var = get-wmiobject -query "select * from win32_service where name = 'dns'" 
if ($var -ne $null)
{
  if ($var.state.tolower() -eq "running")
  {
    [array] $global:badcnamedomains = $null
    $var = get-wmiobject -namespace "root\microsoftdns"  -query "select * from microsoftdns_zone"
    if ($var -ne $null)
    {  
      foreach ($var2 in $var)
     {
        $query = "select * from microsoftdns_cnametype where containername = '" + $var2.name + "'" 
        $var3 = get-wmiobject -namespace "root\microsoftdns" -query $query | where {$_.ownername -eq $var2.name}
        if ($var3 -ne $null)
        {
          $count += 1
          $global:badcnamedomains += $var3.domainname
        }
      }
    }
    else
    {
      write-host "No zones returned"
    }
  }
} 
if ($count -gt 0)
{
  write-host "Total number of zones found: $count"
  write-host "The zones are:"
  write-host $global:badcnamedomains 
}
elseif ($count -eq 0)
{
  write-host "No zones found with the issue"
}
$count = $null
$global:badcnamedomains = $null

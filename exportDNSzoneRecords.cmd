REM https://blogs.technet.microsoft.com/networking/2008/05/21/export-dns-records-to-excel-to-read-time-stamps-and-static-records/

dnscmd /enumrecords contoso.com @ /Type A /additional /continue > c:\dnsdata\Adns_contoso.com.csv
dnscmd /enumrecords contoso.com @ /Type AAAA /additional /continue > c:\dnsdata\AAAAdns_contoso.com.csv
dnscmd /enumrecords contoso.com @ /Type ALL /additional /continue > c:\dnsdata\ALLdns_contoso.com.csv 
changetocsv.vbs c:\dnsdata\ALLdns_contoso.com.csv  
openexcel.vbs c:\dnsdata\ALLdns_contoso.com.csv 
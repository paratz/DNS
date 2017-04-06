#Este script compara los registros del primer archivo .csv contra el segundo,
#identidica si dos registros comparten la misma ip, pero no el mismo nombre
#es util para encontrar aquellas direcciones IP que fueron reutilizadas con otro nombre


$CandidatosABorrar = Import-Csv -Path "C:\DNSData\CandidatosQueRespondenIP.csv"

$ZonaDNS = Import-Csv -Path "C:\DNSData\ExportZona14Marzo.csv"

foreach($itemaborrar in $CandidatosABorrar)
    {
    
        foreach($registro in $ZonaDNS)
        {

        If (($itemaborrar.IP -eq $registro.IP) -and ($itemaborrar.Host -ne $registro.Host))

            {

             $itemaborrar.Host + "comparte la misma IP que" + $registro.Host

            } 

        }
    }
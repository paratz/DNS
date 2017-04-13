Param(
  [string]$BeforeFile,
  [string]$AfterFile,
  [string]$DiffFile
)

# este script compara dos archivos de zona exportada y los registros A que no están en el 2do archivo los
# guarda en un nuevo archivo llamado diff.csv
# utilización
#
# .\Find-ZoneExportDifferences.ps1 -BeforeFile "C:\GitHub\DNS\FindDiff\Antes.csv" -AfterFile "C:\GitHub\DNS\FindDiff\Despues.csv" -DiffFile "C:\GitHub\DNS\FindDiff\Diff.csv"


#Variables para hacer pruebas
#$Beforefile = "C:\GitHub\DNS\FindDiff\Antes.csv"
#$Afterfile = "C:\GitHub\DNS\FindDiff\Despues.csv"
#$Difffile = "C:\GitHub\DNS\FindDiff\Diff.csv"

$Antes = Import-Csv -Path $BeforeFile
$Despues = Import-Csv -Path $AfterFile

ForEach($i in $Antes)
{
    ForEach ($o in $Despues)
    {
        if($i.Name -eq $o.Name){
            $Existe = $Existe + 1
        }
    }

    if($Existe -eq 0 -and $i.Type -eq "Host (A)") {
    
    $i | Export-Csv -Path $DiffFile -Append -NoTypeInformation

    $Existe = 0

    } 
    
    $Existe = 0
}
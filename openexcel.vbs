Const ForReading = 1
Const ForWriting = 2
strfile= wscript.Arguments(0)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strfile, ForReading)

Do Until objFile.AtEndOfStream
    strLine = objFile.ReadLine
If not strLine = "" Then
    arrItems = Split(strLine, ",")

intDatevalue = 0

If not(arrItems(1))="" Then

    intDateValue = (arrItems(1) - 2620914.50)/24
 End if
   
    intItems = Ubound(arrItems)
    ReDim Preserve arrItems(intItems + 1)
    If intDateValue > 0 Then
        arrItems(intItems + 1) = intDateValue
    Else
        arrItems(intItems + 1) = ""
    End If
    strNewLine = Join (arrItems, ",")
    strNewText = strNewText & strNewLine & vbCrLf
End If 
Loop

objFile.Close

Set objFile = objFSO.OpenTextFile(strfile, ForWriting)
objFile.Write strNewText
objFile.Close

Set objExcel = CreateObject("Excel.Application")
objExcel.Visible = True

Set objWorkbook = objExcel.Workbooks.Open(strfile)
Set objRange = objExcel.Cells(1, 6)
Set objRange = objRange.EntireColumn

objRange.NumberFormat = "m/d/yyyy hh:mm:ss AM/PM"
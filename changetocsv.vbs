Const ForReading = 1
Const ForWriting = 2

strFileName = Wscript.Arguments(0)

Set objFSO = CreateObject("Scripting.FileSystemObject")
Set objFile = objFSO.OpenTextFile(strFileName, ForReading)

strText = objFile.ReadAll
objFile.Close
strNewText = Replace(strText, " [Aging:", ",")
strNewText1 = Replace(strNewText, "] ", ",")

Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
objFile.WriteLine strNewText1
objFile.Close

'please modify Rtype array as per the record requirements

Rtype = Array("A", "SRV", "NS", "SOA","MX","CNAME")

For i = 0 To UBound(Rtype)
rrtype = " "+Rtype(i) +"    "

Set objFile = objFSO.OpenTextFile(strFileName, ForReading)

strText = objFile.ReadAll
objFile.Close
strNewText = Replace(strText, rrtype, ","+Rtype(i)+",")

Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
objFile.WriteLine strNewText
objFile.Close    

Next

Set objFile = objFSO.OpenTextFile(strFileName, ForReading)

strText = objFile.ReadAll
objFile.Close
strNewText = Replace(strText, " ", ",,")

Set objFile = objFSO.OpenTextFile(strFileName, ForWriting)
objFile.WriteLine strNewText
objFile.Close
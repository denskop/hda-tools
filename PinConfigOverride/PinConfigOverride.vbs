'----------------------------------------------------------------------
' Script Name  : PinConfigOverride.vbs
' Author       : Grisno
' Created on   : 07/09/2014
' Created on   : 07/09/2014
' Purpose      : HDA Verb Converter
' Version      : 1.10
'---------------------------------------------------------------------
'http://msdn.microsoft.com/en-us/library/aa265341(v=vs.60).aspx

On Error Resume Next

Const ForReading = 1
Const TristateUseDefault = -2

If WScript.Arguments.Named.Count > 0 Then
	If WScript.Arguments.Named.Exists("input") Then
		strIn = WScript.Arguments.Named("input")
		Else
		strIn = "PinConfigOverride.reg"
	End If
	If WScript.Arguments.Named.Exists("output") Then
		strOut = WScript.Arguments.Named("output")
		Else
		strOut = "PinConfigOverride.txt"
	End If
	Else
	strIn = "PinConfigOverride.reg"
	strOut = "PinConfigOverride.txt"
End If

Set oFso = CreateObject("Scripting.FileSystemObject")
Set oTextFile = oFso.GetFile(oFso.GetParentFolderName(WScript.ScriptFullName) & "\" & strIn).OpenAsTextStream(ForReading, TristateUseDefault)

Wscript.Echo "HDA Verb Converter" & vbCrLf
Do Until oTextFile.AtEndOfStream
    strLine = oTextFile.Readline
    arrLine = Split(strLine, ":")
	If UBound(arrLine) > 0 Then
		arrData = Split(Trim(arrLine(1)), ",")
		If InStr(arrLine(0), "NumVerbs") = 0 Then
			strData = strData & arrData(3) & arrData(2) & arrData(1) & arrData(0) & " "
		End If
	End If
Loop

Wscript.Echo "<" & Trim(UCase(strData)) & ">"

Set oTextFile = Nothing
Set oFso = Nothing
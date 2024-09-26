' Basic-Plus Converter
' Translate programs written in Digital Equipent Corporation's Basic-Plus Programming Language
' Note: Automated translation may not convert everything



'If the program won't do graphics or window forms then next line may be uncommented
'$Console:Only
Option _Explicit
' Used to define constants for OPEN/SAVE dialog boxes
' $Include:'L:\Programming\$LIBRARY\Common_Dialog_Prefix.bi'
' Defines all error messages
' $Include:'L:\Programming\$LIBRARY\ERRORS.bi'

' Misc definitions
Const FALSE = 0
Const TRUE = Not FALSE


' Program Options
Dim Interactive As _Byte ' Is program in interactive mode?

' Used by open dialog
Dim Filter$, Flags&, Hwnd&

' File input/output
Const InFnum = 1, OUTFNum = 5
Dim InFN$, OutFN$
Dim Shared As _Unsigned _Integer64 FSize
Dim As Long Limit
ReDim As _Unsigned _Byte Fi(0)    ' Will be resized once file is open

' Get commands to use if batch mode
Limit = _CommandCount
' Non-interactive mode
If Limit <> 0 Then
Else

End If





















Print "Enter name to save file as:"

Filter$ = "All files (*.*)|*.*"
Flags& = OFN_OVERWRITEPROMPT + OFN_NOCHANGEDIR '   add flag constants here
OutFN$ = GetSaveFileName$("Enter name to copy file " + InFN$ + " to:", ".\", Filter$, 1, Flags&, Hwnd&)

If OutFN$ = "" Then
    Print "Save cancelled."
    GoTo Done
End If

On Error GoTo Error3

Open OutFN$ For Binary Access Write As #OUTFNum

On Error GoTo Error4

Put #OUTFNum, , Fi()
Close #OUTFNum
Print "File "; InFN$; " successfully copied to "; OutFN$; "."



Done:

End

Error1:
Print "?File "; InFN$; " could not be opened."
Resume Done

Error2:
Print "?File "; InFN$; " could not be read."
Resume Done

Error3:
Print "?Output File "; OutFN$; " could not be opened."
Resume Done

Error4:
Print "?Output File "; OutFN$; " could not be written."
Resume Done











ReadFile:
' Begin Processing - read entire file
On Error GoTo Error1
Open InFN$ For Binary Access Read As #InFnum

On Error GoTo Error2

' Find out how big the file is, and resize the array to fit
FSize = LOF(InFnum)

ReDim As _Unsigned _Byte Fi(FSize)

' Load the file in its entirety to array Fi

Get #InFnum, , Fi()
Close #InFnum

Print "File "; InFN$; " read, size"; Using "######## bytes."; FSize;

Return

' Process command-line options
Batch:

' Process file names and options


InFN$ = Command$(1)

Print "Attempting to open "; InFN$

Return



' ----- Sub/Functions beyond this point
' Routines for file open/file save
'$Include:'L:\Programming\$LIBRARY\Common_Dialog_Suffix.bi'



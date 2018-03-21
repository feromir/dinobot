Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)
Opt("SendKeyDelay", 0)
Opt("SendKeyDownDelay", 500)

$scan_x0 = 75
$scan_y0 = 275

$scan_w = 120
$scan_h = 30
$scan_step_count = 0

$bgColor = 0xF7F7F7
$fgColor = 0x535353

$hWnd = WinGetHandle("chrome://dino/ - Google Chrome")
If @error <> 0 Then
   MsgBox(16, "Error", "Unable to find chrome://dino/ window")
   Exit
Endif

WinActivate($hWnd)
WinMove($hWnd, "", 100, 100, 637, 524, 0)

While 1
   $bgColor = PixelGetColor(5, 113, $hWnd)
   $fgColor = PixelGetColor(47, 296, $hWnd)
   If $fgColor == $bgColor Then
	  ; jumping
	  ContinueLoop
   EndIf
   $c = CheckObstacle()
   If $c Then
	  Jump()
   EndIf
WEnd

Func Jump()
   Send("{UP}")
EndFunc

Func WriteLog($msg)
   ConsoleWrite($msg & @CRLF)
EndFunc


Func CheckObstacle()
   $p = PixelSearch($scan_x0, $scan_y0, $scan_x0 + $scan_w, $scan_y0 + $scan_h, $fgColor, 0, 1, $hWnd)
   If @error = 1 Then
	  Return False
   Else
	  WriteLog($p[0] & "," & $p[1])
	  Return True
   EndIf
EndFunc
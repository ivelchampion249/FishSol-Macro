#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
Gui, +AlwaysOnTop +LastFound
Gui, Font, s11 bold
Gui, Add, Text,, Window Mode Changer
Gui, Font
Gui, Add, Button, x10 gWindowed w85, WINDOW
Gui, Add, Button, x+10 yp gFullscreen w85, FULLSCREEN

Gui, Font, s11 bold
Gui, Add, Text,x10 y+10, Window Size Changer
Gui, Font
; Gui, Add, Button, gsetRes1360x786 w180,1360x768p
Gui, Add, Button, gsetRes786 w180,1366x768p
Gui, Add, Button, gsetRes1080 w180,1080p
Gui, Add, Button, gsetRes1440 w180,1440p

Gui, Font, s11 bold
Gui, Add, Text, y+10, Mouse Coord Checker
Gui, Font
Gui, Add, Edit, vX w85, 0
Gui, Add, Edit, vY x+10 w85, 0
Gui, Add, Button, x10 gMoveMouseHere w180, MOVE MOUSE
Gui, Font, s8 Normal c0xAAAAAA
Gui, Add, Text, , Ctrl+Shift+C to get current`n      mouse coords (OUT APP)
Gui, Add, Text, yp+28, Ctrl+Shift+V to use clipboard coords`n      in MOVE MOUSE (IN APP)
app_X := A_ScreenWidth  - 206
app_Y := A_ScreenHeight - 440
Gui, show, w200 x%app_X% y%app_Y%, SetResolution
Return

MoveMouseHere:
    Gui, Submit, nohide
    MouseMove, %X%, %Y%
return

Windowed:
    WinSet, Style, +0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinActivate, ahk_exe RobloxPlayerBeta.exe
return

Fullscreen:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinActivate, ahk_exe RobloxPlayerBeta.exe
return

;unused
; setRes1360x786:
;     WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
;     WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,1360,768
; return

; set resolution and fullsccren the application
setRes786:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,1366,768
    WinActivate, ahk_exe RobloxPlayerBeta.exe
return

setRes1080:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,1920,1080
    WinActivate, ahk_exe RobloxPlayerBeta.exe
return

setRes1440:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,2560,1440
    WinActivate, ahk_exe RobloxPlayerBeta.exe
return

;ctrl+shift+v easy paste for mouse move
#IfWinActive, SetResolution
^+V::
    if RegExMatch(Clipboard, "(\d+), (\d+)", out)
    {
        GuiControl, , X, % out1
        GuiControl, , Y, % out2
    }
Return

; ctrl+shift+c to get current mouse coords
^+C::
    MouseGetPos, posx, posy
    Clipboard := posx ", " posy
Return

GuiClose:
ExitApp
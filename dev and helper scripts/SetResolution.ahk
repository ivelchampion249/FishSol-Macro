#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
gui, new, AlwaysOnTop
gui, Add, Button, gsetRes786 w180,768p
gui, Add, Button, gsetRes1080 w180,1080p
gui, Add, Button, gsetRes1440 w180,1440p
gui, show, w200
Return

setRes786:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,1366,768
return

setRes1080:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,1920,1080
return

setRes1440:
    WinSet, Style, -0xC40000, ahk_exe RobloxPlayerBeta.exe
    WinMove, ahk_exe RobloxPlayerBeta.exe,,0,0,2560,1440
return

GuiClose:
ExitApp
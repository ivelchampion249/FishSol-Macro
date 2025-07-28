; ALL credits go to ivelchampion249 or .ivelchampion249._30053 on Discord for making the whole script!
; Credits to maxstellar for adding GUI, patch fixes, and 1440p support.
; Special thanks to cresqnt and x2_c for the auto-sell idea!

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
iniFilePath := A_ScriptDir "\settings.ini"

res := "1080p"
if (FileExist(iniFilePath)) {
    IniRead, tempRes, %iniFilePath%, "Macro", "resolution"
    if (tempRes != "ERROR")
    {
        res := tempRes
    }
}

; GUI
Gui, Add, Tab, x5 y5 w400 h150 vTabs, Macro|Resolution|Credits

Gui, Tab, 1
Gui, Add, Text,, Use 100`% scaling, and Roblox in fullscreen.
Gui, Add, Button, gStartScript, F1 - Start
Gui, Add, Button, x+5 gPauseScript, F2 - Pause
Gui, Add, Button, x+5 gCloseScript, F3 - Stop

Gui, Tab, 2
Gui, Add, Text,, Choose your resolution!
Gui, Add, DropDownList, vResolution gSelectRes, 1080p|1440p

Gui, Tab, 3
Gui, Font, bold
Gui, Add, Text,, Credits!
Gui, Font, norm
Gui, Add, Text,, ivelchampion249 - Creator + Main Developer
Gui, Add, Text,, maxstellar - Developer
Gui, Add, Text,, Special thanks to cresqnt and x2_c for the auto-sell idea!

Gui, Tab
Gui, Show, w400 h150, fishSol v1.1

GuiControl, Choose, Resolution, %res%
return

GuiClose:
ExitApp

toggle := false
firstLoop := true

F1::
if (!res) {
    res := "1080p"
}
if (!toggle) {
    toggle := true
    IniWrite, %res%, %iniFilePath%, "Macro", "resolution"
    WinActivate, ahk_exe RobloxPlayerBeta.exe ;
    if (res = "1080p") {
        SetTimer, DoMouseMove, 100
    } else if (res = "1440p") {
	SetTimer, DoMouseMove2, 100
    } else {
        MsgBox, Something went wrong with resolution settings.
	ExitApp
    }
}
Return

F2::
toggle := false
firstLoop := true
SetTimer, DoMouseMove, Off
SetTimer, DoMouseMove2, Off
ToolTip
Return

F3::ExitApp

DoMouseMove:
if (toggle) {
    ; Wrap the entire script in a loop to make it repeat
    Loop {
        if (!toggle) {
            break
	}
	MouseMove, 850, 830, 3
        Sleep 300
        MouseClick, Left
	sleep 300
	; Auto-sell
	if (firstLoop == false) {
	    MouseMove, 827, 401, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 589, 801, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 802, 620, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	} else {
	    firstLoop := false
	}
	barColor := 0
	otherBarColor := 0

        ; Check for white pixel
        Loop {
            PixelGetColor, color, 1176, 836, RGB
            if (color = 0xFFFFFF) {
                MouseMove, 950, 880, 3
		; Determine randomized bar color
		Sleep 50
                PixelGetColor, barColor, 955, 767, RGB
                SetTimer, DoMouseMove, Off
                break
            }
            Sleep, 100
            if (!toggle) {
                Return
            }
        }

        ; === PixelSearch loop with 13-second timeout ===
        startTime := A_TickCount
        Loop {
            if (!toggle)
                break
            if (A_TickCount - startTime > 9000)
                break

            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 757, 762, 1161, 782, barColor, 5, Fast RGB

            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
        }

        sleep 300
        MouseMove, 1113, 342, 3
	sleep 700
        MouseClick, Left
        sleep 300
    }
}
Return

DoMouseMove2:
if (toggle) {
    ; Wrap the entire script in a loop to make it repeat
    Loop {
        if (!toggle) {
            break
	}
	MouseMove, 1151, 1111, 3
        Sleep 300
        MouseClick, Left
	sleep 300
	; Auto-sell
	if (firstLoop == false) {
	    MouseMove, 1100, 540, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 790, 1071, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 1112, 808, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	} else {
	    firstLoop := false
	}
	barColor := 0
	otherBarColor := 0

        ; Check for white pixel
        Loop {
            PixelGetColor, color, 1536, 1119, RGB
            if (color = 0xFFFFFF) {
                MouseMove, 1263, 1177, 3
		; Determine randomized bar color
		Sleep 50
                PixelGetColor, barColor, 1261, 1033, RGB
                SetTimer, DoMouseMove, Off
                break
            }
            if (!toggle) {
                Return
            }
        }

        ; === PixelSearch loop with 13-second timeout ===
        startTime := A_TickCount
        Loop {
            if (!toggle)
                break
            if (A_TickCount - startTime > 9000)
                break

            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 1043, 1033, 1519, 1058, barColor, 5, Fast RGB

            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
        }

        sleep 300
        MouseMove, 1457, 491, 3
	sleep 700
        MouseClick, Left
        sleep 300
    }
}
Return

StartScript:
if (!toggle) {
    toggle := true
    WinActivate, ahk_exe RobloxPlayerBeta.exe ;
    if (Resolution == "1080p") {
        SetTimer, DoMouseMove, 100
    } else {
	SetTimer, DoMouseMove2, 100
    }
}
return

PauseScript:
toggle := false
firstLoop := true
SetTimer, DoMouseMove, Off
ToolTip
return

CloseScript:
	ExitApp
return

SelectRes:
Gui, Submit, nohide
res := Resolution
IniWrite, "%res%", %iniFilePath%, "Macro", "resolution"
return
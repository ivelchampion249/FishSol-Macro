; ALL credits go to ivelchampion249 or .ivelchampion249._30053 on Discord for making the whole script!
; Credits to maxstellar for adding GUI, patch and stability fixes, 1440p and 1366x768 support.
; Credits to cresqnt for vastly improving GUI.
; Special thanks to x2_c for the auto-sell idea!

#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
iniFilePath := A_ScriptDir "\settings.ini"
iconFilePath := A_ScriptDir "\icon.ico"
if (FileExist(iconFilePath)) {
    Menu, Tray, Icon, icon.ico
}

res := "1080p"
if (FileExist(iniFilePath)) {
    IniRead, tempRes, %iniFilePath%, "Macro", "resolution"
    if (tempRes != "ERROR")
    {
        res := tempRes
    }
}

Gui, Color, 0x2D2D30
Gui, Font, s12 cWhite Bold, Segoe UI
Gui, Add, Text, x20 y15 w460 h30 Center BackgroundTrans, fishSol v1.3.1

Gui, Font, s9 cWhite Normal, Segoe UI
Gui, Add, GroupBox, x15 y50 w220 h140 cWhite, Control Panel
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x25 y75 w200 h20 BackgroundTrans, Status:
Gui, Add, Text, x75 y75 w140 h20 vStatusText BackgroundTrans c0xFF6B6B, Stopped
Gui, Font, s9 cWhite Normal

Gui, Font, s9 cWhite Bold, Segoe UI
Gui, Add, Button, x25 y100 w60 h30 gStartScript vStartBtn c0x2196F3 +0x8000, Start
Gui, Add, Button, x95 y100 w60 h30 gPauseScript vPauseBtn c0x2196F3 +0x8000, Pause
Gui, Add, Button, x165 y100 w60 h30 gCloseScript vStopBtn c0x2196F3 +0x8000, Stop

Gui, Font, s8 c0xB0B0B0
Gui, Add, Text, x25 y140 w200 h15 BackgroundTrans, Hotkeys: F1=Start, F2=Pause, F3=Stop
Gui, Add, Text, x25 y155 w200 h15 BackgroundTrans, Use 100`% scaling, Roblox fullscreen

Gui, Font, s9 cWhite Normal, Segoe UI
Gui, Add, GroupBox, x250 y50 w220 h140 cWhite, Settings
Gui, Font, s10 cWhite
Gui, Add, Text, x260 y75 w100 h20 BackgroundTrans, Resolution:
Gui, Add, DropDownList, x260 y95 w100 h200 vResolution gSelectRes, 1080p|1440p|1366x768

Gui, Font, s9 c0x4CAF50 Bold
Gui, Add, Text, x260 y130 w200 h20 vResStatusText BackgroundTrans, Ready

Gui, Font, s9 cWhite Normal, Segoe UI
Gui, Add, GroupBox, x15 y200 w455 h140 cWhite, Info

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y225 w80 h20 BackgroundTrans, Runtime:
Gui, Add, Text, x90 y225 w120 h20 vRuntimeText BackgroundTrans c0x4CAF50, 00:00:00

Gui, Add, Text, x30 y250 w80 h20 BackgroundTrans, Cycles:
Gui, Add, Text, x75 y250 w120 h20 vCyclesText BackgroundTrans c0x4CAF50, 0

Gui, Font, s8 c0x555555
Gui, Add, Text, x25 y275 w440 h1 0x10 BackgroundTrans

Gui, Font, s8 c0xB0B0B0 Normal, Segoe UI
Gui, Add, Text, x30 y285 w200 h15 BackgroundTrans, Creator: ivelchampion249
Gui, Add, Text, x30 y300 w200 h15 BackgroundTrans, Developers: maxstellar && cresqnt
Gui, Add, Text, x30 y315 w200 h15 BackgroundTrans, Special thanks: x2_c (auto-sell idea)
Gui, Add, Text, x50 y315 w200 h15 BackgroundTrans, https://www.example.com

Gui, Show, w485 h355, fishSol v1.4

if (res = "1080p") {
    GuiControl, Choose, Resolution, 1
} else if (res = "1440p") {
    GuiControl, Choose, Resolution, 2
} else if (res = "1366x768") {
    GuiControl, Choose, Resolution, 3
} else {
    GuiControl, Choose, Resolution, 1
    res := "1080p"
}
return

GuiClose:
ExitApp

toggle := false
firstLoop := true
startTick := 0
cycleCount := 0

UpdateGUI:
if (toggle) {
    GuiControl,, StatusText, Running
    GuiControl, +c0x4CAF50, StatusText
    GuiControl,, ResStatusText, Active - %res%

    elapsed := A_TickCount - startTick
    hours := elapsed // 3600000
    minutes := (elapsed - hours * 3600000) // 60000
    seconds := (elapsed - hours * 3600000 - minutes * 60000) // 1000
    timeStr := Format("{:02d}:{:02d}:{:02d}", hours, minutes, seconds)
    GuiControl,, RuntimeText, %timeStr%
    GuiControl, +c0x4CAF50, RuntimeText
    GuiControl,, CyclesText, %cycleCount%
    GuiControl, +c0x4CAF50, CyclesText
} else {
    GuiControl,, StatusText, Stopped
    GuiControl, +c0xFF6B6B, StatusText
    GuiControl,, ResStatusText, Ready
}

ManualGUIUpdate() {
    if (toggle) {
        GuiControl,, StatusText, Running
        GuiControl, +c0x4CAF50, StatusText
        GuiControl,, ResStatusText, Active - %res%

        elapsed := A_TickCount - startTick
        hours := elapsed // 3600000
        minutes := (elapsed - hours * 3600000) // 60000
        seconds := (elapsed - hours * 3600000 - minutes * 60000) // 1000
        timeStr := Format("{:02d}:{:02d}:{:02d}", hours, minutes, seconds)
        GuiControl,, RuntimeText, %timeStr%
        GuiControl, +c0x4CAF50, RuntimeText
        GuiControl,, CyclesText, %cycleCount%
        GuiControl, +c0x4CAF50, CyclesText
    } else {
        GuiControl,, StatusText, Stopped
        GuiControl, +c0xFF6B6B, StatusText
        GuiControl,, ResStatusText, Ready
    }
}

F1::
if (!res) {
    res := "1080p"
}
if (!toggle) {
    toggle := true
    if (startTick = "") {
        startTick := A_TickCount
    }
    if (cycleCount = "") {
        cycleCount := 0
    }
    IniWrite, %res%, %iniFilePath%, "Macro", "resolution"
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    ManualGUIUpdate()
    SetTimer, UpdateGUI, 1000
    if (res = "1080p") {
        SetTimer, DoMouseMove, 100
    } else if (res = "1440p") {
	SetTimer, DoMouseMove2, 100
    } else if (res = "1366x768") {
        SetTimer, DoMouseMove3, 100
    }
}
Return

F2::
toggle := false
firstLoop := true
SetTimer, DoMouseMove, Off
SetTimer, DoMouseMove2, Off
SetTimer, DoMouseMove3, Off
SetTimer, UpdateGUI, Off
ManualGUIUpdate()
ToolTip
Return

F3::ExitApp

;1080p
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
	    MouseMove, 515, 805, 3
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
        startWhitePixelSearch := A_TickCount
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
            if (A_TickCount - startWhitePixelSearch > 31000) {
                MouseMove, 1113, 342, 3
                sleep 300
                MouseClick, left
                sleep 300
                StartScript(res)
                Return
            }
            if (!toggle) {
                Return
            }
        }

        ; PixelSearch loop with 9-second timeout
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
        Sleep 700
        /*
	Loop {
            PixelGetColor, color, 1112, 342, RGB
            if (color = 0xFFFFFF) {
                break
            }
            if (!toggle) {
                Return
            }
        }
        */
        MouseClick, Left
        sleep 300
        cycleCount++
    }
}
Return

;1440p
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
	    MouseMove, 685, 1070, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 1067, 831, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	} else {
	    firstLoop := false
	}
	barColor := 0
	otherBarColor := 0

        ; Check for white pixel
        startWhitePixelSearch := A_TickCount
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
            if (A_TickCount - startWhitePixelSearch > 31000) {
                MouseMove, 1457, 491, 3
                sleep 300
                MouseClick, left
                sleep 300
                StartScript(res)
                Return
            }
            if (!toggle) {
                Return
            }
        }

        ; PixelSearch loop with 9-second timeout
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
        /*
	Loop {
            PixelGetColor, color, 1455, 492, RGB
            if (color = 0xFFFFFF) {
                break
            }
            if (!toggle) {
                Return
            }
        }
        */
        MouseClick, Left
        sleep 300
        cycleCount++
    }
}
Return

;786p
DoMouseMove3:
if (toggle) {
    Loop {
        if (!toggle) {
            break
	}
	MouseMove, 589, 589, 3
        Sleep 300
        MouseClick, Left
	sleep 300
	; Auto-sell
	if (firstLoop == false) {
	    MouseMove, 587, 291, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 366, 573, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	    MouseMove, 570, 444, 3
	    sleep 300
	    MouseClick, Left
	    sleep 300
	} else {
	    firstLoop := false
	}
	barColor := 0
	otherBarColor := 0

        ; Check for white pixel
        startWhitePixelSearch := A_TickCount
        Loop {
            ErrorLevel := 0
            PixelSearch, px, py, 866, 593, 865, 593, 0xFFFFFF, 10, Fast RGB
            if (ErrorLevel = 0) {
                MouseMove, 676, 638, 3
		; Determine randomized bar color
		Sleep 50
                PixelGetColor, barColor, 674, 533, RGB
                SetTimer, DoMouseMove, Off
                break
            }
            if (A_TickCount - startWhitePixelSearch > 31000) {
                MouseMove, 817, 210, 3
                sleep 300
                MouseClick, left
                sleep 300
                StartScript(res)
                Return
            }
            if (!toggle) {
                Return
            }
        }

        ; PixelSearch loop with 9-second timeout
        startTime := A_TickCount
        Loop {
            if (!toggle)
                break
            if (A_TickCount - startTime > 9000)
                break

            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 513, 531, 856, 549, barColor, 5, Fast RGB

            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
        }
        sleep 300
        MouseMove, 817, 210, 3
        Sleep 700
        /*
	Loop {
            ErrorLevel := 0
            PixelSearch, px, py, 816, 211, 8616, 211, 0xFEFEFE, 10, Fast RGB
            if (ErrorLevel = 0) {
                break
            }
            if (!toggle) {
                Return
            }
        }
        */
        MouseClick, Left
        sleep 300
        cycleCount++
    }
}
Return

StartScript:
if (!toggle) {
    toggle := true
    if (startTick = "") {
        startTick := A_TickCount
    }
    if (cycleCount = "") {
        cycleCount := 0
    }
    WinActivate, ahk_exe RobloxPlayerBeta.exe
    ManualGUIUpdate()
    SetTimer, UpdateGUI, 1000
    if (res = "1080p") {
        SetTimer, DoMouseMove, 100
    } else if (res = "1440p") {
	SetTimer, DoMouseMove2, 100
    } else if (res = "1366x768") {
        SetTimer, DoMouseMove3, 100
    }
}
return

StartScript(res) {
    if (!toggle) {
        toggle := true
        if (startTick = "") {
            startTick := A_TickCount
        }
        if (cycleCount = "") {
            cycleCount := 0
        }
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        ManualGUIUpdate()
        SetTimer, UpdateGUI, 1000
        if (res = "1080p") {
            SetTimer, DoMouseMove, 100
        } else if (res = "1440p") {
            SetTimer, DoMouseMove2, 100
        } else if (res = "1366x768") {
            SetTimer, DoMouseMove3, 100
        }
    }
    return
}

PauseScript:
toggle := false
firstLoop := true
SetTimer, DoMouseMove, Off
SetTimer, DoMouseMove2, Off
SetTimer, DoMouseMove3, Off
SetTimer, UpdateGUI, Off
ManualGUIUpdate()
ToolTip
return

CloseScript:
ExitApp
return

SelectRes:
Gui, Submit, nohide
res := Resolution
IniWrite, %res%, %iniFilePath%, "Macro", "resolution"
ManualGUIUpdate()
return

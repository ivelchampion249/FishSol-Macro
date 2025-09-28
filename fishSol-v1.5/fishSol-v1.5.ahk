#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
iniFilePath := A_ScriptDir "\settings.ini"
iconFilePath := A_ScriptDir "\img\icon.ico"
if (FileExist(iconFilePath)) {
    Menu, Tray, Icon, %iconFilePath%
}

res := "1080p"
if (FileExist(iniFilePath)) {
    IniRead, tempRes, %iniFilePath%, "Macro", "resolution"
    if (tempRes != "ERROR")
    {
        res := tempRes
    }
}

version := "v1.5"

Random,, A_TickCount
Random, shuffle, 1, 6
Random, messageRand, 1, 10

if (messageRand = 1) {
    randomMessage := "Go catch some fish IRL sometime!"
} else if (messageRand = 2) {
    randomMessage := "Also try FishScope!"
} else if (messageRand = 3) {
    randomMessage := "Also try maxstellar's Biome Macro!"
} else if (messageRand = 4) {
    randomMessage := "Also try MultiScope!"
} else if (messageRand = 5) {
    randomMessage := "Patch notes: Fixed a Geneva Convention violation"
} else if (messageRand = 6) {
    randomMessage := "Patch notes: Removed Herobrine"
} else if (messageRand = 7) {
    randomMessage := "oof"
} else if (messageRand = 8) {
    randomMessage := "Now with 100% more fishing!"
} else if (messageRand = 9) {
    randomMessage := "Gone fishing"
} else {
    randomMessage := "No fish were harmed in the making of this macro"
}

if (shuffle = 1) {
    dev1_name := "maxstellar"
    dev1_discord := "Twitch"
    dev1_role := "Lead Developer"
    dev2_name := "ivelchampion249"
    dev2_discord := ".ivelchampion249._30053 on Discord"
    dev2_role := "Original Creator"
    dev3_name := "cresqnt"
    dev3_discord := "Scope Development (other macros)"
    dev3_role := "Lead Developer"
} else if (shuffle = 2) {
    dev1_name := "maxstellar"
    dev1_discord := "Twitch"
    dev1_role := "Lead Developer"
    dev2_name := "cresqnt"
    dev2_discord := "Scope Development (other macros)"
    dev2_role := "Lead Developer"
    dev3_name := "ivelchampion249"
    dev3_discord := ".ivelchampion249._30053 on Discord"
    dev3_role := "Original Creator"
} else if (shuffle = 3) {
    dev1_name := "cresqnt"
    dev1_discord := "Scope Development (other macros)"
    dev1_role := "Lead Developer"
    dev2_name := "ivelchampion249"
    dev2_discord := ".ivelchampion249._30053 on Discord"
    dev2_role := "Original Creator"
    dev3_name := "maxstellar"
    dev3_discord := "Twitch"
    dev3_role := "Lead Developer"
} else if (shuffle = 4) {
    dev1_name := "cresqnt"
    dev1_discord := "Scope Development (other macros)"
    dev1_role := "Lead Developer"
    dev2_name := "maxstellar"
    dev2_discord := "Twitch"
    dev2_role := "Lead Developer"
    dev3_name := "ivelchampion249"
    dev3_discord := ".ivelchampion249._30053 on Discord"
    dev3_role := "Original Creator"
} else if (shuffle = 5) {
    dev1_name := "ivelchampion249"
    dev1_discord := ".ivelchampion249._30053 on Discord"
    dev1_role := "Original Creator"
    dev2_name := "maxstellar"
    dev2_discord := "Twitch"
    dev2_role := "Lead Developer"
    dev3_name := "cresqnt"
    dev3_discord := "Scope Development (other macros)"
    dev3_role := "Lead Developer"
} else {
    dev1_name := "ivelchampion249"
    dev1_discord := ".ivelchampion249._30053 on Discord"
    dev1_role := "Original Creator"
    dev2_name := "cresqnt"
    dev2_discord := "Scope Development (other macros)"
    dev2_role := "Lead Developer"
    dev3_name := "maxstellar"
    dev3_discord := "Twitch"
    dev3_role := "Lead Developer"
}

dev1_img := ""
dev2_img := ""
dev3_img := ""

if (dev1_name = "ivelchampion249") {
    dev1_img := A_ScriptDir . "\img\Ivel.png"
} else if (dev1_name = "maxstellar") {
    dev1_img := A_ScriptDir . "\img\maxstellar.png"
} else if (dev1_name = "cresqnt") {
    dev1_img := A_ScriptDir . "\img\cresqnt.png"
}

if (dev2_name = "ivelchampion249") {
    dev2_img := A_ScriptDir . "\img\Ivel.png"
} else if (dev2_name = "maxstellar") {
    dev2_img := A_ScriptDir . "\img\maxstellar.png"
} else if (dev2_name = "cresqnt") {
    dev2_img := A_ScriptDir . "\img\cresqnt.png"
}

if (dev3_name = "ivelchampion249") {
    dev3_img := A_ScriptDir . "\img\Ivel.png"
} else if (dev3_name = "maxstellar") {
    dev3_img := A_ScriptDir . "\img\maxstellar.png"
} else if (dev3_name = "cresqnt") {
    dev3_img := A_ScriptDir . "\img\cresqnt.png"
}

Gui, Color, 0x1E1E1E
Gui, Font, s14 cWhite Bold, Segoe UI
Gui, Add, Text, x0 y10 w600 h40 Center BackgroundTrans c0x00D4FF, fishSol v1.5

Gui, Font, s10 cWhite Normal, Segoe UI
Gui, Add, Tab3, x15 y55 w570 h380 vMainTabs gTabChange c0xFFFFFF, Main|About

Gui, Tab, Main
Gui, Font, s9 cWhite Normal, Segoe UI

Gui, Add, GroupBox, x30 y85 w260 h120 cWhite, Control Panel
Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y110 w60 h25 BackgroundTrans, Status:
Gui, Add, Text, x98 y110 w150 h25 vStatusText BackgroundTrans c0xFF4444, ● Stopped

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y140 w70 h35 gStartScript vStartBtn c0x00AA00 +0x8000, Start
Gui, Add, Button, x125 y140 w70 h35 gPauseScript vPauseBtn c0xFFAA00 +0x8000, Pause
Gui, Add, Button, x205 y140 w70 h35 gCloseScript vStopBtn c0xFF4444 +0x8000, Stop

Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x45 y185 w240 h15 BackgroundTrans, Hotkeys: F1=Start - F2=Pause - F3=Stop

Gui, Add, GroupBox, x305 y85 w260 h120 cWhite, Configuration
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x320 y110 w80 h25 BackgroundTrans, Resolution:
Gui, Add, DropDownList, x320 y135 w120 h200 vResolution gSelectRes, 1080p|1440p|1366x768

Gui, Font, s9 c0x00DD00 Bold
Gui, Add, Text, x320 y165 w220 h25 vResStatusText BackgroundTrans, Ready

Gui, Add, GroupBox, x30 y215 w535 h200 cWhite, Live Statistics

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, Text, x50 y245 w100 h30 BackgroundTrans, Runtime:
Gui, Add, Text, x120 y245 w120 h30 vRuntimeText BackgroundTrans c0x00DD00, 00:00:00

Gui, Add, Text, x50 y275 w100 h30 BackgroundTrans, Cycles:
Gui, Add, Text, x102 y275 w120 h30 vCyclesText BackgroundTrans c0x00DD00, 0

Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x50 y310 w500 h20 BackgroundTrans, Requirements: 100`% Windows scaling - Roblox in fullscreen mode
Gui, Add, Text, x50 y330 w500 h20 BackgroundTrans, For best results, make sure you have good internet and avoid screen overlays

Gui, Tab, About
Gui, Font, s14 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y90 w535 h30 Center BackgroundTrans c0x00D4FF, fishSol Development Team

Gui, Add, Picture, x50 y130 w50 h50, %dev1_img%
Gui, Font, s11 cWhite Bold
if (dev1_name = "cresqnt") {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x0088FF gDev1NameClick, %dev1_name%
} else {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x00DD00, %dev1_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y155 w300 h15 BackgroundTrans, %dev1_role%
Gui, Add, Text, x110 y170 w300 h15 BackgroundTrans c0x0088FF gDev1LinkClick, %dev1_discord%

Gui, Add, Picture, x50 y195 w50 h50, %dev2_img%
Gui, Font, s11 cWhite Bold
if (dev2_name = "cresqnt") {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x0088FF gDev2NameClick, %dev2_name%
} else {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x00DD00, %dev2_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y220 w300 h15 BackgroundTrans, %dev2_role%
Gui, Add, Text, x110 y235 w300 h15 BackgroundTrans c0x0088FF gDev2LinkClick, %dev2_discord%

Gui, Add, Picture, x50 y260 w50 h50, %dev3_img%
Gui, Font, s11 cWhite Bold
if (dev3_name = "cresqnt") {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x0088FF gDev3NameClick, %dev3_name%
} else {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x00DD00, %dev3_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y285 w300 h15 BackgroundTrans, %dev3_role%
Gui, Add, Text, x110 y300 w300 h15 BackgroundTrans c0x0088FF gDev3LinkClick, %dev3_discord%

Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y325 w480 h1 0x10 BackgroundTrans

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x50 y340 w200 h20 BackgroundTrans, Special Thanks:
Gui, Font, s9 c0x00DD00 Normal
Gui, Add, Text, x50 y360 w480 h20 BackgroundTrans, x2_c - Auto-sell functionality concept and implementation

Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y385 w480 h1 0x10 BackgroundTrans

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y400 w480 h15 BackgroundTrans, fishSol v1.5 - %randomMessage%

Gui, Show, w600 h450, fishSol v1.5

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

TabChange:
return



UpdateGUI:
if (toggle) {
    GuiControl,, StatusText, ● Running
    GuiControl, +c0x00DD00, StatusText
    GuiControl,, ResStatusText, Active - %res%

    elapsed := A_TickCount - startTick
    hours := elapsed // 3600000
    minutes := (elapsed - hours * 3600000) // 60000
    seconds := (elapsed - hours * 3600000 - minutes * 60000) // 1000
    timeStr := Format("{:02d}:{:02d}:{:02d}", hours, minutes, seconds)
    GuiControl,, RuntimeText, %timeStr%
    GuiControl, +c0x00DD00, RuntimeText
    GuiControl,, CyclesText, %cycleCount%
    GuiControl, +c0x00DD00, CyclesText


} else {
    GuiControl,, StatusText, ● Stopped
    GuiControl, +c0xFF4444, StatusText
    GuiControl,, ResStatusText, Ready
}
return

ManualGUIUpdate() {
    if (toggle) {
        GuiControl,, StatusText, ● Running
        GuiControl, +c0x00DD00, StatusText
        GuiControl,, ResStatusText, Active - %res%

        elapsed := A_TickCount - startTick
        hours := elapsed // 3600000
        minutes := (elapsed - hours * 3600000) // 60000
        seconds := (elapsed - hours * 3600000 - minutes * 60000) // 1000
        timeStr := Format("{:02d}:{:02d}:{:02d}", hours, minutes, seconds)
        GuiControl,, RuntimeText, %timeStr%
        GuiControl, +c0x00DD00, RuntimeText
        GuiControl,, CyclesText, %cycleCount%
        GuiControl, +c0x00DD00, CyclesText


    } else {
        GuiControl,, StatusText, ● Stopped
        GuiControl, +c0xFF4444, StatusText
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

F3::
ExitApp

;1080p
DoMouseMove:
if (toggle) {
    loopCount := 0
    Loop {
        if (!toggle) {
            break
        }

        loopCount++
        if (loopCount > 15) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 1800
        MouseMove, 47, 467, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 382, 126, 3
        sleep 220
        Click, Left
        sleep 220
		Click, WheelUp 80
		sleep 500
		Click, WheelDown 45
		sleep 300
        Send, {w Down}
        Send, {a Down}
        sleep 4150
        Send, {w Up}
        sleep 600
        Send {a Up}
        sleep 200
        Send {w Down}
        sleep 400
        Send {w Up}
        sleep 300
        Send {d Down}
        sleep 180
        Send {d Up
        sleep 150
        Send {w Down}
        sleep 1100
        Send {w Up}
        sleep 300
        Send {s Down}
        sleep 300
        Send {S Up}
        sleep 300
        Send {Space Down}
        sleep 25
		Send {w Down}
        sleep 1200
        Send {Space Up}
		sleep 200
		Send {w Up}
        sleep 300
        Send {e Down}
        sleep 300
        Send {e Up}
        sleep 100
        MouseMove, 956, 803, 3
        sleep 50
        MouseClick, Left
        sleep 50
        MouseClick, Left
        sleep 200
        MouseMove, 956, 938, 3
        sleep 200
        MouseClick, Left
		sleep 800
        loopCount := 0

        while (loopCount < 15) {
            MouseMove, 828, 404, 3
            sleep 200
            MouseClick, Left
            sleep 200
            MouseMove, 512, 804, 3
            sleep 200
            MouseClick, Left
            sleep 300
            MouseMove, 799, 622, 3
            sleep 200
            MouseClick, Left
            sleep 300
            loopCount++
        }

        MouseMove, 1458, 266, 3
        sleep 200
        MouseClick, Left
        sleep 200
        Send, {a Down}
        sleep 1300
        Send, {a Up}
        sleep 75
        Send, {w Down}
        sleep 2670
        Send, {w Up}
        loopCount := 0
    }

        MouseMove, 862, 843, 3
        Sleep 300
        MouseClick, Left
        sleep 300
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
        ; failsafe
        if (A_TickCount - startWhitePixelSearch > 31000) {
        MouseMove, 1167, 476, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1113, 342, 3
        sleep 300
        MouseClick, left
        sleep 300
        MouseMove, 1167, 476, 3
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
    loopCount := 0
    Loop {
        if (!toggle) {
            break
        }

        loopCount++
        if (loopCount > 15) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 1800
        MouseMove, 52, 621, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 525, 158, 3
        sleep 220
        Click, Left
        sleep 220
		Click, WheelUp 80
		sleep 500
		Click, WheelDown 35
		sleep 300
        Send, {w Down}
        Send, {a Down}
        sleep 4150
        Send, {w Up}
        sleep 600
        Send {a Up}
        sleep 200
        Send {w Down}
        sleep 400
        Send {w Up}
        sleep 300
        Send {d Down}
        sleep 180
        Send {d Up
        sleep 150
        Send {w Down}
        sleep 1100
        Send {w Up}
        sleep 300
        Send {s Down}
        sleep 300
        Send {S Up}
        sleep 300
        Send {Space Down}
        sleep 25
		Send {w Down}
        sleep 1200
        Send {Space Up}
		sleep 200
		Send {w Up}
        sleep 300
        Send {e Down}
        sleep 300
        Send {e Up}
        sleep 100
        MouseMove, 1308, 1073, 3
        sleep 50
        MouseClick, Left
        sleep 50
        MouseClick, Left
        sleep 200
        MouseMove, 1289, 1264, 3
        sleep 200
        MouseClick, Left
        sleep 800
        loopCount := 0

        while (loopCount < 15) {
            MouseMove, 1117, 550, 3
            sleep 200
            MouseClick, Left
            sleep 200
            MouseMove, 700, 1078, 3
            sleep 200
            MouseClick, Left
            sleep 300
            MouseMove, 1082, 840, 3
            sleep 200
            MouseClick, Left
            sleep 300
            loopCount++
        }

        MouseMove, 1958, 361, 3
        sleep 200
        MouseClick, Left
        sleep 200
        Send, {a Down}
        sleep 1300
        Send, {a Up}
        sleep 75
        Send, {w Down}
        sleep 2670
        Send, {w Up}
        loopCount := 0
    }
        ; Fishing Minigame
        MouseMove, 1161, 1124, 3
        Sleep 30
        MouseClick, Left
        sleep 300
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

        ; failsafe
        if (A_TickCount - startWhitePixelSearch > 31000) {
        MouseMove, 1523, 649, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1457, 491, 3
        sleep 300
        MouseClick, left
        sleep 300
        MouseMove, 1523, 649, 3
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
    loopCount := 0
    Loop {
        if (!toggle) {
            break
        }

        loopCount++
        if (loopCount > 15) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 1800
        MouseMove, 26, 325, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 273, 106, 3
        sleep 220
        Click, Left
        sleep 220
		Click, WheelUp 80
		sleep 500
		Click, WheelDown 90
		sleep 300
        Send, {w Down}
        Send, {a Down}
        sleep 4150
        Send, {w Up}
        sleep 600
        Send {a Up}
        sleep 200
        Send {w Down}
        sleep 400
        Send {w Up}
        sleep 300
        Send {d Down}
        sleep 180
        Send {d Up
        sleep 150
        Send {w Down}
        sleep 1100
        Send {w Up}
        sleep 300
        Send {s Down}
        sleep 300
        Send {S Up}
        sleep 300
        Send {Space Down}
        sleep 25
		Send {w Down}
        sleep 1200
        Send {Space Up}
		sleep 200
		Send {w Up}
        sleep 300
        Send {e Down}
        sleep 300
        Send {e Up}
        sleep 500
        MouseMove, 682, 563, 3
        sleep 50
        MouseClick, Left
        sleep 50
        MouseClick, Left
        sleep 200
        MouseMove, 682, 667, 3
        sleep 200
        MouseClick, Left
        sleep 800
        loopCount := 0

        while (loopCount < 15) {
            MouseMove, 586, 287, 3
            sleep 200
            MouseClick, Left
            sleep 200
            MouseMove, 365, 570, 3
            sleep 200
            MouseClick, Left
            sleep 300
            MouseMove, 570, 442, 3
            sleep 200
            MouseClick, Left
            sleep 300
            loopCount++
        }

        MouseMove, 1050, 197, 3
        sleep 200
        MouseClick, Left
        sleep 200
        Send, {a Down}
        sleep 1300
        Send, {a Up}
        sleep 75
        Send, {w Down}
        sleep 2670
        Send, {w Up}
        loopCount := 0
    }

        MouseMove, 603, 597, 3
        Sleep 300
        MouseClick, Left
        sleep 300
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

        ; failsafe
        if (A_TickCount - startWhitePixelSearch > 31000) {
        MouseMove, 858, 331, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 817, 210, 3
        sleep 300
        MouseClick, left
        sleep 300
        MouseMove, 858, 331, 3
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
        MouseClick, left
        }
        }
        sleep 300
        MouseMove, 829, 218, 3
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

Dev1NameClick:
if (dev1_name = "cresqnt") {
    Run, https://cresqnt.com
}
return

Dev1LinkClick:
if (dev1_name = "maxstellar") {
    Run, https://www.twitch.tv/maxstellar
} else if (dev1_name = "cresqnt") {
    Run, https://scopedevelopment.tech
}
return

Dev2NameClick:
if (dev2_name = "cresqnt") {
    Run, https://cresqnt.com
}
return

Dev2LinkClick:
if (dev2_name = "maxstellar") {
    Run, https://www.twitch.tv/maxstellar
} else if (dev2_name = "cresqnt") {
    Run, https://scopedevelopment.tech
}
return

Dev3NameClick:
if (dev3_name = "cresqnt") {
    Run, https://cresqnt.com
}
return

Dev3LinkClick:
if (dev3_name = "maxstellar") {
    Run, https://www.twitch.tv/maxstellar
} else if (dev3_name = "cresqnt") {
    Run, https://scopedevelopment.tech
}
return
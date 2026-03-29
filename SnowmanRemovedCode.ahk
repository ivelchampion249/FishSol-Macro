; 82-83
snowmanPathing := false
snowmanPathingWebhook := false

; 88-90
    IniRead, tempSnowmanPathing, %iniFilePath%, "Macro", "snowmanPathing", 0
    snowmanPathing := (tempSnowmanPathing = "1" || tempSnowmanPathing = "true")

; 101
; snowmanPathingTime := 7500000

; 108
snowmanPathingLastRun := 0

; 253
hasSnowmanPlugin := False ;FileExist(A_ScriptDir "\plugins\snowman.pathing.ahk")

; 364-365
if (hasSnowmanPlugin)
    tabList .= "|Snowman"

; 686-718
if (hasSnowmanPlugin) {
    Gui, Tab, Snowman
    Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Snowman.png

    Gui, Font, s10 c0xCCCCCC Normal
    Gui, Add, Text, x60 y190 w500 h50 BackgroundTrans, When toggled, The macro will automatically collect snowflakes every 2 hours and 5 minutes from the snowman located near Lime.
    Gui, Add, Text, x45 y340 w520 h50 BackgroundTrans, Pathing modes and Resolutions are automatically detected. And will work as normal for this plugin depending on what you have selected.
    Gui, Add, Text, x60 y270 w520 h50 BackgroundTrans, When toggled, you will recieve a webhook message every Snowman Pathing Loop.

    Gui, Font, s11 c0xCCCCCC Normal
    Gui, Add, Text, x72 y385 w520 h30 BackgroundTrans, Make sure you have claimed your Snowflakes before running this script.

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x60 y160 w80 h25 gToggleSnowmanPathing vSnowmanPathingBtn, Toggle

    Gui, Add, Button, x60 y240 w80 h25 gToggleSnowmanPathingWebhook vSnowmanPathingWebhookBtn, Toggle

    Gui, Font, s10 cWhite Normal Bold
    if (snowmanPathing) {
        Gui, Add, Text, x150 y165 w40 h25 vSnowmanPathingStatus BackgroundTrans c0x00DD00, ON
    } else {
        Gui, Add, Text, x150 y165 w40 h25 vSnowmanPathingStatus BackgroundTrans c0xFF4444, OFF
    }

    if (snowmanPathingWebhook) {
        Gui, Add, Text, x150 y245 w40 h25 vSnowmanPathingWebhookStatus BackgroundTrans c0x00DD00, ON
    } else {
        Gui, Add, Text, x150 y245 w40 h25 vSnowmanPathingWebhookStatus BackgroundTrans c0xFF4444, OFF
    }

}

; 929-938
if (hasSnowmanPlugin) {
    if (snowmanPathing) {
        GuiControl,, SnowmanPathingStatus, ON
        GuiControl, +c0x00DD00, SnowmanPathingStatus
    } else {
        GuiControl,, SnowmanPathingStatus, OFF
        GuiControl, +c0xFF4444, SnowmanPathingStatus
    }
    GuiControl,, SnowmanIntervalInput, % (snowmanInterval / 60000)
}

; 1116-1160
ToggleSnowmanPathing:
    snowmanPathing := !snowmanPathing
    if (snowmanPathing) {
        GuiControl,, SnowmanPathingStatus, ON
        GuiControl, +c0x00DD00, SnowmanPathingStatus
        IniWrite, true, %iniFilePath%, "Macro", "snowmanPathing"
    } else {
        GuiControl,, SnowmanPathingStatus, OFF
        GuiControl, +c0xFF4444, SnowmanPathingStatus
        IniWrite, false, %iniFilePath%, "Macro", "snowmanPathing"
    }

    if (autoCrafter) {
        GuiControl,, AutoCrafterStatus, ON
        GuiControl, +c0x00DD00, AutoCrafterStatus
        IniWrite, true, %iniFilePath%, "Macro", "autoCrafter"
    } else {
        GuiControl,, AutoCrafterStatus, OFF
        GuiControl, +c0xFF4444, AutoCrafterStatus
        IniWrite, false, %iniFilePath%, "Macro", "autoCrafter"
    }

    if (autoCrafterWebhook) {
        GuiControl,, AutoCrafterWebhookStatus, ON
        GuiControl, +c0x00DD00, AutoCrafterWebhookStatus
        IniWrite, true, %iniFilePath%, "Macro", "autoCrafterWebhook"
    } else {
        GuiControl,, AutoCrafterWebhookStatus, OFF
        GuiControl, +c0xFF4444, AutoCrafterWebhookStatus
        IniWrite, false, %iniFilePath%, "Macro", "autoCrafterWebhook"
    }
return

ToggleSnowmanPathingWebhook:
    snowmanPathingWebhook := !snowmanPathingWebhook
    if (snowmanPathingWebhook) {
        GuiControl,, SnowmanPathingWebhookStatus, ON
        GuiControl, +c0x00DD00, SnowmanPathingWebhookStatus
        IniWrite, true, %iniFilePath%, "Macro", "snowmanPathingWebhook"
    } else {
        GuiControl,, SnowmanPathingWebhookStatus, OFF
        GuiControl, +c0xFF4444, SnowmanPathingWebhookStatus
        IniWrite, false, %iniFilePath%, "Macro", "snowmanPathingWebhook"
    }
return

; 1545-2062
RunSnowmanPathing() {
    if (pathingMode = "Non Vip Pathing") {
        RunSnowmanPathingNonVip()
    } else if (pathingMode = "Abyssal Pathing") {
        RunSnowmanPathingAbyssal()
    } else {
        RunSnowmanPathingVip()
    }
}

; VIP Snowman Pathing
RunSnowmanPathingVip() {
    MouseGetPos, originalX, originalY
    global res

    if (res = "1080p") {
        MouseMove, 47, 467, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 382, 126, 3
        sleep 220
        Click, Left
        sleep 220
        Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
        sleep 500
        Loop, 45
            {
            Click, WheelDown
            sleep 0
        }
        sleep 300
    }
    else if (res = "1440p") {
        MouseMove, 52, 621, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 525, 158, 3
        sleep 220
        Click, Left
        sleep 220
		Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
		sleep 500
		Loop, 35
            {
            Click, WheelDown
            sleep 0
        }
		sleep 300
    }
    else if (res = "1366x768") {
        MouseMove, 26, 325, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 273, 106, 3
        sleep 220
        Click, Left
        sleep 220
		Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
		sleep 500
		Loop, 90
            {
            Click, WheelDown
            sleep 0
        }
		sleep 300
    }

    Send, {a Down}
    sleep 1000
    Send, {s Down}
    sleep 2700
    Send, {a Up}
    sleep 2800
    Send, {s Up}
    sleep 300
    Send, {a Down}
    sleep 800
    Send, {a Up}
    sleep 300
    Send, {d Down}
    sleep 200
    Send, {d Up}
    sleep 200
    Send, {w Down}
    sleep 200
    Send, {w Up}
    sleep 300
    Send, {space Down}
    sleep 50
    Send, {a Down}
    sleep 50
    Send, {space Up}
    sleep 2200
    Send, {a Up}
    sleep 300
    Send, {e Down}
    sleep 50
    Send, {e Up}
    sleep 200
    Send, {e Down}
    sleep 50
    Send, {e Up}

    Send, {space Up}
    Send, {w Up}
    Send, {a Up}
    Send, {s Up}
    Send, {d Up}
    Send, {e Up}

    MouseMove, %originalX%, %originalY%, 0
}

; Non-VIP Snowman Pathing
RunSnowmanPathingNonVip() {
    MouseGetPos, originalX, originalY
    global res

    if (res = "1080p") {
        MouseMove, 47, 467, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 382, 126, 3
        sleep 220
        Click, Left
        sleep 220
        Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
        sleep 500
        Loop, 45
            {
            Click, WheelDown
            sleep 0
        }
        sleep 300
    }
    else if (res = "1440p") {
        MouseMove, 52, 621, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 525, 158, 3
        sleep 220
        Click, Left
        sleep 220
		Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
		sleep 500
        Loop, 35
            {
            Click, WheelDown
            sleep 0
        }
		sleep 300
    }
    else if (res = "1366x768") {
        MouseMove, 26, 325, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 273, 106, 3
        sleep 220
        Click, Left
        sleep 220
		Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
		sleep 500
        Loop, 90
            {
            Click, WheelDown
            sleep 0
        }
		sleep 300
    }

    Send, {a Down}
    sleep 1500
    Send, {s Down}
    sleep 3400
    Send, {a Up}
    sleep 3400
    Send, {s Up}
    sleep 300
    Send, {a Down}
    sleep 800
    Send, {a Up}
    sleep 300
    Send, {d Down}
    sleep 300
    Send, {d Up}
    sleep 200
    Send, {w Down}
    sleep 200
    Send, {w Up}
    sleep 300
    Send, {a Down}
    sleep 50
    Send, {space Down}
    sleep 50
    Send, {space Up}
    sleep 2600

    Send, {space Up}
    Send, {w Up}
    Send, {a Up}
    Send, {s Up}
    Send, {d Up}
    Send, {e Up}

    MouseMove, %originalX%, %originalY%, 0
}

; Abyssal Snowman Pathing
RunSnowmanPathingAbyssal() {
    MouseGetPos, originalX, originalY
    global res

    if (res = "1080p") {
        MouseMove, 47, 467, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 382, 126, 3
        sleep 220
        Click, Left
        sleep 220
        Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
        sleep 500
        Loop, 45
            {
            Click, WheelDown
            sleep 0
        }
        sleep 300
        MouseMove, 30, 406, 3
        sleep 200
        MouseClick, Left
        sleep 200
        MouseMove, 947, 335, 3
        sleep 200
        MouseClick, Left
        sleep 100
        MouseMove, 1102, 367, 3
        sleep 100
        MouseClick, Left
        sleep 100
        Clipboard := "Abyssal Hunter"
        sleep 100
        Send, ^v
        sleep 200
        MouseMove, 819, 434, 3
        sleep 200
        Loop, 100
            {
            Click, WheelUp
            sleep 0
        }
        sleep 200
        MouseClick, Left
        sleep 200

        ErrorLevel := 0
        PixelSearch, px, py, 576, 626, 666, 645, 0xfc7f98, 3, Fast RGB
        if (ErrorLevel != 0) {
            MouseMove, 623, 634, 3
            sleep 200
            MouseClick, Left
        }

        sleep 200
        MouseMove, 1412, 296, 3
        sleep 200
        MouseClick, Left
        sleep 200
    }
    else if (res = "1440p") {
        MouseMove, 52, 621, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 525, 158, 3
        sleep 220
        Click, Left
        sleep 220
		Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
		sleep 500
		Loop, 35
            {
            Click, WheelDown
            sleep 0
        }
		sleep 300
        MouseMove, 40, 541, 3
        sleep 200
        MouseClick, Left
        sleep 200
        MouseMove, 1262, 447, 3
        sleep 200
        MouseClick, Left
        sleep 100
        MouseMove, 1469, 489, 3
        sleep 100
        MouseClick, Left
        sleep 100
        ClipBoard := "Abyssal Hunter"
        sleep 100
        Send, ^v
        sleep 200
        MouseMove, 1092, 579, 3
        sleep 200
        Loop, 100
            {
            Click, WheelUp
            sleep 0
        }
        sleep 200
        MouseClick, Left
        sleep 200

        ErrorLevel := 0
        PixelSearch, px, py, 768, 835, 888, 860, 0xfc7f98, 3, Fast RGB
        if (ErrorLevel != 0) {
            MouseMove, 830, 845, 3
            sleep 200
            MouseClick, Left
        }

        sleep 200
        MouseMove, 1883, 395, 3
        sleep 200
        MouseClick, Left
        sleep 200
    }
    else if (res = "1366x768") {
        MouseMove, 26, 325, 3
        sleep 220
        Click, Left
        sleep 220
        MouseMove, 273, 106, 3
        sleep 220
        Click, Left
        sleep 220
		Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
		sleep 500
		Loop, 90
            {
            Click, WheelDown
            sleep 0
        }
		sleep 300
        MouseMove, 21, 289, 3
        sleep 200
        MouseClick, Left
        sleep 200
        MouseMove, 675, 239, 3
        sleep 200
        MouseClick, Left
        sleep 100
        MouseMove, 786, 261, 3
        sleep 100
        MouseClick, Left
        sleep 100
        Clipboard := "Abyssal Hunter"
        sleep 100
        Send, ^v
        sleep 200
        MouseMove, 584, 310, 3
        sleep 200
        Loop, 80
            {
            Click, WheelUp
            sleep 0
        }
        sleep 200
        MouseClick, Left
        sleep 200

        ErrorLevel := 0
        PixelSearch, px, py, 411, 446, 475, 460, 0xed7389, 3, Fast RGB
        if (ErrorLevel != 0) {
            MouseMove, 444, 452, 3
            sleep 200
            MouseClick, Left
        }

        sleep 200
        MouseMove, 1007, 211, 3
        sleep 200
        MouseClick, Left
        sleep 200
    }

    Send, {a Down}
    sleep 1000
    Send, {s Down}
    sleep 1400
    Send, {a Up}
    sleep 2100
    Send, {s Up}
    sleep 300
    Send, {a Down}
    sleep 600
    Send, {a Up}
    sleep 300
    Send, {d Down}
    sleep 150
    Send, {d Up}
    sleep 200
    Send, {w Down}
    sleep 150
    Send, {w Up}
    sleep 300
    Send, {space Down}
    sleep 50
    Send, {a Down}
    sleep 50
    Send, {space Up}
    sleep 1500
    Send, {a Up}
    sleep 300
    Send, {e Down}
    sleep 50
    Send, {e Up}
    sleep 200
    Send, {e Down}
    sleep 50
    Send, {e Up}

    Send, {space Up}
    Send, {w Up}
    Send, {a Up}
    Send, {s Up}
    Send, {d Up}
    Send, {e Up}

    MouseMove, %originalX%, %originalY%, 0
}

RunSnowmanPathingNow:
    global toggle, restartPathing, firstLoop, snowmanPathingLastRun, snowmanPathingInterval, snowmanPathingWebhook, res, pathingMode

    Send, {Esc}
    sleep 500
    Send, r
    sleep 1000
    Send, {Enter}
    sleep 2000

    Send, {w up}
    Send, {a up}
    Send, {s up}
    Send, {d up}
    Send, {space up}
    Send, {e up}

    Suspend, Off

    if (snowmanPathingWebhook) {
        try SendWebhook(":snowman: Starting snowman pathing (" . pathingMode . " at " . res . ")", "16636040")
    }

    RunSnowmanPathing()

    snowmanPathingLastRun := A_TickCount - snowmanPathingInterval + 60000

    toggle := true
    restartPathing := true
    firstLoop := true

    if (res = "1080p") {
        Gosub, DoMouseMove
    } else if (res = "1440p") {
        Gosub, DoMouseMove2
    } else if (res = "1366x768") {
        Gosub, DoMouseMove3
    }

    if (savedPathingState) {
        Suspend, On
    }
return


; 4882-4885 & 2852-2854 & 3851-3853
                if (snowmanPathing)
                {
                    Sleep, 2000
                }

; 2628 & 2637
snowmanPathingLastRun := 0

; 2770
global snowmanPathingLastRun

; 2801-2821 & 3800-3820
            Snowman Pathing Toggle
            if (snowmanPathing) {
                elapsed := A_TickCount - startTick
                if ((snowmanPathingLastRun = 0 && elapsed >= snowmanPathingTime) || (snowmanPathingLastRun > 0 && (elapsed - snowmanPathingLastRun) >= snowmanPathingInterval)) {
                    Send, {Esc}
                    Sleep, 650
                    Send, R
                    Sleep, 650
                    Send, {Enter}
                    sleep 2600
            
                    if (snowmanPathingWebhook) {
                        try SendWebhook(":snowman: Starting snowman pathing...", "16636040")
                    }
                    RunSnowmanPathing()
                    snowmanPathingLastRun := elapsed
            
                    restartPathing := true
                    continue
                }
            }


; 4815-4842
            ; Snowman Pathing Toggle
            if (snowmanPathing)
            {
                elapsed := A_TickCount - startTick
                if ((snowmanPathingLastRun = 0 && elapsed >= snowmanPathingTime) || (snowmanPathingLastRun > 0 && (elapsed - snowmanPathingLastRun) >= snowmanPathingInterval))
                {
                    if (snowmanPathingWebhook)
                    {
                        try SendWebhook(":moneybag: Resetting character after snowman pathing...", "16636040")
                    }
                    Send, {Esc}
                    Sleep, 650
                    Send, R
                    Sleep, 650
                    Send, {Enter}
                    sleep 2600
            
                    if (snowmanPathingWebhook)
                    {
                        try SendWebhook(":snowman: Starting snowman pathing...", "16636040")
                    }
                    RunSnowmanPathing()
                    snowmanPathingLastRun := elapsed
            
                    restartPathing := true
                    continue
                }
            }
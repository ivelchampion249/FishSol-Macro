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
maxLoopCount := 15
fishingLoopCount := 15
sellAllToggle := false
advancedFishingToggle := false
pathingMode := "Vip Pathing"
azertyPathing := false
autoUnequip := false
privateServerLink := ""
globalFailsafeTimer := 0
fishingFailsafeTime := 31
pathingFailsafeTime := 61
autoRejoinFailsafeTime := 320

if (FileExist(iniFilePath)) {
    IniRead, tempRes, %iniFilePath%, "Macro", "resolution"
    if (tempRes != "ERROR")
    {
        res := tempRes
    }
    IniRead, tempMaxLoop, %iniFilePath%, "Macro", "maxLoopCount"
    if (tempMaxLoop != "ERROR" && tempMaxLoop > 0)
    {
        maxLoopCount := tempMaxLoop
    }
    IniRead, tempFishingLoop, %iniFilePath%, "Macro", "fishingLoopCount"
    if (tempFishingLoop != "ERROR" && tempFishingLoop > 0)
    {
        fishingLoopCount := tempFishingLoop
    }
    IniRead, tempSellAll, %iniFilePath%, "Macro", "sellAllToggle"
    if (tempSellAll != "ERROR")
    {
        sellAllToggle := (tempSellAll = "true" || tempSellAll = "1")
    }
    IniRead, tempPathing, %iniFilePath%, "Macro", "pathingMode"
    if (tempPathing != "ERROR")
    {
        pathingMode := tempPathing
    }
    IniRead, tempAzerty, %iniFilePath%, "Macro", "azertyPathing"
    if (tempAzerty != "ERROR")
    {
        azertyPathing := (tempAzerty = "true" || tempAzerty = "1")
    }
    IniRead, tempPrivateServer, %iniFilePath%, "Macro", "privateServerLink"
    if (tempPrivateServer != "ERROR")
    {
        privateServerLink := tempPrivateServer
    }
    IniRead, tempAdvancedFishing, %iniFilePath%, "Macro", "advancedFishingToggle"
    if (tempAdvancedFishing != "ERROR")
    {
        advancedFishingToggle := (tempAdvancedFishing = "true" || tempAdvancedFishing = "1")
    }
    IniRead, tempFishingFailsafe, %iniFilePath%, "Macro", "fishingFailsafeTime"
    if (tempFishingFailsafe != "ERROR" && tempFishingFailsafe > 0)
    {
        fishingFailsafeTime := tempFishingFailsafe
    }
    IniRead, tempPathingFailsafe, %iniFilePath%, "Macro", "pathingFailsafeTime"
    if (tempPathingFailsafe != "ERROR" && tempPathingFailsafe > 0)
    {
        pathingFailsafeTime := tempPathingFailsafe
    }
    IniRead, tempAutoRejoinFailsafe, %iniFilePath%, "Macro", "autoRejoinFailsafeTime"
    if (tempAutoRejoinFailsafe != "ERROR" && tempAutoRejoinFailsafe > 0)
    {
        autoRejoinFailsafeTime := tempAutoRejoinFailsafe
    }
    IniRead, tempAutoUnequip, %iniFilePath%, "Macro", "autoUnequip"
    if (tempAutoUnequip != "ERROR")
    {
        autoUnequip := (tempAutoUnequip = "true" || tempAutoUnequip = "1")
    }
    IniRead, tempAzerty, %iniFilePath%, "Macro", "azertyPathing"
    if (tempAzerty != "ERROR")
    {
        azertyPathing := (tempAzerty = "true" || tempAzerty = "1")
    }
    IniRead, tempAdvancedThreshold, %iniFilePath%, "Macro", "advancedFishingThreshold"
    if (tempAdvancedThreshold != "ERROR" && tempAdvancedThreshold >= 0 && tempAdvancedThreshold <= 40)
    {
        advancedFishingThreshold := tempAdvancedThreshold
    }
}

version := "v1.7.1"

code := ""
if RegExMatch(privateServerLink, "code=([^&]+)", m)
{
    code := m1
}

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
    dev2_discord := "Youtube"
    dev2_role := "Original Creator"
    dev3_name := "cresqnt"
    dev3_discord := "Scope Development (other macros)"
    dev3_role := "Frontend Developer"
} else if (shuffle = 2) {
    dev1_name := "maxstellar"
    dev1_discord := "Twitch"
    dev1_role := "Lead Developer"
    dev2_name := "cresqnt"
    dev2_discord := "Scope Development (other macros)"
    dev2_role := "Frontend Developer"
    dev3_name := "ivelchampion249"
    dev3_discord := "Youtube"
    dev3_role := "Original Creator"
} else if (shuffle = 3) {
    dev1_name := "cresqnt"
    dev1_discord := "Scope Development (other macros)"
    dev1_role := "Frontend Developer"
    dev2_name := "ivelchampion249"
    dev2_discord := "Youtube"
    dev2_role := "Original Creator"
    dev3_name := "maxstellar"
    dev3_discord := "Twitch"
    dev3_role := "Lead Developer"
} else if (shuffle = 4) {
    dev1_name := "cresqnt"
    dev1_discord := "Scope Development (other macros)"
    dev1_role := "Frontend Developer"
    dev2_name := "maxstellar"
    dev2_discord := "Twitch"
    dev2_role := "Lead Developer"
    dev3_name := "ivelchampion249"
    dev3_discord := "Youtube"
    dev3_role := "Original Creator"
} else if (shuffle = 5) {
    dev1_name := "ivelchampion249"
    dev1_discord := "Youtube"
    dev1_role := "Original Creator"
    dev2_name := "maxstellar"
    dev2_discord := "Twitch"
    dev2_role := "Lead Developer"
    dev3_name := "cresqnt"
    dev3_discord := "Scope Development (other macros)"
    dev3_role := "Frontend Developer"
} else {
    dev1_name := "ivelchampion249"
    dev1_discord := "Youtube"
    dev1_role := "Original Creator"
    dev2_name := "cresqnt"
    dev2_discord := "Scope Development (other macros)"
    dev2_role := "Frontend Developer"
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
Gui, Font, s17 cWhite Bold, Segoe UI
Gui, Add, Text, x0 y10 w600 h45 Center BackgroundTrans c0x00D4FF, fishSol v1.7.1

Gui, Font, s9 cWhite Normal, Segoe UI

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x440 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x533 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Add, Progress, x583 y595 w1 h52 BackgroundA0A0A0
Gui, Add, Progress, x584 y595 w1 h52 Background696868
Gui, Add, Progress, x315 y647 w270 h1 BackgroundA0A0A0
Gui, Add, Progress, x315 y646 w269 h1 Background696868
Gui, Add, Progress, x313 y603 w1 h45 BackgroundA0A0A0
Gui, Add, Progress, x314 y603 w1 h45 Background696868
Gui, Add, Progress, x574 y596 w9 h9 Background0x1E1E1E
Gui, Add, Progress, x315 y596 w25 h9 Background0x1E1E1E
Gui, Add, Progress, x564 y591 w1 h42 Background0xFFFFFF
Gui, Add, Progress, x563 y590 w1 h42 Background0xA1A0A1
Gui, Add, Progress, x333 y631 w230 h1 Background0xFFFFFF
Gui, Add, Progress, x334 y632 w230 h1 Background0xA1A0A1
Gui, Add, Progress, x333 y567 w1 h66 Background0xFFFFFF
Gui, Add, Progress, x334 y566 w1 h67 Background0xA1A0A1

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, Text, x425 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x325 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

Gui, Font, s10 cWhite Normal, Segoe UI
Gui, Add, Tab3, x15 y55 w570 h550 vMainTabs gTabChange c0xFFFFFF, Main|Misc|About

Gui, Tab, Main
Gui, Font, s9 cWhite Normal, Segoe UI

Gui, Add, GroupBox, x30 y85 w260 h120 cWhite, Control Panel
Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y110 w60 h25 BackgroundTrans, Status:
Gui, Add, Text, x98 y110 w150 h25 vStatusText BackgroundTrans c0xFF4444, Stopped

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

Gui, Font, s10 cWhite Bold
Gui, Add, Button, x450 y135 w100 h25 gToggleSellAll vSellAllBtn, Toggle Sell All
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x450 y165 w100 h25 vSellAllStatus BackgroundTrans, OFF

Gui, Add, GroupBox, x30 y215 w535 h120 cWhite, Loop Count Settings
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x45 y240 w180 h25 BackgroundTrans, Fishing Loop Count:
Gui, Add, Edit, x220 y238 w60 h25 vMaxLoopInput gUpdateLoopCount Number Background0xD3D3D3 cBlack, %maxLoopCount%
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x285 y242 w270 h15 BackgroundTrans, (Fishing Cycles Before Reset - default: 15)
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x45 y270 w180 h25 BackgroundTrans, Sell Loop Count:
Gui, Add, Edit, x220 y268 w60 h25 vFishingLoopInput gUpdateLoopCount Number Background0xD3D3D3 cBlack, %fishingLoopCount%
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x285 y272 w270 h15 BackgroundTrans, (Sell Cycles  -  If Sell All: 22)
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x45 y301 w120 h25 BackgroundTrans, Pathing Mode:
Gui, Add, DropDownList, x145 y298 w135 h200 vPathingMode gSelectPathing, Vip Pathing|Non Vip Pathing|Abyssal Pathing

Gui, Add, Text, x295 y301 w120 h25 BackgroundTrans, AZERTY Pathing:
Gui, Add, Button, x415 y298 w80 h25 gToggleAzertyPathing vAzertyPathingBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x510 y303 w60 h25 vAzertyPathingStatus BackgroundTrans, OFF

Gui, Font, s10 cWhite Bold
Gui, Add, GroupBox, x30 y345 w205 h95 cWhite, Live Statistics

Gui, Color, 0x1E1E1E
Gui, Font, s11 cWhite Bold, Segoe UI

Gui, Add, GroupBox, x250 y345 w315 h111 cWhite, Advanced Fishing Options
Gui, Add, Text, x270 y370 w400 h30 BackgroundTrans, Advanced Fishing Detection:
Gui, Font, s11 c0xFF2C00 Bold
Gui, Add, Text, x340 y405 w150 h25 BackgroundTrans, [ COMING SOON ]
Gui, Add, GroupBox, x30 y445 w535 h70 cWhite
Gui, Add, Progress, x252 y435 w311 h25 Background0x1E1E1E

Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x50 y470 w515 h30 BackgroundTrans, Advanced Fishing Detection Uses a system that clicks slightly before the bar exits the fish range. Making the Catch-Rate higher than ever.

Gui, Font, s9 c0x00D4FF Bold
Gui, Add, Text, x272 y440 w515 h30 BackgroundTrans c0x00D4FF, [ Highly Recommended For Lower End Devices ]

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, Text, x50 y375 w100 h30 BackgroundTrans, Runtime:
Gui, Add, Text, x120 y375 w120 h30 vRuntimeText BackgroundTrans c0x00DD00, 00:00:00

Gui, Add, Text, x50 y405 w100 h30 BackgroundTrans, Cycles:
Gui, Add, Text, x102 y405 w120 h30 vCyclesText BackgroundTrans c0x00DD00, 0

Gui, Add, GroupBox, x30 y520 w535 h70 cWhite, Important
Gui, Add, Progress, x334 y570 w230 h25 Background0x1E1E1E
Gui, Add, Progress, x564 y570 w1 h35 Background0xFFFFFF
Gui, Add, Progress, x563 y570 w1 h35 Background0xA1A0A1
Gui, Add, Progress, x333 y590 w1 h16 Background0xFFFFFF
Gui, Add, Progress, x334 y588 w1 h15 Background0xA1A0A1

Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x50 y545 w500 h20 BackgroundTrans, Requirements: 100`% Windows scaling - Roblox in fullscreen mode
Gui, Add, Text, x50 y563 w500 h20 BackgroundTrans, For best results, make sure you have good internet and avoid screen overlays

Gui, Tab, Misc

Gui, Add, Progress, x23 y99 w554 h2 Background871C00
Gui, Add, Progress, x23 y100 w2 h32 Background871C00
Gui, Add, Progress, x575 y100 w2 h32 Background871C00
Gui, Add, Progress, x208 y99 w180 h27 Background0x1E1E1E
Gui, Font, s12 cWhite Bold, Segoe UI
Gui, Add, Text, x30 y90 w535 h30 Center BackgroundTrans c0xFF2C00,  [ ! Handle With Care ! ]

Gui, Add, Progress, x23 y463 w554 h2 Background0x871C00
Gui, Add, Progress, x23 y430 w2 h35 Background0x871C00
Gui, Add, Progress, x575 y430 w2 h35 Background871C00

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x32 y110 w533 h225 cWhite, Auto-Rejoin Failsafe

Gui, Font, s10 cWhite Normal
Gui, Add, Text, x50 y140 w500 h40 BackgroundTrans c0xCCCCCC, If the fishing minigame is not detected for the specified time, the macro will`nautomatically rejoin using the private server link below.

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x50 y190 w150 h25 BackgroundTrans, Private Server Link:
Gui, Add, Edit, x50 y215 w500 h25 vPrivateServerInput gUpdatePrivateServer Background0xD3D3D3 cBlack, %privateServerLink%

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y245 w500 h15 BackgroundTrans, Paste your Roblox private server link here (leave empty to disable)

Gui, Font, s10 cWhite Normal
Gui, Add, Text, x79 y306 w450 h40 BackgroundTrans c0xCCCCCC, Customize how long until the Auto-Rejoin Failsafe triggers. (Default : 320)

Gui, Font, s11 cWhite Bold
Gui, Add, Text, x145 y275 w150 h25 BackgroundTrans, Seconds:
Gui, Add, Edit, x218 y272 w150 h25 vAutoRejoinFailsafeInput gUpdateAutoRejoinFailsafe Number Background0xD3D3D3 cBlack, %autoRejoinFailsafeTime%

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x32 y340 w260 h105 cWhite, Fishing Failsafe

Gui, Font, s9 cWhite Normal
Gui, Add, Text, x45 y370 w230 h40 BackgroundTrans c0xCCCCCC, Customize how long until the Fishing Failsafe triggers. (Default : 31)

Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y413 w150 h35 BackgroundTrans, Seconds:
Gui, Add, Edit, x125 y411 w150 h25 vFishingFailsafeInput gUpdateFishingFailsafe Number Background0xD3D3D3 cBlack, %fishingFailsafeTime%

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x307 y340 w258 h105 cWhite, Pathing Failsafe

Gui, Font, s9 cWhite Normal
Gui, Add, Text, x320 y370 w230 h45 BackgroundTrans c0xCCCCCC, Customize how long until the Pathing Failsafe triggers. (Default : 61)

Gui, Font, s11 cWhite Bold
Gui, Add, Text, x320 y413 w150 h35 BackgroundTrans, Seconds:
Gui, Add, Edit, x400 y411 w150 h25 vPathingFailsafeInput gUpdatePathingFailsafe Number Background0xD3D3D3 cBlack, %pathingFailsafeTime%

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x32 y475 w260 h115 cWhite, Auto-Unequip
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x45 y495 h45 w250 BackgroundTrans c0xCCCCCC, Automatically unequip rolled auras every pathing cycle. Preventing lag and pathing issues.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x45 y550 w80 h25 gToggleAutoUnequip vAutoUnequipBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x140 y552 w60 h25 vAutoUnequipStatus BackgroundTrans, OFF



Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, GroupBox, x307 y475 w258 h115 cWhite, Advanced Detection
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x320 y500 w230 h40 BackgroundTrans c0xCCCCCC, Customize how many pixels are left in the fishing range before clicking. (Max : 40)
Gui, Font, s11 c0xFF2C00 Bold
Gui, Add, Text, x370 y553 w150 h25 BackgroundTrans, [ COMING SOON ]
Gui, Add, Progress, x335 y587 w228 h9 Background0x1E1E1E
Gui, Add, Progress, x564 y589 w1 h16 Background0xFFFFFF
Gui, Add, Progress, x563 y588 w1 h15 Background0xA1A0A1
Gui, Add, Progress, x333 y589 w1 h16 Background0xFFFFFF
Gui, Add, Progress, x334 y588 w1 h15 Background0xA1A0A1

Gui, Tab, About

Gui, Add, Progress, x564 y589 w1 h16 Background0xFFFFFF
Gui, Add, Progress, x563 y588 w1 h15 Background0xA1A0A1
Gui, Add, Progress, x333 y589 w1 h16 Background0xFFFFFF
Gui, Add, Progress, x334 y588 w1 h15 Background0xA1A0A1
Gui, Add, Progress, x333 y588 w232 h1 Background0xFFFFFF
Gui, Add, Progress, x334 y589 w231 h1 Background0xA1A0A1

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

url := "https://raw.githubusercontent.com/ivelchampion249/FishSol-Macro/refs/heads/main/DONATORS.txt"  ; ← replace with your file URL

Http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
Http.Open("GET", url, false)
Http.Send()

content := Http.ResponseText

Gui, Font, s10 cWhite Bold
Gui, Add, Text, x50 y345 w200 h20 BackgroundTrans, Thank you to our donators!
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Edit, x50 y370 w480 h95 vDonatorsList -Wrap +ReadOnly +VScroll -WantReturn -E0x200 Background0x2D2D2D c0xCCCCCC, %content%

Gui, Font, s8 c0x888888
Gui, Add, Text, x50 y490 w480 h1 0x10 BackgroundTrans

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y500 w500 h15 BackgroundTrans, fishSol v1.7.1 - %randomMessage%

Gui, Show, w600 h670, fishSol v1.7.1

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

if (sellAllToggle) {
    GuiControl,, SellAllStatus, ON
    GuiControl, +c0x00DD00, SellAllStatus
} else {
    GuiControl,, SellAllStatus, OFF
    GuiControl, +c0xFF4444, SellAllStatus
}

if (advancedFishingToggle) {
    GuiControl,, AdvancedFishingStatus, ON
    GuiControl, +c0x00DD00, AdvancedFishingStatus
} else {
    GuiControl,, AdvancedFishingStatus, OFF
    GuiControl, +c0xFF4444, AdvancedFishingStatus
}

if (pathingMode = "Vip Pathing") {
    GuiControl, Choose, PathingMode, 1
} else if (pathingMode = "Non Vip Pathing") {
    GuiControl, Choose, PathingMode, 2
} else if (pathingMode = "Abyssal Pathing") {
    GuiControl, Choose, PathingMode, 3
} else {
    GuiControl, Choose, PathingMode, 1
    pathingMode := "Vip Pathing"
}

if (azertyPathing) {
    GuiControl,, AzertyPathingStatus, ON
    GuiControl, +c0x00DD00, AzertyPathingStatus
} else {
    GuiControl,, AzertyPathingStatus, OFF
    GuiControl, +c0xFF4444, AzertyPathingStatus
}

if (autoUnequip) {
    GuiControl,, AutoUnequipStatus, ON
    GuiControl, +c0x00DD00, AutoUnequipStatus
} else {
    GuiControl,, AutoUnequipStatus, OFF
    GuiControl, +c0xFF4444, AutoUnequipStatus
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

UpdateLoopCount:
Gui, Submit, nohide
if (MaxLoopInput > 0) {
    maxLoopCount := MaxLoopInput
    IniWrite, %maxLoopCount%, %iniFilePath%, "Macro", "maxLoopCount"
}
if (FishingLoopInput > 0) {
    fishingLoopCount := FishingLoopInput
    IniWrite, %fishingLoopCount%, %iniFilePath%, "Macro", "fishingLoopCount"
}
return

ToggleSellAll:
sellAllToggle := !sellAllToggle
if (sellAllToggle) {
    GuiControl,, SellAllStatus, ON
    GuiControl, +c0x00DD00, SellAllStatus
    IniWrite, true, %iniFilePath%, "Macro", "sellAllToggle"
} else {
    GuiControl,, SellAllStatus, OFF
    GuiControl, +c0xFF4444, SellAllStatus
    IniWrite, false, %iniFilePath%, "Macro", "sellAllToggle"
}
return

ToggleAdvancedFishing:
advancedFishingToggle := !advancedFishingToggle
if (advancedFishingToggle) {
    GuiControl,, AdvancedFishingStatus, ON
    GuiControl, +c0x00DD00, AdvancedFishingStatus
    IniWrite, true, %iniFilePath%, "Macro", "advancedFishingToggle"
} else {
    GuiControl,, AdvancedFishingStatus, OFF
    GuiControl, +c0xFF4444, AdvancedFishingStatus
    IniWrite, false, %iniFilePath%, "Macro", "advancedFishingToggle"
}
return

ToggleAzertyPathing:
azertyPathing := !azertyPathing
if (azertyPathing) {
    GuiControl,, AzertyPathingStatus, ON
    GuiControl, +c0x00DD00, AzertyPathingStatus
    IniWrite, true, %iniFilePath%, "Macro", "azertyPathing"
} else {
    GuiControl,, AzertyPathingStatus, OFF
    GuiControl, +c0xFF4444, AzertyPathingStatus
    IniWrite, false, %iniFilePath%, "Macro", "azertyPathing"
}
return

ToggleAutoUnequip:
autoUnequip := !autoUnequip
if (autoUnequip) {
    GuiControl,, AutoUnequipStatus, ON
    GuiControl, +c0x00DD00, AutoUnequipStatus
    IniWrite, true, %iniFilePath%, "Macro", "autoUnequip"
} else {
    GuiControl,, AutoUnequipStatus, OFF
    GuiControl, +c0xFF4444, AutoUnequipStatus
    IniWrite, false, %iniFilePath%, "Macro", "autoUnequip"
}
return

UpdatePrivateServer:
Gui, Submit, nohide
privateServerLink := PrivateServerInput
IniWrite, %privateServerLink%, %iniFilePath%, "Macro", "privateServerLink"
return

UpdateFishingFailsafe:
Gui, Submit, nohide
if (FishingFailsafeInput > 0) {
    fishingFailsafeTime := FishingFailsafeInput
    IniWrite, %fishingFailsafeTime%, %iniFilePath%, "Macro", "fishingFailsafeTime"
}
return

UpdatePathingFailsafe:
Gui, Submit, nohide
if (PathingFailsafeInput > 0) {
    pathingFailsafeTime := PathingFailsafeInput
    IniWrite, %pathingFailsafeTime%, %iniFilePath%, "Macro", "pathingFailsafeTime"
}
return

UpdateAutoRejoinFailsafe:
Gui, Submit, nohide
if (AutoRejoinFailsafeInput > 0) {
    autoRejoinFailsafeTime := AutoRejoinFailsafeInput
    IniWrite, %autoRejoinFailsafeTime%, %iniFilePath%, "Macro", "autoRejoinFailsafeTime"
}
return

UpdateAdvancedThreshold:
Gui, Submit, nohide
if (AdvancedThresholdInput >= 0 && AdvancedThresholdInput <= 40) {
    advancedFishingThreshold := AdvancedThresholdInput
    IniWrite, %advancedFishingThreshold%, %iniFilePath%, "Macro", "advancedFishingThreshold"
}
return

UpdateGUI:
if (toggle) {
    GuiControl,, StatusText, Running
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
    GuiControl,, StatusText, Stopped
    GuiControl, +c0xFF4444, StatusText
    GuiControl,, ResStatusText, Ready
}
return

ManualGUIUpdate() {
    if (toggle) {
        GuiControl,, StatusText, Running
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
        GuiControl,, StatusText, Stopped
        GuiControl, +c0xFF4444, StatusText
        GuiControl,, ResStatusText, Ready
    }
}

F1::
if (!res) {
    res := "1080p"
}
if (!toggle) {
    Gui, Submit, nohide
    if (MaxLoopInput > 0) {
        maxLoopCount := MaxLoopInput
    }
    if (FishingLoopInput > 0) {
        fishingLoopCount := FishingLoopInput
    }
    toggle := true
    if (startTick = "") {
        startTick := A_TickCount
    }
    if (cycleCount = "") {
        cycleCount := 0
    }
    IniWrite, %res%, %iniFilePath%, "Macro", "resolution"
    IniWrite, %maxLoopCount%, %iniFilePath%, "Macro", "maxLoopCount"
    IniWrite, %fishingLoopCount%, %iniFilePath%, "Macro", "fishingLoopCount"
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
    global pathingMode
    global privateServerLink
    global globalFailsafeTimer
    global azertyPathing
    global autoUnequip
    global code
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    Loop {
        restartPathing := false
        if (!toggle) {
            break
        }

        loopCount++
        if (loopCount > maxLoopCount) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 2600
        if (autoUnequip) {
            MouseMove, 45, 412, 3
            sleep 300
            Click, Left
            sleep 300
            MouseMove, 830, 441, 3
            sleep 300
            Click, Left
            sleep 300
            MouseMove, 634, 638, 3
            sleep 300
            Click, Left
            sleep 1200
            Click, Left
            sleep 300
            MouseMove, 1425, 303, 3
            sleep 300
            Click, Left
            sleep 300
        }
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

        if (pathingMode = "Non Vip Pathing") {
            ; Non VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 5190
            Send, {%keyW% Up}
            sleep 800
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 550
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 240
            Send {d Up
            sleep 150
            Send {%keyW% Down}
            sleep 1450
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1100
            Send {Space Up}
            sleep 520
            Send {%keyW% Up}
            sleep 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
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

            while (loopCount < fishingLoopCount) {
                MouseMove, 828, 404, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 680, 804, 3
                } else {
                    MouseMove, 512, 804, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 801, 626, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1458, 266, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 3300
            Send, {%keyW% Up}
            loopCount := 0
        } else if (pathingMode = "Vip Pathing") {
            ; VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 4150
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 400
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 180
            Send {d Up
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1200
            Send {Space Up}
            sleep 200
            Send {%keyW% Up}
            sleep 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
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

            while (loopCount < fishingLoopCount) {
                MouseMove, 828, 404, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 680, 804, 3
                } else {
                    MouseMove, 512, 804, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 801, 626, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1458, 266, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 2670
            Send, {%keyW% Up}
            loopCount := 0
        } else if (pathingMode = "Abyssal Pathing") {
            ; Abyssal Pathing
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
            Send, Abyssal Hunter
            sleep 200
            MouseMove, 819, 434, 3
            sleep 200
            Click, WheelUp 100
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

            Send, {%keyW% Down}
            sleep 500
            Send, {%keyA% Down}
            sleep 2650
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 500
            Send {%keyW% Up}
            sleep 200
            Send {s Down}
            sleep 120
            Send {S Up}
            sleep 100
            Send {d Down}
            sleep 280
            Send {d Up}
            sleep 200
            Send {%keyA% Down}
            sleep 50
            Send {Space Down}
            sleep 730
            Send {Space Up}
            sleep 200
            Send {%keyA% Up}
            sleep 100
            Send {%keyW% Down}
            sleep 810
            Send {%keyW% Up}
            sleep 150
            Send {space Down}
            sleep 15
            Send {d Down}
            sleep 150
            Send {space Up}
            sleep 580
            Send {d Up}
            sleep 100
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300

            MouseMove, 981, 805, 3
            sleep 50
            MouseClick, Left
            sleep 50
            MouseClick, Left
            sleep 200
            MouseMove, 967, 948, 3
            sleep 200
            MouseClick, Left
            sleep 800
            loopCount := 0

            while (loopCount < fishingLoopCount) {
                MouseMove, 838, 413, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 678, 810, 3
                } else {
                    MouseMove, 525, 809, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 801, 626, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1469, 271, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 800
            Send, {%keyA% Up}
            sleep 100
            Send, {%keyW% Down}
            sleep 1760
            Send, {%keyW% Up}
            loopCount := 0
        }
    }

        MouseMove, 862, 843, 3
        Sleep 300
        MouseClick, Left
        sleep 300
        barColor := 0
        otherBarColor := 0

        ; Check for white pixel
        startWhitePixelSearch := A_TickCount
        if (globalFailsafeTimer = 0) {
        globalFailsafeTimer := A_TickCount
        }
        fishingFailsafeRan := false
        Loop {
        PixelGetColor, color, 1176, 836, RGB
        if (color = 0xFFFFFF) {
        MouseMove, 950, 880, 3
        ; Get randomized bar color
        Sleep 50
        PixelGetColor, barColor, 955, 767, RGB
        SetTimer, DoMouseMove, Off
        globalFailsafeTimer := 0
        break
        }

        ; Auto Rejoin Failsafe
        if (A_TickCount - globalFailsafeTimer > (autoRejoinFailsafeTime * 1000) && privateServerLink != "") {
        PixelGetColor, checkColor, 1175, 837, RGB
        if (checkColor != 0xFFFFFF) {
        Process, Close, RobloxPlayerBeta.exe
        sleep 2000
        Run, % "powershell -NoProfile -Command ""Start-Process 'roblox://navigation/share_links?code=" code "&type=Server'"""
        sleep 8000
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        sleep 2000

        ; Skip button
        sleep 13000
        MouseMove, 960, 540, 3
        sleep 350
        MouseClick, Left
        sleep 2000
        startButtonSearch := A_TickCount
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 894, 811, 1013, 848, 0xFFFFFF, 3, Fast RGB
        if (ErrorLevel = 0) {
        MouseMove, 960, 825, 3
        sleep 350
        MouseClick, Left
        break
        }
        if (A_TickCount - startButtonSearch > 30000) {
        break
        }
        sleep 100
        }

        ; Start Button
        sleep 7000
        startButtonSearch2 := A_TickCount
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 814, 839, 962, 892, 0xFFFFFF, 3, Fast RGB
        if (ErrorLevel = 0) {
        MouseMove, 960, 870, 3
        sleep 350
        MouseClick, Left
        break
        }
        if (A_TickCount - startButtonSearch2 > 30000) {
        break
        }
        sleep 100
        }

        sleep 2500
        Send {F11}
        sleep 2500

        ; Reset timer after rejoining
        globalFailsafeTimer := A_TickCount
        restartPathing := true
        break
        }
        }

        ; Fishing Failsafe
        if (A_TickCount - startWhitePixelSearch > (fishingFailsafeTime * 1000) && !fishingFailsafeRan) {
        MouseMove, 1268, 941, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1167, 476, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1113, 342, 3
        sleep 300
        MouseClick, left
        sleep 300
        MouseMove, 851, 832, 3
        sleep 300
        MouseClick, Left
        fishingFailsafeRan := true
        }
        ; Pathing Failsafe
        if (A_TickCount - startWhitePixelSearch > (pathingFailsafeTime * 1000)) {
        restartPathing := true
        break
        }
        if (!toggle) {
        Return
        }
        }

        if (restartPathing) {
        continue
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
    global pathingMode
    global privateServerLink
    global globalFailsafeTimer
    global azertyPathing
    global autoUnequip
    global code
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    Loop {
        restartPathing := false
        if (!toggle) {
            break
        }

        loopCount++
        if (loopCount > maxLoopCount) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 2600
        if (autoUnequip) {
            MouseMove, 41, 538, 3
            sleep 300
            Click, Left
            sleep 300
            MouseMove, 1089, 575, 3
            sleep 300
            Click, Left
            sleep 300
            MouseMove, 835, 845, 3
            sleep 300
            Click, Left
            sleep 1200
            Click, Left
            sleep 300
            MouseMove, 1882, 395, 3
            sleep 300
            Click, Left
            sleep 300
        }
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

        if (pathingMode = "Non Vip Pathing") {
            ; Non VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 5190
            Send, {%keyW% Up}
            sleep 800
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 550
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 240
            Send {d Up
            sleep 150
            Send {%keyW% Down}
            sleep 1450
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1100
            Send {Space Up}
            sleep 520
            Send {%keyW% Up}
            sleep 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
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

            while (loopCount < fishingLoopCount) {
                MouseMove, 1117, 550, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 904, 1080, 3
                } else {
                    MouseMove, 700, 1078, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 1002, 831, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1958, 361, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 3300
            Send, {%keyW% Up}
            loopCount := 0
        } else if (pathingMode = "Vip Pathing") {
            ; VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 4150
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 400
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 180
            Send {d Up
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1200
            Send {Space Up}
            sleep 200
            Send {%keyW% Up}
            sleep 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
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

            while (loopCount < fishingLoopCount) {
                MouseMove, 1117, 550, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 904, 1080, 3
                } else {
                    MouseMove, 700, 1078, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 1002, 831, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1958, 361, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 2670
            Send, {%keyW% Up}
            loopCount := 0
        } else if (pathingMode = "Abyssal Pathing") {
            ; Abyssal Pathing
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
            Send, Abyssal Hunter
            sleep 200
            MouseMove, 1092, 579, 3
            sleep 200
            Click, WheelUp 100
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

            Send, {%keyW% Down}
            sleep 500
            Send, {%keyA% Down}
            sleep 2650
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 500
            Send {%keyW% Up}
            sleep 200
            Send {s Down}
            sleep 120
            Send {S Up}
            sleep 100
            Send {d Down}
            sleep 280
            Send {d Up}
            sleep 200
            Send {%keyA% Down}
            sleep 50
            Send {Space Down}
            sleep 730
            Send {Space Up}
            sleep 200
            Send {%keyA% Up}
            sleep 100
            Send {%keyW% Down}
            sleep 810
            Send {%keyW% Up}
            sleep 150
            Send {space Down}
            sleep 15
            Send {d Down}
            sleep 150
            Send {space Up}
            sleep 580
            Send {d Up}
            sleep 100
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300

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

            while (loopCount < fishingLoopCount) {
                MouseMove, 1117, 550, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 904, 1080, 3
                } else {
                    MouseMove, 700, 1078, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 1002, 831, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1958, 361, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 800
            Send, {%keyA% Up}
            sleep 100
            Send, {%keyW% Down}
            sleep 1760
            Send, {%keyW% Up}
            loopCount := 0
        }
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
        if (globalFailsafeTimer = 0) {
        globalFailsafeTimer := A_TickCount
        }
        fishingFailsafeRan := false
        Loop {
        PixelGetColor, color, 1536, 1119, RGB
        if (color = 0xFFFFFF) {
        MouseMove, 1263, 1177, 3
        ; Get randomized bar color
        Sleep 50
        PixelGetColor, barColor, 1261, 1033, RGB
        SetTimer, DoMouseMove2, Off
        globalFailsafeTimer := 0
        break
        }

        ; Auto Rejoin Failsafe
        if (A_TickCount - globalFailsafeTimer > (autoRejoinFailsafeTime * 1000) && privateServerLink != "") {
        PixelGetColor, checkColor, 1535, 1120, RGB
        if (checkColor != 0xFFFFFF) {
        Process, Close, RobloxPlayerBeta.exe
        sleep 2000
        Run, % "powershell -NoProfile -Command ""Start-Process 'roblox://navigation/share_links?code=" code "&type=Server'"""
        sleep 8000
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        sleep 2000

        ; Skip button
        sleep 13000
        MouseMove, 1280, 720, 3
        sleep 2000
        startButtonSearch := A_TickCount
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 1193, 1127, 1362, 1182, 0xFFFFFF, 3, Fast RGB
        if (ErrorLevel = 0) {
        MouseMove, 1280, 1150, 3
        sleep 350
        MouseClick, Left
        break
        }
        if (A_TickCount - startButtonSearch > 30000) {
        break
        }
        sleep 100
        }

        ; Start button
        sleep 7000
        startButtonSearch2 := A_TickCount
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 1074, 1169, 1289, 1251, 0xFFFFFF, 3, Fast RGB
        if (ErrorLevel = 0) {
        MouseMove, 1280, 1113, 3
        sleep 350
        MouseClick, Left
        break
        }
        if (A_TickCount - startButtonSearch2 > 30000) {
        break
        }
        sleep 100
        }

        sleep 2500
        Send {F11}
        sleep 2500

        globalFailsafeTimer := A_TickCount
        restartPathing := true
        break
        }
        }

        ; Fishing Failsafe
        if (A_TickCount - startWhitePixelSearch > (fishingFailsafeTime * 1000) && !fishingFailsafeRan) {
        MouseMove, 1690, 1224, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1523, 649, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1457, 491, 3
        sleep 300
        MouseClick, left
        sleep 300
        MouseMove, 1163, 1126, 3
        sleep 300
        MouseClick, Left
        fishingFailsafeRan := true
        }

        ; Pathing Failsafe
        if (A_TickCount - startWhitePixelSearch > (pathingFailsafeTime * 1000)) {
        restartPathing := true
        break
        }

        if (!toggle) {
        Return
        }
        }

        if (restartPathing) {
        continue
        }

        ; PixelSearch loop
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
    global pathingMode
    global privateServerLink
    global globalFailsafeTimer
    global azertyPathing
    global autoUnequip
    global code
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    Loop {
        restartPathing := false
        if (!toggle) {
            break
        }

        loopCount++
        if (loopCount > maxLoopCount) {
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 2600
        if (autoUnequip) {
            MouseMove, 38, 292, 3
            sleep 300
            Click, Left
            sleep 300
            MouseMove, 594, 314, 3
            sleep 300
            Click, Left
            sleep 300
            MouseMove, 458, 457, 3
            sleep 300
            Click, Left
            sleep 1200
            Click, Left
            sleep 300
            MouseMove, 1016, 218, 3
            sleep 300
            Click, Left
            sleep 300
        }
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

        if (pathingMode = "Non Vip Pathing") {
            ; Non VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 5190
            Send, {%keyW% Up}
            sleep 800
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 550
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 240
            Send {d Up
            sleep 150
            Send {%keyW% Down}
            sleep 1450
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1100
            Send {Space Up}
            sleep 520
            Send {%keyW% Up}
            sleep 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
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

            while (loopCount < fishingLoopCount) {
                MouseMove, 586, 287, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 486, 570, 3
                } else {
                    MouseMove, 365, 570, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 573, 447, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1050, 197, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 3300
            Send, {%keyW% Up}
            loopCount := 0
        } else if (pathingMode = "Vip Pathing") {
            ; VIP Pathing
            Send, {%keyW% Down}
            Send, {%keyA% Down}
            sleep 4150
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 400
            Send {%keyW% Up}
            sleep 300
            Send {d Down}
            sleep 180
            Send {d Up
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {S Up}
            sleep 300
            Send {Space Down}
            sleep 25
            Send {%keyW% Down}
            sleep 1200
            Send {Space Up}
            sleep 200
            Send {%keyW% Up}
            sleep 300
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300
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

            while (loopCount < fishingLoopCount) {
                MouseMove, 586, 287, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 486, 570, 3
                } else {
                    MouseMove, 365, 570, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 573, 447, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1050, 197, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 1400
            Send, {%keyA% Up}
            sleep 75
            Send, {%keyW% Down}
            sleep 2670
            Send, {%keyW% Up}
            loopCount := 0
        } else if (pathingMode = "Abyssal Pathing") {
            ; Abyssal Pathing
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
            Send, Abyssal Hunter
            sleep 200
            MouseMove, 584, 310, 3
            sleep 200
            Click, WheelUp 100
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

            Send, {%keyW% Down}
            sleep 500
            Send, {%keyA% Down}
            sleep 2650
            Send, {%keyW% Up}
            sleep 600
            Send {%keyA% Up}
            sleep 200
            Send {%keyW% Down}
            sleep 500
            Send {%keyW% Up}
            sleep 200
            Send {s Down}
            sleep 120
            Send {S Up}
            sleep 100
            Send {d Down}
            sleep 280
            Send {d Up}
            sleep 200
            Send {%keyA% Down}
            sleep 50
            Send {Space Down}
            sleep 730
            Send {Space Up}
            sleep 200
            Send {%keyA% Up}
            sleep 100
            Send {%keyW% Down}
            sleep 810
            Send {%keyW% Up}
            sleep 150
            Send {space Down}
            sleep 15
            Send {d Down}
            sleep 150
            Send {space Up}
            sleep 580
            Send {d Up}
            sleep 100
            Send {e Down}
            sleep 300
            Send {e Up}
            sleep 300

            MouseMove, 699, 574, 3
            sleep 50
            MouseClick, Left
            sleep 50
            MouseClick, Left
            sleep 200
            MouseMove, 689, 676, 3
            sleep 200
            MouseClick, Left
            sleep 800
            loopCount := 0

            while (loopCount < fishingLoopCount) {
                MouseMove, 597, 294, 3
                sleep 200
                MouseClick, Left
                sleep 200
                if (sellAllToggle) {
                    MouseMove, 484, 577, 3
                } else {
                    MouseMove, 374, 576, 3
                }
                sleep 200
                MouseClick, Left
                sleep 300
                MouseMove, 573, 447, 3
                sleep 200
                MouseClick, Left
                sleep 1000
                loopCount++
            }

            MouseMove, 1047, 193, 3
            sleep 200
            MouseClick, Left
            sleep 200
            Send, {%keyA% Down}
            sleep 800
            Send, {%keyA% Up}
            sleep 100
            Send, {%keyW% Down}
            sleep 1760
            Send, {%keyW% Up}
            loopCount := 0
        }
    }

        MouseMove, 603, 597, 3
        Sleep 300
        MouseClick, Left
        sleep 300
        barColor := 0
        otherBarColor := 0

        ; Check for white pixel
        startWhitePixelSearch := A_TickCount
        if (globalFailsafeTimer = 0) {
        globalFailsafeTimer := A_TickCount
        }
        fishingFailsafeRan := false
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

        ; Auto Rejoin Failsafe
        if (A_TickCount - globalFailsafeTimer > (autoRejoinFailsafeTime * 1000) && privateServerLink != "") {
        PixelGetColor, checkColor, 865, 593, RGB
        if (checkColor != 0xFFFFFF) {
        Process, Close, RobloxPlayerBeta.exe
        sleep 2000
        Run, % "powershell -NoProfile -Command ""Start-Process 'roblox://navigation/share_links?code=" code "&type=Server'"""
        sleep 8000
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        sleep 2000

        ; Skip button
        sleep 13000
        MouseMove, 683, 384, 3
        sleep 350
        MouseClick, Left
        sleep 2000
        startButtonSearch := A_TickCount
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 639, 567, 722, 590, 0xFFFFFF, 3, Fast RGB
        if (ErrorLevel = 0) {
        MouseMove, 683, 576, 3
        sleep 350
        MouseClick, Left
        break
        }
        if (A_TickCount - startButtonSearch > 30000) {
        break
        }
        sleep 100
        }

        ; Start button
        sleep 7000
        startButtonSearch2 := A_TickCount
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 582, 589, 688, 624, 0xFFFFFF, 3, Fast RGB
        if (ErrorLevel = 0) {
        MouseMove, 683, 610, 3
        sleep 350
        MouseClick, Left
        break
        }
        if (A_TickCount - startButtonSearch2 > 30000) {
        break
        }
        sleep 100
        }

        sleep 2500
        Send {F11}
        sleep 2500

        globalFailsafeTimer := A_TickCount
        restartPathing := true
        break
        }
        }

        ; Fishing Failsafe
        if (A_TickCount - startWhitePixelSearch > (fishingFailsafeTime * 1000) && !fishingFailsafeRan) {
        MouseMove, 902, 668, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 858, 331, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 817, 210, 3
        sleep 300
        MouseClick, left
        sleep 300
        MouseMove, 588, 588, 3
        sleep 300
        MouseClick, Left
        fishingFailsafeRan := true
        }
        ; Pathing Failsafe
        if (A_TickCount - startWhitePixelSearch > (pathingFailsafeTime * 1000)) {
        restartPathing := true
        break
        }
        if (!toggle) {
        Return
        }
        }

        if (restartPathing) {
        continue
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
        MouseClick, Left
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
    Gui, Submit, nohide
    if (MaxLoopInput > 0) {
        maxLoopCount := MaxLoopInput
    }
    if (FishingLoopInput > 0) {
        fishingLoopCount := FishingLoopInput
    }
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
        Gui, Submit, nohide
        if (MaxLoopInput > 0) {
            maxLoopCount := MaxLoopInput
        }
        if (FishingLoopInput > 0) {
            fishingLoopCount := FishingLoopInput
        }
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

SelectPathing:
Gui, Submit, nohide
IniWrite, %PathingMode%, %iniFilePath%, "Macro", "pathingMode"
pathingMode := PathingMode
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
} else if (dev1_name = "ivelchampion249") {
    Run, https://www.youtube.com/@ivelchampion
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
} else if (dev2_name = "ivelchampion249") {
    Run, https://www.youtube.com/@ivelchampion
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
} else if (dev3_name = "ivelchampion249") {
    Run, https://www.youtube.com/@ivelchampion
}
return

DonateClick:
Run, https://www.roblox.com/games/130758835005479/FishSol-Donations#!/store
return

NeedHelpClick:
Run, https://discord.gg/nPvA54ShTm
return


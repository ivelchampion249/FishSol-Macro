#Requires AutoHotkey v1.1
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
advancedFishingDetection := false
pathingMode := "Vip Pathing"
azertyPathing := false
autoUnequip := false
autoCloseChat := false
strangeController := false
biomeRandomizer := false
failsafeWebhook := false
pathingWebhook := false
itemWebhook := false
crafterToggle := false
autoCrafterDetection := false
autoCrafterLastCheck := 0
autoCrafterCheckInterval := 2000
strangeControllerTime := 0
biomeRandomizerTime := 360000
strangeControllerInterval := 1260000
biomeRandomizerInterval := 2160000
elapsed := 0
strangeControllerLastRun := 0
biomeRandomizerLastRun := 0
privateServerLink := ""
globalFailsafeTimer := 0
fishingFailsafeTime := 31
pathingFailsafeTime := 61
autoRejoinFailsafeTime := 320
advancedFishingThreshold := 25
webhookURL := ""
biomesPrivateServerLink := ""
biomeDetectionRunning := false
hasCrafterPlugin := FileExist(A_ScriptDir "\plugins\potions.ahk")

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
    IniRead, tempAdvancedDetection, %iniFilePath%, "Macro", "advancedFishingDetection"
    if (tempAdvancedDetection != "ERROR")
    {
        advancedFishingDetection := (tempAdvancedDetection = "true" || tempAdvancedDetection = "1")
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
    IniRead, tempStrangeController, %iniFilePath%, "Macro", "strangeController"
    if (tempStrangeController != "ERROR")
    {
        strangeController := (tempStrangeController = "true" || tempStrangeController = "1")
    }
    IniRead, tempBiomeRandomizer, %iniFilePath%, "Macro", "biomeRandomizer"
    if (tempBiomeRandomizer != "ERROR")
    {
        biomeRandomizer := (tempBiomeRandomizer = "true" || tempBiomeRandomizer = "1")
    }
    IniRead, tempAutoCloseChat, %iniFilePath%, "Macro", "autoCloseChat"
    if (tempAutoCloseChat != "ERROR")
    {
        autoCloseChat := (tempAutoCloseChat = "true" || tempAutoCloseChat = "1")
    }
    IniRead, tempWebhook, %iniFilePath%, "Macro", "webhookURL"
    if (tempWebhook != "ERROR")
    {
        webhookURL := tempWebhook
    }
    IniRead, tempBiomesPS, %iniFilePath%, "Biomes", "privateServerLink"
    if (tempBiomesPS != "ERROR")
    {
        biomesPrivateServerLink := tempBiomesPS
    }
    IniRead, tempFsWebhook, %iniFilePath%, "Macro", "failsafeWebhook"
    if (tempFsWebhook != "ERROR")
    {
        failsafeWebhook := (tempFsWebhook = "true" || tempFsWebhook = "1")
    }
    IniRead, tempPathingWebhook, %iniFilePath%, "Macro", "pathingWebhook"
    if (tempPathingWebhook != "ERROR")
    {
        pathingWebhook := (tempPathingWebhook = "true" || tempPathingWebhook = "1")
    }
    IniRead, tempItemWebhook, %iniFilePath%, "Macro", "itemWebhook"
    if (tempItemWebhook != "ERROR")
    {
        itemWebhook := (tempItemWebhook = "true" || tempItemWebhook = "1")
    }
    IniRead, tempCrafter, %iniFilePath%, "Macro", "crafterToggle"
    if (tempCrafter != "ERROR")
    {
        crafterToggle := (tempCrafter = "true" || tempCrafter = "1")
    }
    IniRead, tempAutoCrafterDetection, %iniFilePath%, "Macro", "autoCrafterDetection"
    if (tempAutoCrafterDetection != "ERROR")
    {
        autoCrafterDetection := (tempAutoCrafterDetection = "true" || tempAutoCrafterDetection = "1")
    }
}

; checks plugin folder
hasBiomesPlugin := FileExist(A_ScriptDir "\plugins\biomes.ahk")
hasCrafterPlugin := FileExist(A_ScriptDir "\plugins\potions.ahk")

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
    dev2_discord := "YouTube"
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
    dev3_discord := "YouTube"
    dev3_role := "Original Creator"
} else if (shuffle = 3) {
    dev1_name := "cresqnt"
    dev1_discord := "Scope Development (other macros)"
    dev1_role := "Frontend Developer"
    dev2_name := "ivelchampion249"
    dev2_discord := "YouTube"
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
    dev3_discord := "YouTube"
    dev3_role := "Original Creator"
} else if (shuffle = 5) {
    dev1_name := "ivelchampion249"
    dev1_discord := "YouTube"
    dev1_role := "Original Creator"
    dev2_name := "maxstellar"
    dev2_discord := "Twitch"
    dev2_role := "Lead Developer"
    dev3_name := "cresqnt"
    dev3_discord := "Scope Development (other macros)"
    dev3_role := "Frontend Developer"
} else {
    dev1_name := "ivelchampion249"
    dev1_discord := "YouTube"
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
Gui, Add, Text, x0 y10 w600 h45 Center BackgroundTrans c0x00D4FF, fishSol v1.9

Gui, Font, s9 cWhite Normal, Segoe UI

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x440 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x533 y601 w18 h19, %A_ScriptDir%\img\Robux.png


Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x425 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x325 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

Gui, Font, s10 cWhite Normal, Segoe UI

; adds plugin to tab list
tabList := "Main|Misc|Failsafes|Webhook"
if (hasBiomesPlugin)
    tabList .= "|Biomes"
if (hasCrafterPlugin)
    tabList .= "|Crafter"
tabList .= "|Credits"

Gui, Add, Tab3, x15 y55 w570 h600 vMainTabs gTabChange c0xFFFFFF, %tabList%

Gui, Tab, Main

Gui, Add, Picture, x14 y60 w574 h590, %A_ScriptDir%\gui\Main.png

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x440 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x533 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x425 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x325 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?


Gui, Font, s11 cWhite Normal Bold
Gui, Add, Text, x45 y110 w60 h25 BackgroundTrans, Status:
Gui, Add, Text, x98 y110 w150 h25 vStatusText BackgroundTrans c0xFF4444, Stopped

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Add, Button, x45 y140 w70 h35 gStartScript vStartBtn c0x00AA00 +0x8000, Start
Gui, Add, Button, x125 y140 w70 h35 gPauseScript vPauseBtn c0xFFAA00 +0x8000, Pause
Gui, Add, Button, x205 y140 w70 h35 gCloseScript vStopBtn c0xFF4444 +0x8000, Stop

Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x45 y185 w240 h15 BackgroundTrans, Hotkeys: F1=Start - F2=Pause - F3=Stop



Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x320 y110 w80 h25 BackgroundTrans, Resolution:
Gui, Add, DropDownList, x320 y135 w120 h200 vResolution gSelectRes, 1080p|1440p|1366x768

Gui, Font, s9 c0x00DD00 Bold
Gui, Add, Text, x320 y165 w220 h25 vResStatusText BackgroundTrans, Ready

Gui, Font, s10 cWhite Bold
Gui, Add, Button, x450 y135 w100 h25 gToggleSellAll vSellAllBtn, Toggle Sell All
Gui, Font, s8 c0xCCCCCC
Gui, Add, Text, x450 y165 w100 h25 vSellAllStatus BackgroundTrans, OFF

Gui, Font, s10 cWhite Bold, Segoe UI
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

Gui, Color, 0x1E1E1E
Gui, Font, s10 cWhite Bold, Segoe UI

Gui, Font, s11 c0xFF2C00 Bold
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x270 y380 w80 h25 gToggleAdvancedFishingDetection vAdvancedFishingDetectionBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x360 y384 w60 h25 vAdvancedFishingDetectionStatus BackgroundTrans, OFF

Gui, Font, s9 cWhite Bold, Segoe UI
Gui, Add, Text, x270 y415 w260 cWhite BackgroundTrans, Advanced Detection Threshold -
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x270 y435 w270 h40 BackgroundTrans c0xCCCCCC, Customize how many pixels are left in the fishing range before clicking.
Gui, Font, s10 cWhite Bold
Gui, Add, Text, x400 y384 w80 h25 BackgroundTrans, Pixels:
Gui, Font, s9 cWhite Bold
Gui, Add, Text, x453 y416 w120 BackgroundTrans c0xFF4444, Max : 40 Pixels
Gui, Font, s10 cWhite Bold
Gui, Add, Edit, x455 y380 w75 h25 vAdvancedThresholdInput gUpdateAdvancedThreshold Number Background0xD3D3D3 cBlack, %advancedFishingThreshold%

Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x50 y470 w515 h30 BackgroundTrans, Advanced Fishing Detection uses a system that clicks slightly before the bar exits the fish range, making the catch rate higher than ever.

Gui, Font, s9 c0x00D4FF Bold
Gui, Add, Text, x307 y485 w515 h30 BackgroundTrans c0x00D4FF, [ Recommended For Lower End Devices ]

Gui, Font, s11 cWhite Bold, Segoe UI
Gui, Add, Text, x50 y375 w100 h30 BackgroundTrans, Runtime:
Gui, Add, Text, x120 y375 w120 h30 vRuntimeText BackgroundTrans c0x00DD00, 00:00:00

Gui, Add, Text, x50 y405 w100 h30 BackgroundTrans, Cycles:
Gui, Add, Text, x102 y405 w120 h30 vCyclesText BackgroundTrans c0x00DD00, 0

Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x50 y545 w500 h20 BackgroundTrans, Requirements: 100`% Windows scaling - Roblox in fullscreen mode
Gui, Add, Text, x50 y563 w500 h20 BackgroundTrans, For best results, make sure you have good internet and avoid screen overlays


Gui, Tab, Misc

Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Misc.png

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x45 y135 h45 w250 BackgroundTrans c0xCCCCCC, Automatically unequips rolled auras every pathing cycle, preventing lag and pathing issues.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x45 y188 w80 h25 gToggleAutoUnequip vAutoUnequipBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x140 y192 w60 h25 vAutoUnequipStatus BackgroundTrans, OFF
Gui, Font, s10 cWhite Bold, Segoe UI

Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y260 w150 h25 BackgroundTrans, Strange Controller:
Gui, Add, Text, x45 y303 w190 h25 BackgroundTrans, Biome Randomizer:
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x200 y270 w80 h25 gToggleStrangeController vStrangeControllerBtn, Toggle
Gui, Add, Button, x200 y314 w80 h25 gToggleBiomeRandomizer vBiomeRandomizerBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x290 y275 w60 h25 vStrangeControllerStatus BackgroundTrans, OFF
Gui, Add, Text, x290 y319 w60 h25 vBiomeRandomizerStatus BackgroundTrans, OFF

Gui, Add, Progress, x41 y270 w1 h27 Background696868
Gui, Add, Progress, x190 y270 w1 h27 Background696868
Gui, Add, Progress, x41 y296 w149 h1 Background696868
Gui, Add, Progress, x184 y269 w7 h1 Background696868
Gui, Font, s10 cWhite Normal
Gui, Add, Text, x47 y278 w500 h40 BackgroundTrans c0xCCCCCC, Uses every 21 minutes.

Gui, Font, s10 cWhite Normal
Gui, Add, Text, x327 y275 w500 h15 BackgroundTrans, Automatically uses Strange Controller.

Gui, Add, Progress, x41 y313 w1 h27 Background696868
Gui, Add, Progress, x190 y313 w1 h27 Background696868
Gui, Add, Progress, x41 y339 w149 h1 Background696868
Gui, Add, Progress, x184 y313 w7 h1 Background696868
Gui, Font, s10 cWhite Normal
Gui, Add, Text, x47 y321 w500 h40 BackgroundTrans c0xCCCCCC, Uses every 36 minutes.

Gui, Font, s10 cWhite Normal
Gui, Add, Text, x327 y319 w500 h15 BackgroundTrans, Automatically uses Biome Randomizer.

Gui, Font, s10 cWhite Bold, Segoe UI
Gui, Font, s9 cWhite Normal
Gui, Add, Text, x320 y135 w230 h60 BackgroundTrans c0xCCCCCC, Automatically closes chat every pathing cycle to ensure you don't get stuck in collection.
Gui, Font, s10 cWhite Bold
Gui, Add, Button, x320 y188 w80 h25 gToggleAutoCloseChat vAutoCloseChatBtn, Toggle
Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
Gui, Add, Text, x415 y192 w60 h25 vAutoCloseChatStatus BackgroundTrans, OFF

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

Gui, Tab, Failsafes

Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Failsafes.png

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

Gui, Font, s9 cWhite Normal
Gui, Add, Text, x45 y370 w230 h40 BackgroundTrans c0xCCCCCC, Customize how long until the Fishing Failsafe triggers. (Default : 31)

Gui, Font, s11 cWhite Bold
Gui, Add, Text, x45 y413 w150 h35 BackgroundTrans, Seconds:
Gui, Add, Edit, x125 y411 w150 h25 vFishingFailsafeInput gUpdateFishingFailsafe Number Background0xD3D3D3 cBlack, %fishingFailsafeTime%

Gui, Font, s10 cWhite Bold, Segoe UI

Gui, Font, s9 cWhite Normal
Gui, Add, Text, x320 y370 w230 h45 BackgroundTrans c0xCCCCCC, Customize how long until the Pathing Failsafe triggers. (Default : 61)

Gui, Font, s11 cWhite Bold
Gui, Add, Text, x320 y413 w150 h35 BackgroundTrans, Seconds:
Gui, Add, Edit, x400 y411 w150 h25 vPathingFailsafeInput gUpdatePathingFailsafe Number Background0xD3D3D3 cBlack, %pathingFailsafeTime%

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?


if (hasBiomesPlugin) {
    Gui, Tab, Biomes

    Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Biomes.png

    Gui, Font, s9 cWhite Normal, Segoe UI
    Gui, Add, Text, x50 y299 w500 h20 BackgroundTrans c0xCCCCCC, Choose which biomes are sent to Discord:

    Gui, Font, s11 cWhite Bold, Segoe UI
    Gui, Add, CheckBox, x50 y320 w140 h25 vBiomeWindy gSaveBiomeToggles Checked1 cWhite, Windy
    Gui, Add, CheckBox, x50 y350 w140 h25 vBiomeSnowy gSaveBiomeToggles Checked1 cWhite, Snowy
    Gui, Add, CheckBox, x50 y380 w140 h25 vBiomeRainy gSaveBiomeToggles Checked1 cWhite, Rainy

    Gui, Add, CheckBox, x250 y320 w140 h25 vBiomeHell gSaveBiomeToggles Checked1 cWhite, Hell
    Gui, Add, CheckBox, x250 y350 w140 h25 vBiomeStarfall gSaveBiomeToggles Checked1 cWhite, Starfall
    Gui, Add, CheckBox, x250 y380 w140 h25 vBiomeCorruption gSaveBiomeToggles Checked1 cWhite, Corruption

    Gui, Add, CheckBox, x420 y380 w140 h25 vBiomeNormal gSaveBiomeToggles Checked1 cWhite, Normal
    Gui, Add, CheckBox, x420 y320 w140 h25 vBiomeSandStorm gSaveBiomeToggles Checked1 cWhite, Sand Storm
    Gui, Add, CheckBox, x420 y350 w140 h25 vBiomeNull gSaveBiomeToggles Checked1 cWhite, Null

    Gui, Font, s14 cWhite Bold
    Gui, Add, Text, x65 y420 c0x65FF65, Glitched
    Gui, Add, Text, x+1 y420, ,
    Gui, Add, Text, x+5 y420 c0xFF7DFF, Dreamspace
    Gui, Add, Text, x+5 y420, and
    Gui, Add, Text, x+5 y420 c0x00ddff, Cyberspace
    Gui, Add, Text, x+5 y420, are always on.

    Gui, Font, s10 cWhite Bold
    Gui, Add, Text, x50 y155 w200 h25 BackgroundTrans, Private Server Link:
    Gui, Add, Edit, x50 y185 w500 h25 vBiomesPrivateServerInput gUpdateBiomesPrivateServer Background0xD3D3D3 cBlack, %biomesPrivateServerLink%
    Gui, Font, s8 c0xCCCCCC Normal
    Gui, Add, Text, x50 y215 w500 h15 BackgroundTrans, Paste your Roblox private server link here for biome notifications.

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x425 y465 w115 h40 gOpenPluginsFolder, Open Plugins Folder

    Gui, Color, 0x1E1E1E
    Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
    Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

    Gui, Font, s11 cWhite Bold Underline, Segoe UI
    Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
    Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?
}

if (hasCrafterPlugin) {
    Gui, Tab, Crafter

    Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Crafter.png

    Gui, Font, s11 cWhite Bold, Segoe UI
    Gui, Add, Text, x45 y135 w200 h25 BackgroundTrans, example text:
    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x250 y135 w80 h25 gToggleCrafter vCrafterBtn, Toggle
    Gui, Font, s10 c0xCCCCCC Bold, Segoe UI
    Gui, Add, Text, x340 y140 w60 h25 vCrafterStatus BackgroundTrans, OFF

    Gui, Font, s9 cWhite Normal, Segoe UI
    Gui, Add, Text, x45 y185 w500 h60 BackgroundTrans c0xCCCCCC, example text

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x425 y505 w115 h40 gOpenPluginsFolder, Open Plugins Folder

    Gui, Color, 0x1E1E1E
    Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
    Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

    Gui, Font, s11 cWhite Bold Underline, Segoe UI
    Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
    Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?
}

Gui, Tab, Webhook

Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Webhook.png

Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x50 y125 w200 h25 BackgroundTrans, Discord Webhook URL:
Gui, Add, Edit, x50 y150 w500 h25 vWebhookInput gUpdateWebhook Background0xD3D3D3 cBlack, %webhookURL%
Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y180 w500 h15 BackgroundTrans, Paste your Discord webhook URL here to be notified of actions happening in real time.

Gui, Font, s10 cWhite Normal
Gui, Add, Text, x60 y246 w500 h40 BackgroundTrans c0xCCCCCC, When toggled, this sends a message when a failsafe triggers.
Gui, Add, Text, x60 y316 w500 h40 BackgroundTrans c0xCCCCCC, When toggled, this sends a message when the macro paths to auto-sell.
Gui, Add, Text, x60 y386 w500 h40 BackgroundTrans c0xCCCCCC, When toggled, this sends a message when items are used (eg. Strange Controller, Biome Randomizer).

Gui, Font, s10 cWhite Bold
Gui, Add, Button, x60 y216 w80 h25 gToggleFailsafeWebhook vFailsafeWebhookBtn, Toggle
Gui, Add, Text, x150 y220 w60 h25 vfailsafeWebhookStatus BackgroundTrans, OFF
Gui, Add, Button, x60 y286 w80 h25 gTogglePathingWebhook vPathingWebhookBtn, Toggle
Gui, Add, Text, x150 y290 w60 h25 vpathingWebhookStatus BackgroundTrans, OFF
Gui, Add, Button, x60 y356 w80 h25 gToggleItemWebhook vItemWebhookBtn, Toggle
Gui, Add, Text, x150 y360 w60 h25 vitemWebhookStatus BackgroundTrans, OFF
Gui, Font, s10 cWhite Normal

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

Gui, Tab, Credits

Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Credits.png

Gui, Add, Picture, x50 y130 w50 h50, %dev1_img%
Gui, Font, s11 cWhite Normal Bold
if (dev1_name = "cresqnt") {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x0088FF gDev1NameClick, %dev1_name%
} else {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x00DD00, %dev1_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y155 w300 h15 BackgroundTrans, %dev1_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y170 w300 h15 BackgroundTrans c0x0088FF gDev1LinkClick, %dev1_discord%

Gui, Font, s11 cWhite Normal Bold
Gui, Add, Picture, x50 y195 w50 h50, %dev2_img%
if (dev2_name = "cresqnt") {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x0088FF gDev2NameClick, %dev2_name%
} else {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x00DD00, %dev2_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y220 w300 h15 BackgroundTrans, %dev2_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y235 w300 h15 BackgroundTrans c0x0088FF gDev2LinkClick, %dev2_discord%

Gui, Add, Picture, x50 y260 w50 h50, %dev3_img%
Gui, Font, s11 cWhite Normal Bold
if (dev3_name = "cresqnt") {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x0088FF gDev3NameClick, %dev3_name%
} else {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x00DD00, %dev3_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y285 w300 h15 BackgroundTrans, %dev3_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y300 w300 h15 BackgroundTrans c0x0088FF gDev3LinkClick, %dev3_discord%

try {
    url := "https://raw.githubusercontent.com/ivelchampion249/FishSol-Macro/refs/heads/main/DONATORS.txt"

    Http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    Http.Open("GET", url, false)
    Http.Send()

    content := Http.ResponseText
} catch {
    content := "Failed to grab donator list."
}
Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x50 y345 w200 h20 BackgroundTrans, Thank you to our donators!
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Edit, x50 y370 w480 h125 vDonatorsList -Wrap +ReadOnly +VScroll -WantReturn -E0x200 Background0x2D2D2D c0xCCCCCC, %content%

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y518 w500 h15 BackgroundTrans, fishSol v1.9 - %randomMessage%

Gui, Show, w600 h670, fishSol v1.9

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

LoadBiomeToggles()

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

if (advancedFishingDetection) {
    GuiControl,, AdvancedFishingDetectionStatus, ON
    GuiControl, +c0x00DD00, AdvancedFishingDetectionStatus
} else {
    GuiControl,, AdvancedFishingDetectionStatus, OFF
    GuiControl, +c0xFF4444, AdvancedFishingDetectionStatus
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

if (autoCloseChat) {
    GuiControl,, AutoCloseChatStatus, ON
    GuiControl, +c0x00DD00, AutoCloseChatStatus
} else {
    GuiControl,, AutoCloseChatStatus, OFF
    GuiControl, +c0xFF4444, AutoCloseChatStatus
}

if (strangeController) {
    GuiControl,, StrangeControllerStatus, ON
    GuiControl, +c0x00DD00, StrangeControllerStatus
} else {
    GuiControl,, StrangeControllerStatus, OFF
    GuiControl, +c0xFF4444, StrangeControllerStatus
}

if (biomeRandomizer) {
    GuiControl,, BiomeRandomizerStatus, ON
    GuiControl, +c0x00DD00, BiomeRandomizerStatus
} else {
    GuiControl,, BiomeRandomizerStatus, OFF
    GuiControl, +c0xFF4444, BiomeRandomizerStatus
}

if (failsafeWebhook) {
    GuiControl,, failsafeWebhookStatus, ON
    GuiControl, +c0x00DD00, failsafeWebhookStatus
} else {
    GuiControl,, failsafeWebhookStatus, OFF
    GuiControl, +c0xFF4444, failsafeWebhookStatus
}

if (pathingWebhook) {
    GuiControl,, pathingWebhookStatus, ON
    GuiControl, +c0x00DD00, pathingWebhookStatus
} else {
    GuiControl,, pathingWebhookStatus, OFF
    GuiControl, +c0xFF4444, pathingWebhookStatus
}

if (itemWebhook) {
    GuiControl,, itemWebhookStatus, ON
    GuiControl, +c0x00DD00, itemWebhookStatus
} else {
    GuiControl,, itemWebhookStatus, OFF
    GuiControl, +c0xFF4444, itemWebhookStatus
}

if (hasCrafterPlugin) {
    if (crafterToggle) {
        GuiControl,, CrafterStatus, ON
        GuiControl, +c0x00DD00, CrafterStatus
        autoCrafterDetection := true
        autoCrafterLastCheck := A_TickCount
    } else {
        GuiControl,, CrafterStatus, OFF
        GuiControl, +c0xFF4444, CrafterStatus
        autoCrafterDetection := false
    }
}

return

GuiClose:
if (biomeDetectionRunning) {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2

    target := "biomes.ahk"
    WinGet, id, ID, %target% ahk_class AutoHotkey
    if (id) {
        WinClose, ahk_id %id%
    }
    biomeDetectionRunning := false
}
try SendWebhook(":red_circle: Macro Stopped.", "14495300")
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

ToggleAdvancedFishingDetection:
advancedFishingDetection := !advancedFishingDetection
if (advancedFishingDetection) {
    GuiControl,, AdvancedFishingDetectionStatus, ON
    GuiControl, +c0x00DD00, AdvancedFishingDetectionStatus
    IniWrite, true, %iniFilePath%, "Macro", "advancedFishingDetection"
} else {
    GuiControl,, AdvancedFishingDetectionStatus, OFF
    GuiControl, +c0xFF4444, AdvancedFishingDetectionStatus
    IniWrite, false, %iniFilePath%, "Macro", "advancedFishingDetection"
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
    IniWrite, false, %iniFilePath%, "Macro", "autoUnequip"
}
return

ToggleAutoCloseChat:
autoCloseChat := !autoCloseChat
if (autoCloseChat) {
    GuiControl,, AutoCloseChatStatus, ON
    GuiControl, +c0x00DD00, AutoCloseChatStatus
    IniWrite, true, %iniFilePath%, "Macro", "autoCloseChat"
} else {
    GuiControl,, AutoCloseChatStatus, OFF
    GuiControl, +c0xFF4444, AutoCloseChatStatus
    IniWrite, false, %iniFilePath%, "Macro", "autoCloseChat"
}
return

ToggleStrangeController:
strangeController := !strangeController
if (strangeController) {
    GuiControl,, StrangeControllerStatus, ON
    GuiControl, +c0x00DD00, StrangeControllerStatus
    IniWrite, true, %iniFilePath%, "Macro", "strangeController"
} else {
    GuiControl,, StrangeControllerStatus, OFF
    GuiControl, +c0xFF4444, StrangeControllerStatus
    IniWrite, false, %iniFilePath%, "Macro", "strangeController"
}
return

ToggleBiomeRandomizer:
biomeRandomizer := !biomeRandomizer
if (biomeRandomizer) {
    GuiControl,, BiomeRandomizerStatus, ON
    GuiControl, +c0x00DD00, BiomeRandomizerStatus
    IniWrite, true, %iniFilePath%, "Macro", "biomeRandomizer"
} else {
    GuiControl,, BiomeRandomizerStatus, OFF
    GuiControl, +c0xFF4444, BiomeRandomizerStatus
    IniWrite, false, %iniFilePath%, "Macro", "biomeRandomizer"
}
return

ToggleFailsafeWebhook:
failsafeWebhook := !failsafeWebhook
if (failsafeWebhook) {
    GuiControl,, failsafeWebhookStatus, ON
    GuiControl, +c0x00DD00, failsafeWebhookStatus
    IniWrite, true, %iniFilePath%, "Macro", "failsafeWebhook"
} else {
    GuiControl,, failsafeWebhookStatus, OFF
    GuiControl, +c0xFF4444, failsafeWebhookStatus
    IniWrite, false, %iniFilePath%, "Macro", "failsafeWebhook"
}
return

TogglePathingWebhook:
pathingWebhook := !pathingWebhook
if (pathingWebhook) {
    GuiControl,, pathingWebhookStatus, ON
    GuiControl, +c0x00DD00, pathingWebhookStatus
    IniWrite, true, %iniFilePath%, "Macro", "pathingWebhook"
} else {
    GuiControl,, pathingWebhookStatus, OFF
    GuiControl, +c0xFF4444, pathingWebhookStatus
    IniWrite, false, %iniFilePath%, "Macro", "pathingWebhook"
}
return

ToggleItemWebhook:
itemWebhook := !itemWebhook
if (itemWebhook) {
    GuiControl,, itemWebhookStatus, ON
    GuiControl, +c0x00DD00, itemWebhookStatus
    IniWrite, true, %iniFilePath%, "Macro", "itemWebhook"
} else {
    GuiControl,, itemWebhookStatus, OFF
    GuiControl, +c0xFF4444, itemWebhookStatus
    IniWrite, false, %iniFilePath%, "Macro", "itemWebhook"
}
return

ToggleCrafter:
crafterToggle := !crafterToggle
if (crafterToggle) {
    GuiControl,, CrafterStatus, ON
    GuiControl, +c0x00DD00, CrafterStatus
    IniWrite, true, %iniFilePath%, "Macro", "crafterToggle"
    autoCrafterDetection := true
    autoCrafterLastCheck := A_TickCount
    IniWrite, true, %iniFilePath%, "Macro", "autoCrafterDetection"
} else {
    GuiControl,, CrafterStatus, OFF
    GuiControl, +c0xFF4444, CrafterStatus
    IniWrite, false, %iniFilePath%, "Macro", "crafterToggle"
    autoCrafterDetection := false
    IniWrite, false, %iniFilePath%, "Macro", "autoCrafterDetection"
}
return

; Auto Crafter
RunAutoCrafter() {
    global hasCrafterPlugin
    global itemWebhook
    global globalFailsafeTimer
    global fishingFailsafeTime
    global pathingFailsafeTime
    global autoRejoinFailsafeTime

    if (!hasCrafterPlugin) {
        return
    }

    autoCrafterDetection := false

    originalFishingFailsafeTime := fishingFailsafeTime
    originalPathingFailsafeTime := pathingFailsafeTime
    originalAutoRejoinFailsafeTime := autoRejoinFailsafeTime
    originalGlobalFailsafeTimer := globalFailsafeTimer

    fishingFailsafeTime := 999999
    pathingFailsafeTime := 999999
    autoRejoinFailsafeTime := 999999
    globalFailsafeTimer := 0

    Run, "%A_ScriptDir%\plugins\potions.ahk"

    ; webhoook
    if (itemWebhook) {
        try SendWebhook(":tools: Auto Crafter activated!", "9932cc")
    }

    Sleep, 1000
    Sleep, 5000

    fishingFailsafeTime := originalFishingFailsafeTime
    pathingFailsafeTime := originalPathingFailsafeTime
    autoRejoinFailsafeTime := originalAutoRejoinFailsafeTime
    globalFailsafeTimer := originalGlobalFailsafeTimer

    Send, {Esc}
    Sleep, 650
    Send, R
    Sleep, 650
    Send, {Enter}
    sleep 2600

    ; Re-enable detection
    autoCrafterDetection := true
    autoCrafterLastCheck := A_TickCount
}

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

UpdateWebhook:
Gui, Submit, nohide
webhookURL := WebhookInput
IniWrite, %webhookURL%, %iniFilePath%, "Macro", "webhookURL"
return

UpdateBiomesPrivateServer:
Gui, Submit, nohide
biomesPrivateServerLink := BiomesPrivateServerInput
IniWrite, %biomesPrivateServerLink%, %iniFilePath%, "Biomes", "privateServerLink"
return

LoadBiomeToggles() {
    global
    IniRead, BiomeNormal, %iniFilePath%, "Biomes", BiomeNormal, 1
    IniRead, BiomeSandStorm, %iniFilePath%, "Biomes", BiomeSandStorm, 1
    IniRead, BiomeHell, %iniFilePath%, "Biomes", BiomeHell, 1
    IniRead, BiomeStarfall, %iniFilePath%, "Biomes", BiomeStarfall, 1
    IniRead, BiomeCorruption, %iniFilePath%, "Biomes", BiomeCorruption, 1
    IniRead, BiomeWindy, %iniFilePath%, "Biomes", BiomeWindy, 1
    IniRead, BiomeSnowy, %iniFilePath%, "Biomes", BiomeSnowy, 1
    IniRead, BiomeRainy, %iniFilePath%, "Biomes", BiomeRainy, 1
    IniRead, BiomePumpkinMoon, %iniFilePath%, "Biomes", BiomePumpkinMoon, 1
    IniRead, BiomeGraveyard, %iniFilePath%, "Biomes", BiomeGraveyard, 1
    IniRead, BiomeBloodRain, %iniFilePath%, "Biomes", BiomeBloodRain, 1
    IniRead, BiomeNull, %iniFilePath%, "Biomes", BiomeNull, 1

    GuiControl,, BiomeNormal, %BiomeNormal%
    GuiControl,, BiomeSandStorm, %BiomeSandStorm%
    GuiControl,, BiomeHell, %BiomeHell%
    GuiControl,, BiomeStarfall, %BiomeStarfall%
    GuiControl,, BiomeCorruption, %BiomeCorruption%
    GuiControl,, BiomeWindy, %BiomeWindy%
    GuiControl,, BiomeSnowy, %BiomeSnowy%
    GuiControl,, BiomeRainy, %BiomeRainy%
    GuiControl,, BiomePumpkinMoon, %BiomePumpkinMoon%
    GuiControl,, BiomeGraveyard, %BiomeGraveyard%
    GuiControl,, BiomeBloodRain, %BiomeBloodRain%
    GuiControl,, BiomeNull, %BiomeNull%
}

SaveBiomeToggles:
Gui, Submit, NoHide
IniWrite, %BiomeNormal%, %iniFilePath%, "Biomes", BiomeNormal
IniWrite, %BiomeSandStorm%, %iniFilePath%, "Biomes", BiomeSandStorm
IniWrite, %BiomeHell%, %iniFilePath%, "Biomes", BiomeHell
IniWrite, %BiomeStarfall%, %iniFilePath%, "Biomes", BiomeStarfall
IniWrite, %BiomeCorruption%, %iniFilePath%, "Biomes", BiomeCorruption
IniWrite, %BiomeWindy%, %iniFilePath%, "Biomes", BiomeWindy
IniWrite, %BiomeSnowy%, %iniFilePath%, "Biomes", BiomeSnowy
IniWrite, %BiomeRainy%, %iniFilePath%, "Biomes", BiomeRainy
IniWrite, %BiomePumpkinMoon%, %iniFilePath%, "Biomes", BiomePumpkinMoon
IniWrite, %BiomeGraveyard%, %iniFilePath%, "Biomes", BiomeGraveyard
IniWrite, %BiomeBloodRain%, %iniFilePath%, "Biomes", BiomeBloodRain
IniWrite, %BiomeNull%, %iniFilePath%, "Biomes", BiomeNull
return

; webhooks!
SendWebhook(title, color := "16777215") {
    global webhookURL
    if (!InStr(webhookURL, "discord")) {
        return
    }
    try {
        time := A_NowUTC
        timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2) "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

        json := "{"
        . """embeds"": ["
        . "{"
        . "    ""title"": """ title ""","
        . "    ""color"": " color ","
        . "    ""footer"": {""text"": ""fishSol v1.9"", ""icon_url"": ""https://maxstellar.github.io/fishSol%20icon.png""},"
        . "    ""timestamp"": """ timestamp """"
        . "  }"
        . "],"
        . """content"": """""
        . "}"

        http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        http.Open("POST", webhookURL, false)
        http.SetRequestHeader("Content-Type", "application/json")
        http.Send(json)
    }
}


; SC toggle
RunStrangeController() {
    global res
    global itemWebhook
    tryCount := 0
    ; 1080p
    if (res = "1080p") {
        sleep 300
        MouseMove, 46, 520, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1279, 342, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1104, 368, 3
        sleep 300
        MouseClick, Left
        Clipboard := "Strange Controller"
        sleep 300
        Send, ^v
        sleep 300
        MouseMove, 848, 479, 3
        sleep 300
        MouseClick, Left
        sleep 300

        Loop {
            PixelSearch, Px, Py, 571, 668, 571, 668, 0xf0a66f, 3, Fast RGB
            if (!ErrorLevel || tryCount > 3) {
                if (tryCount <= 3) {
                    MouseMove, 682, 578, 3
                    sleep 300
                    MouseClick, Left
                    sleep 300
                }
                break
            } else {
                tryCount++
                MsgBox, % tryCount
                MouseMove, 1279, 342, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1104, 368, 3
                sleep 300
                MouseClick, Left
                Clipboard := "Strange Controller"
                sleep 300
                Send, ^v
                sleep 300
                MouseMove, 848, 479, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 1413, 297, 3
        sleep 300
        MouseClick, Left
        sleep 300
    }
    ; 1440p
    else if (res = "1440p") {
        sleep 300
        MouseMove, 52, 693, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1704, 452, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1473, 489, 3
        sleep 300
        MouseClick, Left
        Clipboard := "Strange Controller"
        sleep 300
        Send, ^v
        sleep 300
        MouseMove, 1144, 643, 3
        sleep 300
        MouseClick, Left
        sleep 300

        Loop {
            PixelSearch, Px, Py, 735, 873, 735, 873, 0xf0a66f, 3, Fast RGB
            if (!ErrorLevel || tryCount > 3) {
                if (tryCount <= 3) {
                    MouseMove, 920, 774, 3
                    sleep 300
                    MouseClick, Left
                    sleep 300
                }
                break
            } else {
                tryCount++
                MsgBox, % tryCount
                MouseMove, 1704, 452, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1473, 489, 3
                sleep 300
                MouseClick, Left
                Clipboard := "Strange Controller"
                sleep 300
                Send, ^v
                sleep 300
                MouseMove, 1144, 643, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 1896, 403, 3
        sleep 300
        MouseClick, Left
        sleep 300
    }
    ; 1366x768
    else if (res = "1366x768") {
        sleep 300
        MouseMove, 42, 376, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 911, 242, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 785, 262, 3
        sleep 300
        MouseClick, Left
        Clipboard := "Strange Controller"
        sleep 300
        Send, ^v
        sleep 300
        MouseMove, 616, 347, 3
        sleep 300
        MouseClick, Left
        sleep 300

        Loop {
            PixelSearch, Px, Py, 429, 507, 429, 507, 0xeea66e, 3, Fast RGB
            if (!ErrorLevel || tryCount > 3) {
                if (tryCount <= 3) {
                    MouseMove, 486, 413, 3
                    sleep 300
                    MouseClick, Left
                    sleep 300
                }
                break
            } else {
                tryCount++
                MouseMove, 911, 242, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 785, 262, 3
                sleep 300
                MouseClick, Left
                Clipboard := "Strange Controller"
                sleep 300
                Send, ^v
                sleep 300
                MouseMove, 616, 347, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 1017, 214, 3
        sleep 300
        MouseClick, Left
        sleep 300
    }
    if (itemWebhook) {
        try SendWebhook(":joystick: Strange Controller was used.", "3225405")
    }
}

; BR Toggle
RunBiomeRandomizer() {
    global res
    global itemWebhook
    tryCount := 0
    ; 1080p
    if (res = "1080p") {
        sleep 300
        MouseMove, 46, 520, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1279, 342, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1104, 368, 3
        sleep 300
        MouseClick, Left
        Clipboard := "Biome Randomizer"
        sleep 300
        Send, ^v
        sleep 300
        MouseMove, 848, 479, 3
        sleep 300
        MouseClick, Left
        sleep 300

        Loop {
            PixelSearch, Px, Py, 663, 667, 663, 667, 0x3ffe7a, 3, Fast RGB
            if (!ErrorLevel || tryCount > 3) {
                if (tryCount <= 3) {
                    MouseMove, 682, 578, 3
                    sleep 300
                    MouseClick, Left
                    sleep 300
                }
                break
            } else {
                tryCount++
                MouseMove, 1279, 342, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1104, 368, 3
                sleep 300
                MouseClick, Left
                Clipboard := "Biome Randomizer"
                sleep 300
                Send, ^v
                sleep 300
                MouseMove, 848, 479, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 1413, 297, 3
        sleep 300
        MouseClick, Left
        sleep 300
    }
    ; 1440p
    else if (res = "1440p") {
        sleep 300
        MouseMove, 52, 693, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1704, 452, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 1473, 489, 3
        sleep 300
        MouseClick, Left
        Clipboard := "Biome Randomizer"
        sleep 300
        Send, ^v
        sleep 300
        MouseMove, 1144, 643, 3
        sleep 300
        MouseClick, Left
        sleep 300

        Loop {
            PixelSearch, Px, Py, 827, 856, 827, 856, 0x3ffe7a, 3, Fast RGB
            if (!ErrorLevel || tryCount > 3) {
                if (tryCount <= 2) {
                    MouseMove, 920, 774, 3
                    sleep 300
                    MouseClick, Left
                    sleep 300
                }
                break
            } else {
                tryCount++
                MouseMove, 1704, 452, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1473, 489, 3
                sleep 300
                MouseClick, Left
                Clipboard := "Biome Randomizer"
                sleep 300
                Send, ^v
                sleep 300
                MouseMove, 1144, 643, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 1896, 403, 3
        sleep 300
        MouseClick, Left
        sleep 300
    }
    ; 1366x768
    else if (res = "1366x768") {
        sleep 300
        MouseMove, 42, 376, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 911, 242, 3
        sleep 300
        MouseClick, Left
        sleep 300
        MouseMove, 785, 262, 3
        sleep 300
        MouseClick, Left
        Clipboard := "Biome Randomizer"
        sleep 300
        Send, ^v
        sleep 300
        MouseMove, 616, 347, 3
        sleep 300
        MouseClick, Left
        sleep 300

        Loop {
            PixelSearch, Px, Py, 363, 554, 363, 554, 0x6b0700, 3, Fast RGB
            if (!ErrorLevel || tryCount > 3) {
                if (tryCount <= 3) {
                    MouseMove, 486, 413, 3
                    sleep 300
                    MouseClick, Left
                    sleep 300
                }
                break
            } else {
                tryCount++
                MouseMove, 911, 242, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 785, 262, 3
                sleep 300
                MouseClick, Left
                Clipboard := "Biome Randomizer"
                sleep 300
                Send, ^v
                sleep 300
                MouseMove, 616, 347, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 1017, 214, 3
        sleep 300
        MouseClick, Left
        sleep 300
    }
    if (itemWebhook) {
        try SendWebhook(":joystick: Biome Randomizer was used.", "3225405")
    }
}

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
    if (hasBiomesPlugin) {
        Run, "%A_ScriptDir%\plugins\biomes.ahk"
        biomeDetectionRunning := true
    }
    if (startTick = "") {
        startTick := A_TickCount
    }
    if (cycleCount = "") {
        cycleCount := 0
    }
    strangeControllerLastRun := 0
    biomeRandomizerLastRun := 0
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
    try SendWebhook(":green_circle: Macro Started!", "7909721")
}
Return

F2::
if (toggle) {
    if (biomeDetectionRunning) {
        DetectHiddenWindows, On
        SetTitleMatchMode, 2

        target := "biomes.ahk"
        WinGet, id, ID, %target% ahk_class AutoHotkey
        if (id) {
            WinClose, ahk_id %id%
        }
        biomeDetectionRunning := false
    }
    toggle := false
    firstLoop := true
    SetTimer, DoMouseMove, Off
    SetTimer, DoMouseMove2, Off
    SetTimer, DoMouseMove3, Off
    SetTimer, UpdateGUI, Off
    ManualGUIUpdate()
    ToolTip
    try SendWebhook(":yellow_circle: Macro Paused", "16632664")
}
Return

F3::
if (biomeDetectionRunning) {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2

    target := "biomes.ahk"
    WinGet, id, ID, %target% ahk_class AutoHotkey
    if (id) {
        WinClose, ahk_id %id%
    }
    biomeDetectionRunning := false
}
try SendWebhook(":red_circle: Macro Stopped.", "14495300")
ExitApp

;1080p
DoMouseMove:
if (toggle) {
    global pathingMode
    global privateServerLink
    global globalFailsafeTimer
    global azertyPathing
    global autoUnequip
    global autoCloseChat
    global code
    global strangeController
    global biomeRandomizer
    global strangeControllerTime
    global biomeRandomizerTime
    global strangeControllerInterval
    global biomeRandomizerInterval
    global strangeControllerLastRun
    global biomeRandomizerLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    global hasCrafterPlugin
    global crafterToggle
    global autoCrafterDetection
    global autoCrafterLastCheck
    global autoCrafterCheckInterval
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }

        ; SC Toggle
        if (strangeController) {
            elapsed := A_TickCount - startTick
            if (strangeControllerLastRun = 0 && elapsed >= strangeControllerTime) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            } else if (strangeControllerLastRun > 0 && (elapsed - strangeControllerLastRun) >= strangeControllerInterval) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            }
        }

        ; BR Toggle
        if (biomeRandomizer) {
            elapsed := A_TickCount - startTick
            if (biomeRandomizerLastRun = 0 && elapsed >= biomeRandomizerTime) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            } else if (biomeRandomizerLastRun > 0 && (elapsed - biomeRandomizerLastRun) >= biomeRandomizerInterval) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            }
        }

        ; Auto Crafter Detection (copy and pasted, need to change the coords)
        if (hasCrafterPlugin && crafterToggle && autoCrafterDetection) {
            currentTime := A_TickCount
            if (currentTime - autoCrafterLastCheck >= autoCrafterCheckInterval) {
                autoCrafterLastCheck := currentTime
                PixelSearch, Px, Py, 2203, 959, 2203, 959, 0x6eb4ff, 3, RGB
                if (!ErrorLevel) {
                    RunAutoCrafter()
                }
            }
        }

        loopCount++
        if (loopCount > maxLoopCount || restartPathing) {
        restartPathing := false
        if (pathingWebhook) {
            try SendWebhook(":moneybag: Macro started pathing to auto-sell!", "16636040")
        }
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
        if (autoCloseChat) {
            sleep 300
            Send {/}
            sleep 300
            MouseMove, 149, 40, 3
            sleep 300
            MouseClick, Left
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
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1450
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {s Up}
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
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {s Up}
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
            Send {s Up}
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
        code := ""
        if RegExMatch(privateServerLink, "code=([^&]+)", m)
        {
            code := m1
        }
        PixelGetColor, checkColor, 1175, 837, RGB
        if (checkColor != 0xFFFFFF) {
        Process, Close, RobloxPlayerBeta.exe
        sleep 500
        Run, % "powershell -NoProfile -Command ""Start-Process 'roblox://navigation/share_links?code=" code "&type=Server'"""
        sleep 5000
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        sleep 7000
        MouseMove, 960, 540, 3
        sleep 200
        MouseClick, Left
        sleep 6000

        ; Start button
        sleep 1000
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 205, 1019, 325, 978, 0x82ff95, 5, Fast RGB
        if (ErrorLevel = 0) {
        sleep 1000
        MouseMove, 267, 1000, 3
        sleep 350
        MouseClick, Left
        break
        }
        }

        sleep 3000
        restartPathing := true
        try SendWebhook(":repeat: Auto-Rejoin failsafe was triggered.", "3426654")
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
        if (failsafeWebhook) {
            try SendWebhook(":grey_question: Fishing failsafe was triggered.", "13424349")
        }
        }
        ; Pathing Failsafe
        if (A_TickCount - startWhitePixelSearch > (pathingFailsafeTime * 1000)) {
        restartPathing := true
        if (failsafeWebhook) {
            try SendWebhook(":feet: Pathing failsafe was triggered.", "6693139")
        }
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

        ; Advanced detection
        if (advancedFishingDetection) {
            ErrorLevel := 0
            PixelSearch, leftX, leftY, 757, 767, 1161, 767, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
                rightX := leftX
                Loop {
                    testX := rightX + 1
                    if (testX > 1161)
                        break
                    PixelGetColor, testColor, %testX%, 767, RGB
                    if (Abs((testColor & 0xFF) - (barColor & 0xFF)) <= 10 && Abs(((testColor >> 8) & 0xFF) - ((barColor >> 8) & 0xFF)) <= 10 && Abs(((testColor >> 16) & 0xFF) - ((barColor >> 16) & 0xFF)) <= 10) {
                        rightX := testX
                    } else {
                        break
                    }
                }
                barWidth := rightX - leftX
                if (barWidth < advancedFishingThreshold) {
                    MouseClick, left
                    sleep 25
                }
            } else {
                MouseClick, left
            }
            sleep 10
        } else {
            ; Normal detection
            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 757, 762, 1161, 782, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
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
    global autoCloseChat
    global code
    global strangeController
    global biomeRandomizer
    global strangeControllerTime
    global biomeRandomizerTime
    global strangeControllerInterval
    global biomeRandomizerInterval
    global strangeControllerLastRun
    global biomeRandomizerLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    global hasCrafterPlugin
    global crafterToggle
    global autoCrafterDetection
    global autoCrafterLastCheck
    global autoCrafterCheckInterval
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }

        ; SC Toggle
        if (strangeController) {
            elapsed := A_TickCount - startTick
            if (strangeControllerLastRun = 0 && elapsed >= strangeControllerTime) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            } else if (strangeControllerLastRun > 0 && (elapsed - strangeControllerLastRun) >= strangeControllerInterval) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            }
        }

        ; BR Toggle
        if (biomeRandomizer) {
            elapsed := A_TickCount - startTick
            if (biomeRandomizerLastRun = 0 && elapsed >= biomeRandomizerTime) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            } else if (biomeRandomizerLastRun > 0 && (elapsed - biomeRandomizerLastRun) >= biomeRandomizerInterval) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            }
        }

        ; Auto Crafter Detection
        if (hasCrafterPlugin && crafterToggle && autoCrafterDetection) {
            currentTime := A_TickCount
            if (currentTime - autoCrafterLastCheck >= autoCrafterCheckInterval) {
                autoCrafterLastCheck := currentTime
                PixelSearch, Px, Py, 2203, 959, 2203, 959, 0x6eb4ff, 3, RGB
                if (!ErrorLevel) {
                    RunAutoCrafter()
                }
            }
        }

        loopCount++
        if (loopCount > maxLoopCount || restartPathing) {
        restartPathing := false
        if (pathingWebhook) {
            try SendWebhook(":moneybag: Macro started pathing to auto-sell!", "16636040")
        }
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
        if (autoCloseChat) {
            sleep 300
            Send {/}
            sleep 300
            MouseMove, 151, 38, 3
            sleep 300
            MouseClick, Left
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
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1450
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {s Up}
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
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {s Up}
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
            Send {s Up}
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
        code := ""
        if RegExMatch(privateServerLink, "code=([^&]+)", m)
        {
            code := m1
        }
        PixelGetColor, checkColor, 1535, 1120, RGB
        if (checkColor != 0xFFFFFF) {
        Process, Close, RobloxPlayerBeta.exe
        sleep 500
        Run, % "powershell -NoProfile -Command ""Start-Process 'roblox://navigation/share_links?code=" code "&type=Server'"""
        sleep 5000
        WinActivate, ahk_exe RobloxPlayerBeta.exe
        sleep 6000

        ; Skip button
        sleep 1000
        MouseMove, 1280, 720, 3
        sleep 200
        MouseClick, Left
        sleep 6000

        ; Start button
        sleep 1000
        Loop {
        ErrorLevel := 0
        PixelSearch, px, py, 295, 1364, 445, 1311, 0x82ff95, 5, Fast RGB
        if (ErrorLevel = 0) {
        sleep 1000
        MouseMove, 347, 1329, 3
        sleep 350
        MouseClick, Left
        break
        }
        sleep 100
        }

        sleep 3000
        restartPathing := true
        try SendWebhook(":repeat: Auto-Rejoin failsafe was triggered.", "3426654")
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
        if (failsafeWebhook) {
            try SendWebhook(":grey_question: Fishing failsafe was triggered.", "13424349")
        }
        }

        ; Pathing Failsafe
        if (A_TickCount - startWhitePixelSearch > (pathingFailsafeTime * 1000)) {
        restartPathing := true
        if (failsafeWebhook) {
            try SendWebhook(":feet: Pathing failsafe was triggered.", "6693139")
        }
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

        ; Advanced detection
        if (advancedFishingDetection) {
            ErrorLevel := 0
            PixelSearch, leftX, leftY, 1043, 1033, 1519, 1033, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
                rightX := leftX
                Loop {
                    testX := rightX + 1
                    if (testX > 1519)
                        break
                    PixelGetColor, testColor, %testX%, 1033, RGB
                    if (Abs((testColor & 0xFF) - (barColor & 0xFF)) <= 10 && Abs(((testColor >> 8) & 0xFF) - ((barColor >> 8) & 0xFF)) <= 10 && Abs(((testColor >> 16) & 0xFF) - ((barColor >> 16) & 0xFF)) <= 10) {
                        rightX := testX
                    } else {
                        break
                    }
                }
                barWidth := rightX - leftX
                if (barWidth < advancedFishingThreshold) {
                    MouseClick, left
                    sleep 25
                }
            } else {
                MouseClick, left
            }
        } else {
            ; Normal detection
            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 1043, 1033, 1519, 1058, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
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
    global autoCloseChat
    global code
    global strangeController
    global biomeRandomizer
    global strangeControllerTime
    global biomeRandomizerTime
    global strangeControllerInterval
    global biomeRandomizerInterval
    global strangeControllerLastRun
    global biomeRandomizerLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    global hasCrafterPlugin
    global crafterToggle
    global autoCrafterDetection
    global autoCrafterLastCheck
    global autoCrafterCheckInterval
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }

        ; SC Toggle
        if (strangeController) {
            elapsed := A_TickCount - startTick
            if (strangeControllerLastRun = 0 && elapsed >= strangeControllerTime) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            } else if (strangeControllerLastRun > 0 && (elapsed - strangeControllerLastRun) >= strangeControllerInterval) {
                RunStrangeController()
                strangeControllerLastRun := elapsed
            }
        }

        ; BR Toggle
        if (biomeRandomizer) {
            elapsed := A_TickCount - startTick
            if (biomeRandomizerLastRun = 0 && elapsed >= biomeRandomizerTime) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            } else if (biomeRandomizerLastRun > 0 && (elapsed - biomeRandomizerLastRun) >= biomeRandomizerInterval) {
                RunBiomeRandomizer()
                biomeRandomizerLastRun := elapsed
            }
        }

        ; Auto Crafter Detection (copy and pasted, need to change the coords)
        if (hasCrafterPlugin && crafterToggle && autoCrafterDetection) {
            currentTime := A_TickCount
            if (currentTime - autoCrafterLastCheck >= autoCrafterCheckInterval) {
                autoCrafterLastCheck := currentTime
                PixelSearch, Px, Py, 2203, 959, 2203, 959, 0x6eb4ff, 3, RGB
                if (!ErrorLevel) {
                    RunAutoCrafter()
                }
            }
        }

        loopCount++
        if (loopCount > maxLoopCount || restartPathing) {
        restartPathing := false
        if (pathingWebhook) {
            try SendWebhook(":moneybag: Macro started pathing to auto-sell!", "16636040")
        }
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
        if (autoCloseChat) {
            sleep 300
            Send {/}
            sleep 300
            MouseMove, 151, 42, 3
            sleep 300
            MouseClick, Left
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
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1450
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {s Up}
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
            Send {d Up}
            sleep 150
            Send {%keyW% Down}
            sleep 1100
            Send {%keyW% Up}
            sleep 300
            Send {s Down}
            sleep 300
            Send {s Up}
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
            Send {s Up}
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
            code := ""
            if RegExMatch(privateServerLink, "code=([^&]+)", m)
            {
                code := m1
            }
            PixelGetColor, checkColor, 865, 593, RGB
            if (checkColor != 0xFFFFFF) {
            Process, Close, RobloxPlayerBeta.exe
            sleep 500
            Run, % "powershell -NoProfile -Command ""Start-Process 'roblox://navigation/share_links?code=" code "&type=Server'"""
            sleep 5000
            WinActivate, ahk_exe RobloxPlayerBeta.exe
            sleep 7000
            MouseMove, 683, 384, 3
            sleep 200
            MouseClick, Left
            sleep 6000

            ; Start button
            sleep 1000
            Loop {
            ErrorLevel := 0
            PixelSearch, px, py, 160, 734, 244, 708, 0x82ff95, 5, Fast RGB
            if (ErrorLevel = 0) {
            sleep 1000
            MouseMove, 200, 715, 3
            sleep 350
            MouseClick, Left
            break
            }
            }

            sleep 3000
            restartPathing := true
            try SendWebhook(":repeat: Auto-Rejoin failsafe was triggered.", "3426654")
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
        if (failsafeWebhook) {
            try SendWebhook(":grey_question: Fishing failsafe was triggered.", "13424349")
        }
        }
        ; Pathing Failsafe
        if (A_TickCount - startWhitePixelSearch > (pathingFailsafeTime * 1000)) {
        restartPathing := true
        if (failsafeWebhook) {
            try SendWebhook(":feet: Pathing failsafe was triggered.", "6693139")
        }
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

        ; Advanced detection
        if (advancedFishingDetection) {
            ErrorLevel := 0
            PixelSearch, leftX, leftY, 513, 531, 856, 549, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
                rightX := leftX
                Loop {
                    testX := rightX + 1
                    if (testX > 856)
                        break
                    PixelGetColor, testColor, %testX%, 531, RGB
                    if (Abs((testColor & 0xFF) - (barColor & 0xFF)) <= 10 && Abs(((testColor >> 8) & 0xFF) - ((barColor >> 8) & 0xFF)) <= 10 && Abs(((testColor >> 16) & 0xFF) - ((barColor >> 16) & 0xFF)) <= 10) {
                        rightX := testX
                    } else {
                        break
                    }

                }
                barWidth := rightX - leftX
                if (barWidth < advancedFishingThreshold) {
                    MouseClick, left
                    sleep 25
                }
            } else {
                MouseClick, left
            }
            sleep 10
        } else {
            ; Normal detection
            ErrorLevel := 0
            PixelSearch, FoundX, FoundY, 513, 531, 856, 549, barColor, 5, Fast RGB
            if (ErrorLevel = 0) {
            } else {
                MouseClick, left
            }
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
    if (hasBiomesPlugin) {
        Run, "%A_ScriptDir%\plugins\biomes.ahk"
        biomeDetectionRunning := true
    }
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
    try SendWebhook(":green_circle: Macro Started!", "7909721")
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
        if (hasBiomesPlugin) {
            Run, "%A_ScriptDir%\plugins\biomes.ahk"
            biomeDetectionRunning := true
        }
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
        try SendWebhook(":green_circle: Macro Started!", "7909721")
    }
    return
}

PauseScript:
if (toggle) {
if (biomeDetectionRunning) {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2

    target := "biomes.ahk"
    WinGet, id, ID, %target% ahk_class AutoHotkey
    if (id) {
        WinClose, ahk_id %id%
    }
    biomeDetectionRunning := false
}
toggle := false
firstLoop := true
SetTimer, DoMouseMove, Off
SetTimer, DoMouseMove2, Off
SetTimer, DoMouseMove3, Off
SetTimer, UpdateGUI, Off
ManualGUIUpdate()
ToolTip
try SendWebhook(":yellow_circle: Macro Paused", "16632664")
}
return

CloseScript:
if (biomeDetectionRunning) {
    DetectHiddenWindows, On
    SetTitleMatchMode, 2

    target := "biomes.ahk"
    WinGet, id, ID, %target% ahk_class AutoHotkey
    if (id) {
        WinClose, ahk_id %id%
    }
    biomeDetectionRunning := false
}
try SendWebhook(":red_circle: Macro Stopped.", "14495300")
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
Run, https://www.roblox.com/games/106268429577845/fishSol-Donations#!/store
return

NeedHelpClick:
Run, https://discord.gg/nPvA54ShTm
return

OpenPluginsFolder:
Run, %A_ScriptDir%\plugins
return

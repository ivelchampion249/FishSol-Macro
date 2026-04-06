;#Requires AutoHotkey v1.1
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
snowmanPathing := false
snowmanPathingWebhook := false
easterPathing := false
easterPathingWebhook := false
easterInterval := 30
easterPathingPending := false
easterPathingSkipFishing := false
pauseAutoRoll := false
limitedPathing := false
autoCrafter := false
autoCrafterWebhook := false
FixedMaxFish := 56 ; Update with max fish types from collection sols each update

if (FileExist(iniFilePath)) {
    IniRead, tempSnowmanPathing, %iniFilePath%, "Macro", "snowmanPathing", 0
    snowmanPathing := (tempSnowmanPathing = "1" || tempSnowmanPathing = "true")
    IniRead, tempSnowmanPathingWebhook, %iniFilePath%, "Macro", "snowmanPathingWebhook", 0
    snowmanPathingWebhook := (tempSnowmanPathingWebhook = "1" || tempSnowmanPathingWebhook = "true")
    IniRead, tempEasterPathing, %iniFilePath%, "Macro", "easterPathing", 0
    easterPathing := (tempEasterPathing = "1" || tempEasterPathing = "true")
    IniRead, tempEasterPathingWebhook, %iniFilePath%, "Macro", "easterPathingWebhook", 0
    easterPathingWebhook := (tempEasterPathingWebhook = "1" || tempEasterPathingWebhook = "true")
    IniRead, tempEasterInterval, %iniFilePath%, "Macro", "easterInterval", 30
    if (tempEasterInterval != "ERROR")
    {
        easterInterval := tempEasterInterval
    }
    IniRead, tempAutoCrafter, %iniFilePath%, "Macro", "autoCrafter", 0
    autoCrafter := (tempAutoCrafter = "1" || tempAutoCrafter = "true")
    IniRead, tempAutoCrafterWebhook, %iniFilePath%, "Macro", "autoCrafterWebhook", 0
    autoCrafterWebhook := (tempAutoCrafterWebhook = "1" || tempAutoCrafterWebhook = "true")
    IniRead, tempPauseAutoRoll, %iniFilePath%, "Macro", "pauseAutoRoll", 0
    pauseAutoRoll := (tempPauseAutoRoll = "1" || tempPauseAutoRoll = "true")
    IniRead, tempLimitedPathing, %iniFilePath%, "Macro", "limitedPathing", 0
    limitedPathing := (tempLimitedPathing = "1" || tempLimitedPathing = "true")
}
strangeControllerTime := 0
biomeRandomizerTime := 360000
snowmanPathingTime := 7500000
easterPathingTime := 1800000
autoCrafterTime := 300000
strangeControllerInterval := 1260000
biomeRandomizerInterval := 1260000
snowmanPathingInterval := 7500000
autoCrafterInterval := 300000
elapsed := 0
strangeControllerLastRun := 0
biomeRandomizerLastRun := 0
snowmanPathingLastRun := 0
easterPathingLastRun := 0
autoCrafterLastRun := 0
privateServerLink := ""
globalFailsafeTimer := 0
fishingFailsafeTime := 31
pathingFailsafeTime := 61
autoRejoinFailsafeTime := 320
advancedFishingThreshold := 25
webhookURL := ""
biomesPrivateServerLink := ""
biomeDetectionRunning := false
auroraDetection := false
hasCrafterPlugin := FileExist(A_ScriptDir "\plugins\auto crafter.ahk")

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
hasCrafterPlugin := FileExist(A_ScriptDir "\plugins\auto crafter.ahk")
hasSnowmanPlugin := FileExist(A_ScriptDir "\plugins\snowman.pathing.ahk")
hasEasterPlugin := FileExist(A_ScriptDir "\plugins\easter.egg.pathing.ahk")

if (FileExist(iniFilePath)) {
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
Gui, Add, Text, x0 y10 w600 h45 Center BackgroundTrans c0x00D4FF, EggSol v1.9.6-2

Gui, Font, s9 cWhite Normal, Segoe UI

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x440 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x533 y601 w18 h19, %A_ScriptDir%\img\Robux.png


Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x425 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x325 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

Gui, Font, s10 cWhite Normal Bold

; adds plugin to tab list
tabList := "Main|Misc|Failsafes|Webhook"
if (hasBiomesPlugin)
    tabList .= "|Biomes"
if (hasCrafterPlugin)
    tabList .= "|Crafter"
if (hasSnowmanPlugin)
    tabList .= "|Snowman"
if (hasEasterPlugin)
    tabList .= "|Easter"
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

Gui, Font, s9 cWhite Bold, Segoe UI
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
Gui, Add, Text, x285 y272 w270 h15 BackgroundTrans, (Sell Cycles  -  If Sell All: 56)
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
    Gui, Add, CheckBox, x50 y410 w140 h25 vBiomeHeaven gSaveBiomeToggles Checked1 cWhite, Heaven

    Gui, Add, CheckBox, x250 y320 w140 h25 vBiomeHell gSaveBiomeToggles Checked1 cWhite, Hell
    Gui, Add, CheckBox, x250 y350 w140 h25 vBiomeStarfall gSaveBiomeToggles Checked1 cWhite, Starfall
    Gui, Add, CheckBox, x250 y380 w140 h25 vBiomeCorruption gSaveBiomeToggles Checked1 cWhite, Corruption
    Gui, Add, CheckBox, x250 y410 w140 h25 vBiomeEgglan gSaveBiomeToggles Checked1 cWhite, Eggland

    Gui, Add, CheckBox, x420 y380 w140 h25 vBiomeNormal gSaveBiomeToggles Checked1 cWhite, Normal
    Gui, Add, CheckBox, x420 y320 w140 h25 vBiomeSandStorm gSaveBiomeToggles Checked1 cWhite, Sand Storm
    Gui, Add, CheckBox, x420 y350 w140 h25 vBiomeNull gSaveBiomeToggles Checked1 cWhite, Null

    Gui, Font, s14 cWhite Bold
    Gui, Add, Text, x45 y445 c0x65FF65, Glitched
    Gui, Add, Text, x+2 y445, ,
    Gui, Add, Text, x+8 y445 c0xFF7DFF, Dreamspace
    Gui, Add, Text, x+8 y445, and
    Gui, Add, Text, x+8 y445 c0x00ddff, Cyberspace
    Gui, Add, Text, x+8 y445, are always on.

    Gui, Font, s10 cWhite Bold
    Gui, Add, Text, x50 y155 w200 h25 BackgroundTrans, Private Server Link:
    Gui, Add, Edit, x50 y185 w500 h25 vBiomesPrivateServerInput gUpdateBiomesPrivateServer Background0xD3D3D3 cBlack, %biomesPrivateServerLink%
    Gui, Font, s8 c0xCCCCCC Normal
    Gui, Add, Text, x50 y215 w500 h15 BackgroundTrans, Paste your Roblox private server link here for biome notifications.

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x425 y490 w115 h40 gOpenPluginsFolder, Open Plugins Folder

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

Gui, Color, 0x1E1E1E
Gui, Add, Picture, x445 y600 w27 h19, %A_ScriptDir%\img\Discord.png
Gui, Add, Picture, x538 y601 w18 h19, %A_ScriptDir%\img\Robux.png

Gui, Font, s11 cWhite Bold Underline, Segoe UI
Gui, Add, Text, x430 y600 w150 h38 Center BackgroundTrans c0x00FF00 gDonateClick, Donate!
Gui, Add, Text, x330 y600 w138 h38 Center BackgroundTrans c0x00D4FF gNeedHelpClick, Need Help?

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

if (hasEasterPlugin) {
    Gui, Tab, Easter
    Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Easter.png

    Gui, Font, s10 c0xCCCCCC Normal
    Gui, Add, Text, x60 y185 w400 h50 BackgroundTrans, When toggled, The macro will automatically collect Easter eggs around the map every
    Gui, Add, Text, x190 y201 w80 h50 vEasterIntervalText BackgroundTrans c0x00D4FF, %easterInterval% minutes
    Gui, Add, Text, x60 y500 w520 h50 BackgroundTrans, When toggled, you will recieve a webhook message every Easter egg pathing loop.
    Gui, Add, Text, x60 y380 w500 h50 BackgroundTrans, When toggled, This will limit the pathing to a shorter route. Only useful if you have a low end device.
    Gui, Add, Text, x60 y310 w500 h50 BackgroundTrans, When toggled, This will automatically disable Auto Rolling when the macro begins pathing. This ONLY works for Abyssal Pathing

    Gui, Font, s10 cWhite Bold
    Gui, Add, Button, x60 y150 w80 h25 gToggleEasterPathing vEasterPathingBtn, Toggle
    Gui, Add, Button, x60 y280 w80 h25 gTogglePauseAutoRoll vPauseAutoRollBtn, Toggle
    Gui, Add, Button, x60 y350 w80 h25 gToggleLimitedPathing vLimitedPathingBtn, Toggle

    Gui, Add, Button, x60 y470 w80 h25 gToggleEasterPathingWebhook vEasterPathingWebhookBtn, Toggle

    Gui, Font, s10 c0xCCCCCC Normal
    Gui, Add, Text, x60 y570, For max Egg Point / Fish Point gain, set the Easter egg pathing to - 25 MINUTES -
    Gui, Add, Text, x105 y595, For max efficiency, change the Easter egg pathing to - 0 MINUTES -
    Gui, Add, Text, x135 y615, This will completely stop all fishing, and only collect eggs.

    Gui, Font, s10 cWhite Normal Bold
    if (easterPathing) {
        Gui, Add, Text, x150 y155 w40 h25 vEasterPathingStatus BackgroundTrans c0x00DD00, ON
    } else {
        Gui, Add, Text, x150 y155 w40 h25 vEasterPathingStatus BackgroundTrans c0xFF4444, OFF
    }

    if (pauseAutoRoll) {
        Gui, Add, Text, x150 y285 w40 h25 vPauseAutoRollStatus BackgroundTrans c0x00DD00, ON
    } else {
        Gui, Add, Text, x150 y285 w40 h25 vPauseAutoRollStatus BackgroundTrans c0xFF4444, OFF
    }

    if (limitedPathing) {
        Gui, Add, Text, x150 y355 w40 h25 vLimitedPathingStatus BackgroundTrans c0x00DD00, ON
    } else {
        Gui, Add, Text, x150 y355 w40 h25 vLimitedPathingStatus BackgroundTrans c0xFF4444, OFF
    }

    if (easterPathingWebhook) {
        Gui, Add, Text, x150 y475 w40 h25 vEasterPathingWebhookStatus BackgroundTrans c0x00DD00, ON
    } else {
        Gui, Add, Text, x150 y475 w40 h25 vEasterPathingWebhookStatus BackgroundTrans c0xFF4444, OFF
    }

    Gui, Font, s10 cWhite Bold
    Gui, Add, Text, x130 y230 w400 h25 BackgroundTrans, ( Recommended - 25 Minutes )
    Gui, Add, Edit, x60 y225 w60 h25 vEasterIntervalInput gUpdateEasterInterval Number Background0xD3D3D3 cBlack, %easterInterval%
    Gui, Font, s10 c0xCCCCCC Normal
    Gui, Add, Text, x60 y255 w400 h25 BackgroundTrans, Customise how frequently the Easter egg pathing runs.
}

Gui, Tab, Credits
Gui, Add, Picture, x14 y80 w574 h590, %A_ScriptDir%\gui\Credits.png
Gui, Font, s10 cWhite Normal
Gui, Add, Picture, x50 y130 w50 h50, %dev1_img%
Gui, Font, s11 cWhite Normal Bold
if (dev1_name = "cresqnt") {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x0088FF gDev1NameClick, %dev1_name%
} else {
    Gui, Add, Text, x110 y135 w200 h20 BackgroundTrans c0x00DD00, %dev1_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y155 w200 h15 BackgroundTrans, %dev1_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y170 w200 h15 BackgroundTrans c0x0088FF gDev1LinkClick, %dev1_discord%

Gui, Font, s11 cWhite Normal Bold
Gui, Add, Picture, x50 y195 w50 h50, %dev2_img%
if (dev2_name = "cresqnt") {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x0088FF gDev2NameClick, %dev2_name%
} else {
    Gui, Add, Text, x110 y200 w200 h20 BackgroundTrans c0x00DD00, %dev2_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y220 w200 h15 BackgroundTrans, %dev2_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y235 w200 h15 BackgroundTrans c0x0088FF gDev2LinkClick, %dev2_discord%

Gui, Add, Picture, x50 y260 w50 h50, %dev3_img%
Gui, Font, s11 cWhite Normal Bold
if (dev3_name = "cresqnt") {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x0088FF gDev3NameClick, %dev3_name%
} else {
    Gui, Add, Text, x110 y265 w200 h20 BackgroundTrans c0x00DD00, %dev3_name%
}
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x110 y285 w200 h15 BackgroundTrans, %dev3_role%
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x110 y300 w200 h15 BackgroundTrans c0x0088FF gDev3LinkClick, %dev3_discord%

; forcing myself into the list because 1.10 does this properly and im not implementing that here just yet lol
; disabled as assets should now be included in zip
; IfNotExist, ./img/nadir.png
;     UrlDownloadToFile, https://github.com/FishSol-Development/FishSol-Legacy/blob/main/assets/img/nadir.png?raw=true, ./img/nadir.png
goto jump
Dev4NameClick:
    Run, https://www.twitch.tv/nadirrift
Return
jump:
Gui, Add, Picture, x490 y260 w50 h50, ./img/nadir.png
Gui, Font, s11 cWhite Normal Bold
Gui, Add, Text, x280 y265 w200 h20 BackgroundTrans c0x00DD00 0x202, NadirRift
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Text, x280 y285 w200 h15 BackgroundTrans 0x202, General Programmer
Gui, Font, s9 c0xCCCCCC Normal Underline
Gui, Add, Text, x280 y300 w200 h15 BackgroundTrans c0x0088FF gDev4NameClick 0x202, Twitch

url := "https://raw.githubusercontent.com/ivelchampion249/FishSol-Macro/refs/heads/main/DONATORS.txt"

Http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
Http.Open("GET", url, false)
Http.Send()

content := RTrim(Http.ResponseText, " `t`n`r")

Gui, Font, s10 cWhite Normal Bold
Gui, Add, Text, x50 y345 w200 h20 BackgroundTrans, Thank you to our donators!
Gui, Font, s9 c0xCCCCCC Normal
Gui, Add, Edit, x50 y370 w480 h125 vDonatorsList -Wrap +ReadOnly +VScroll -WantReturn -E0x200 Background0x2D2D2D c0xCCCCCC, %content%

Gui, Font, s8 c0xCCCCCC Normal
Gui, Add, Text, x50 y518 w500 h15 BackgroundTrans, EggSol v1.9.6-2 - %randomMessage%

Gui, Show, w600 h670, EggSol v1.9.6-2

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

if (hasEasterPlugin) {
    if (easterPathing) {
        GuiControl,, EasterPathingStatus, ON
        GuiControl, +c0x00DD00, EasterPathingStatus
    } else {
        GuiControl,, EasterPathingStatus, OFF
        GuiControl, +c0xFF4444, EasterPathingStatus
    }
    if (pauseAutoRoll) {
        GuiControl,, PauseAutoRollStatus, ON
        GuiControl, +c0x00DD00, PauseAutoRollStatus
    } else {
        GuiControl,, PauseAutoRollStatus, OFF
        GuiControl, +c0xFF4444, PauseAutoRollStatus
    }
    if (limitedPathing) {
        GuiControl,, LimitedPathingStatus, ON
        GuiControl, +c0x00DD00, LimitedPathingStatus
    } else {
        GuiControl,, LimitedPathingStatus, OFF
        GuiControl, +c0xFF4444, LimitedPathingStatus
    }
    GuiControl,, EasterIntervalInput, %easterInterval%
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
    Gui, Submit, nohide
    if MainTabs ~= "Easter" and not EasterPopupMessageShown
    {
        global EasterPopupMessageShown := true
        Msgbox,,About Recent Pickup Issue, % "Due to SolsRNG's recent patches [v4.762+]`ncollection range has been decreased (was 9 studs, now 3) while still showing the button at the old distance.`nSo it will fail to pick it up unless the player is closer to the egg`nA Fix is in progress, we are sorry!"
    }
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
    IniWrite, false, %iniFilePath%, "Macro", "autoCrafterDetection"
}
return

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

ToggleEasterPathing:
easterPathing := !easterPathing
if (easterPathing) {
    GuiControl,, EasterPathingStatus, ON
    GuiControl, +c0x00DD00, EasterPathingStatus
    IniWrite, true, %iniFilePath%, "Macro", "easterPathing"
} else {
    GuiControl,, EasterPathingStatus, OFF
    GuiControl, +c0xFF4444, EasterPathingStatus
    IniWrite, false, %iniFilePath%, "Macro", "easterPathing"
}
return

ToggleEasterPathingWebhook:
easterPathingWebhook := !easterPathingWebhook
if (easterPathingWebhook) {
    GuiControl,, EasterPathingWebhookStatus, ON
    GuiControl, +c0x00DD00, EasterPathingWebhookStatus
    IniWrite, true, %iniFilePath%, "Macro", "easterPathingWebhook"
} else {
    GuiControl,, EasterPathingWebhookStatus, OFF
    GuiControl, +c0xFF4444, EasterPathingWebhookStatus
    IniWrite, false, %iniFilePath%, "Macro", "easterPathingWebhook"
}
return

TogglePauseAutoRoll:
pauseAutoRoll := !pauseAutoRoll
if (pauseAutoRoll) {
    GuiControl,, PauseAutoRollStatus, ON
    GuiControl, +c0x00DD00, PauseAutoRollStatus
    IniWrite, true, %iniFilePath%, "Macro", "pauseAutoRoll"
} else {
    GuiControl,, PauseAutoRollStatus, OFF
    GuiControl, +c0xFF4444, PauseAutoRollStatus
    IniWrite, false, %iniFilePath%, "Macro", "pauseAutoRoll"
}
return

ToggleLimitedPathing:
limitedPathing := !limitedPathing
if (limitedPathing) {
    GuiControl,, LimitedPathingStatus, ON
    GuiControl, +c0x00DD00, LimitedPathingStatus
    IniWrite, true, %iniFilePath%, "Macro", "limitedPathing"
} else {
    GuiControl,, LimitedPathingStatus, OFF
    GuiControl, +c0xFF4444, LimitedPathingStatus
    IniWrite, false, %iniFilePath%, "Macro", "limitedPathing"
}
return

UpdateEasterInterval:
Gui, Submit, NoHide
easterInterval := EasterIntervalInput
easterPathingInterval := easterInterval * 60000
easterPathingTime := easterInterval * 60000
IniWrite, %easterInterval%, %iniFilePath%, "Macro", "easterInterval"
GuiControl,, EasterIntervalText, %easterInterval% minutes
return

ToggleAutoCrafter:
autoCrafter := !autoCrafter
if (autoCrafter) {
    GuiControl,, AutoCrafterStatus, ON
    GuiControl, +c0x00DD00, AutoCrafterStatus
    IniWrite, true, %iniFilePath%, "Macro", "autoCrafter"
} else {
    GuiControl,, AutoCrafterStatus, OFF
    GuiControl, +c0xFF4444, AutoCrafterStatus
    IniWrite, false, %iniFilePath%, "Macro", "autoCrafter"
}
return

UpdateAutoCrafterInterval:
Gui, Submit, NoHide
newInterval := AutoCrafterInterval * 60000
if (newInterval > 0) {
    autoCrafterInterval := newInterval
    IniWrite, %autoCrafterInterval%, %iniFilePath%, "Macro", "autoCrafterInterval"
}
return

ToggleAutoCrafterWebhook:
autoCrafterWebhook := !autoCrafterWebhook
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

RunAutoCrafter() {
    MouseGetPos, originalX, originalY
    global res

    if (res = "1080p") {
        RunAutoCrafter1080p()
    } else if (res = "1440p") {
        RunAutoCrafter1440p()
    } else if (res = "1366x768") {
        RunAutoCrafter768p()
    }

    MouseMove, %originalX%, %originalY%, 0
}

; 1080p Auto Crafter
RunAutoCrafter1080p() {
    Send, {Esc}
    Sleep, 300
    Send, R
    Sleep, 500
    Send, {Enter}
    Sleep, 2000

    MouseMove, 100, 400, 3
    Sleep, 200
    Click, Left
    Sleep, 200

    MouseMove, 500, 300, 3
    Sleep, 200
    Click, Left
    Sleep, 500
    Loop, 80
        {
        Click, WheelUp
        sleep 0
    }
    Sleep, 500
    Loop, 35
        {
		Click, WheelDown
        sleep 0
    }
    Sleep, 300

    Send, {s Down}
    Send, {%keyA% Down}
    Sleep, 2000
    Send, {%keyA% Up}
    Sleep, 1500
    Send, {d Down}
    Sleep, 1000
    Send, {d Up}
    Sleep, 500

    Send, {%keyA% Down}
    Send, {%keyW% Down}
    Sleep, 500
    Send, {%keyA% Up}
    Send, {%keyW% Up}
    Sleep, 100
    Send, {Space Down}
    Send, {s Down}
    Sleep, 100
    Send, {Space Up}
    Sleep, 500
    Send, {s Up}
    Sleep, 100
}

; 1440p Auto Crafter
RunAutoCrafter1440p() {
    Send, {%keyW% up}
    Send, {%keyA% up}
    Send, {s up}
    Send, {d up}
    Send, {space up}
    Send, {e up}
    reset := false
    Sleep 300

    Send, {Esc}
    Sleep, 650
    Send, R
    Sleep, 650
    Send, {Enter}
    sleep 2600
    MouseMove, 52, 621, 3
    sleep 300
    Click, Left
    sleep 300
    MouseMove, 525, 158, 3
    sleep 300
    Click, Left
    sleep 300
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

    ; start pathing to stella
    Send, {s down}
    Send, {%keyA% down}
    sleep 2660
    Send, {%keyA% up}
    Sleep, 2500
    Send, {d down}
    Sleep, 1100
    Send, {d up}
    Send, {s up}
    sleep 10
    Send, {%keyA% down}
    Send, {%keyW% down}
    Sleep, 300
    Send, {%keyA% up}
    Send, {%keyW% up}
    sleep 100
    Send, {Space down}
    Send, {s down}
    Sleep, 100
    Send, {Space up}
    Sleep, 500
    Send, {s up}
    sleep 10
    Send, {%keyA% down}
    Send, {s down}
    Sleep, 400
    Send, {%keyA% up}
    Sleep, 6000
    Send, {s up}
    Send, {%keyA% down}
    Sleep, 1500
    Send, {%keyA% up}
    Send, {s down}
    Sleep, 1250
    Send, {%keyA% down}
    Sleep, 200
    Send, {%keyA% up}
    Sleep, 1000
    Send, {%keyA% down}
    Send, {Space down}
    Sleep, 100
    Send, {Space up}
    Sleep, 750
    Send, {Space down}
    Sleep, 100
    Send, {Space up}
    Sleep, 700
    Send, {s up}
    Sleep, 2500
    Send, {%keyA% up}
    Send, {s down}
    Sleep, 1300
    Send, {s up}
    sleep 500

    ; portal detection
    screenColor := 0
    success := false
    loopCount := 0
    Loop {
    sleep 100
    if (loopCount > 40) {
    break
    }
    PixelGetColor, screenColor, 2509, 1389, RGB
    if (screenColor = 0x000000) {
    success := true
    }
    loopCount++
    }
    if (success) {
    sleep, 500
    } else {
    reset := true
    }

    ; potion crafting
    sleep 750
    Send, {%keyA% down}
    Sleep, 1000
    Send, {%keyA% up}
    Sleep, 300
    Send, {f down}
    Sleep, 300
    Send, {f up}
    Sleep, 125
    Clipboard := "Heavenly Potion"
    sleep 125
    MouseMove, 1271, 448, 3
    Sleep, 250
    MouseClick, Left
    Sleep, 250
    Send, ^v
    Sleep, 250
    MouseMove, 1530, 552, 3
    Sleep, 250
    Loop, 80
        {
        Click, WheelUp
        sleep 0
    }
    sleep 250
    MouseClick, Left
    Sleep, 250
    MouseMove, 769, 769, 3
    Sleep, 250
    MouseClick, Left
    Sleep, 300
    MouseMove, 954, 840, 3
    Sleep, 250
    MouseClick, Left
    Sleep, 200
    MouseClick, Left
    sleep 125
    Clipboard := "250"
    sleep 125
    Send, ^v
    Sleep, 250
    MouseMove, 1064, 839, 3
    Sleep, 250
    MouseClick, Left
    Sleep, 200
    MouseClick, Left
    Sleep, 250
    MouseMove, 1064, 910, 3
    sleep 250
    Mouseclick, Left
    sleep 250
    Mouseclick, Left
    sleep 250
    MouseMove, 1064, 984, 3
    sleep 250
    MouseClick, Left
    sleep 250
    MouseMove, 1885, 396, 3
    Sleep, 250
    MouseClick, Left
    Sleep, 300
}

; 768p Auto Crafter
RunAutoCrafter768p() {
    Send, {Esc}
    Sleep, 300
    Send, R
    Sleep, 500
    Send, {Enter}
    Sleep, 2000

    MouseMove, 80, 300, 3
    Sleep, 200
    Click, Left
    Sleep, 200

    MouseMove, 400, 250, 3
    Sleep, 200
    Click, Left
    Sleep, 500

    Loop, 80
        {
        Click, WheelUp
        sleep 0
    }
    Sleep, 500
    Loop, 20
        {
        Click, WheelDown
        sleep 0
    }
    Sleep, 300

    Send, {s Down}
    Send, {%keyA% Down}
    Sleep, 1800
    Send, {%keyA% Up}
    Sleep, 2000
    Send, {d Down}
    Sleep, 800
    Send, {d Up}
    Sleep, 400

    Send, {%keyA% Down}
    Send, {%keyW% Down}
    Sleep, 200
    Send, {%keyA% Up}
    Send, {%keyW% Up}
    Sleep, 100
    Send, {Space Down}
    Send, {s Down}
    Sleep, 100
    Send, {Space Up}
    Sleep, 400
    Send, {s Up}
    Sleep, 100
}

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

    Send, {%keyA% Down}
    sleep 1000
    Send, {s Down}
    sleep 2700
    Send, {%keyA% Up}
    sleep 2800
    Send, {s Up}
    sleep 300
    Send, {%keyA% Down}
    sleep 800
    Send, {%keyA% Up}
    sleep 300
    Send, {d Down}
    sleep 200
    Send, {d Up}
    sleep 200
    Send, {%keyW% Down}
    sleep 200
    Send, {%keyW% Up}
    sleep 300
    Send, {space Down}
    sleep 50
    Send, {%keyA% Down}
    sleep 50
    Send, {space Up}
    sleep 2200
    Send, {%keyA% Up}
    sleep 300
    Send, {e Down}
    sleep 50
    Send, {e Up}
    sleep 200
    Send, {e Down}
    sleep 50
    Send, {e Up}

    Send, {space Up}
    Send, {%keyW% Up}
    Send, {%keyA% Up}
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

    Send, {%keyA% Down}
    sleep 1500
    Send, {s Down}
    sleep 3400
    Send, {%keyA% Up}
    sleep 3400
    Send, {s Up}
    sleep 300
    Send, {%keyA% Down}
    sleep 800
    Send, {%keyA% Up}
    sleep 300
    Send, {d Down}
    sleep 300
    Send, {d Up}
    sleep 200
    Send, {%keyW% Down}
    sleep 200
    Send, {%keyW% Up}
    sleep 300
    Send, {%keyA% Down}
    sleep 50
    Send, {space Down}
    sleep 50
    Send, {space Up}
    sleep 2600
    Send, {%keyA% Up}
    sleep 300
    Send, {e Down}
    sleep 50
    Send, {e Up}
    sleep 200
    Send, {e Down}
    sleep 50
    Send, {e Up}

    Send, {space Up}
    Send, {%keyW% Up}
    Send, {%keyA% Up}
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

    Send, {%keyA% Down}
    sleep 1000
    Send, {s Down}
    sleep 1400
    Send, {%keyA% Up}
    sleep 2100
    Send, {s Up}
    sleep 300
    Send, {%keyA% Down}
    sleep 600
    Send, {%keyA% Up}
    sleep 300
    Send, {d Down}
    sleep 150
    Send, {d Up}
    sleep 200
    Send, {%keyW% Down}
    sleep 150
    Send, {%keyW% Up}
    sleep 300
    Send, {space Down}
    sleep 50
    Send, {%keyA% Down}
    sleep 50
    Send, {space Up}
    sleep 1500
    Send, {%keyA% Up}
    sleep 300
    Send, {e Down}
    sleep 50
    Send, {e Up}
    sleep 200
    Send, {e Down}
    sleep 50
    Send, {e Up}

    Send, {space Up}
    Send, {%keyW% Up}
    Send, {%keyA% Up}
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

    Send, {%keyW% up}
    Send, {%keyA% up}
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

RunEasterPathing() {
    if (pathingMode = "Non Vip Pathing") {
        RunEasterPathingNonVip()
    } else if (pathingMode = "Abyssal Pathing") {
        RunEasterPathingAbyssal()
    } else {
        RunEasterPathingVip()
    }
}

; VIP Easter Pathing
RunEasterPathingVip() {
    MouseGetPos, originalX, originalY
    global limitedPathing

    if (res = "1080p") {
        sleep 350
        MouseMove, 34, 463, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 388, 129, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}

    } else if (res = "1440p") {
        sleep 350
        MouseMove, 41, 615, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 516, 156, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}


    } else if (res = "1366x768") {
        sleep 350
        MouseMove, 28, 326, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 276, 108, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}
    }

        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 2000
        Send, {%keyA% Down}
        sleep 2000
        Send, {%keyW% Up}
        sleep 2000
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        sleep 175
        Send, {s Up}
        sleep 100

        gosub DisableTimers

        Send, {space Down}
        sleep 50
        Send, {%keyW% Down}
        sleep 50
        Send, {space Up}
        sleep 100
        Send, {space Down}
        sleep 700
        Send, {space Up}
        sleep 400
        Send, {%keyW% Up}
        sleep 300
        Send, {%keyA% Down}
        sleep 200

        gosub EnableTimers

        sleep 800
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1600
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2600
        Send, {s Down}
        sleep 750
        Send, {%keyA% Up}
        sleep 2600
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1500
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 200
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 5000
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 700
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2700
        Send, {d Down}
        sleep 800
        Send, {d Up}
        sleep 1000
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 400
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 1000
        Send, {d Down}
        sleep 900
        Send, {d Up}
        Send, {%keyA% Down}
        sleep 1400
        Send, {%keyA% Up}
        sleep 1500
        Send, {%keyA% Down}
        sleep 600
        Send, {%keyA% Up}
        sleep 3800
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 500
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1000
        Send, {%keyA% Down}
        sleep 400
        Send, {%keyA% Up}
        sleep 1700
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1200
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 3300
        Send, {s Up}

        gosub DisableTimers

        Send, {esc}
        sleep 650
        Send, {r}
        sleep 650
        Send, {enter}
        sleep 2600

        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 2000
        Send, {%keyA% Down}
        sleep 2000
        Send, {%keyW% Up}
        sleep 2000
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        Send, {d Down}
        sleep 300
        Send, {s Up}
        Send, {d Up}
        sleep 100
        Send, {d Down}
        sleep 800
        Send, {%keyW% Down}
        sleep 800
        Send, {%keyW% Up}
        sleep 1300

        gosub DisableTimers

        Send, {s Down}
        sleep 1200
        Send, {s Up}
        sleep 1000

        gosub EnableTimers

        sleep 2500
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 2000
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 2200
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 700
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 8000
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 500
        Send, {%keyW% Up}
        sleep 200

        gosub DisableTimers

        if (limitedPathing) {
            MouseMove, %originalX%, %originalY%, 0
            return
        }

        Send, {esc}
        sleep 650
        Send, {r}
        sleep 650
        Send, {enter}

        gosub EnableTimers

        sleep 2600
        Send, {%keyW% Down}
        sleep 650
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        sleep 650
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 650
        Send, {%keyA% Up}
        sleep 100
        Send, {d Down}
        sleep 650
        Send, {d Up}
        sleep 100
        Send, {d Down}
        sleep 650
        Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 650
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyA% Down}
        Send, {s Down}
        sleep 2700
        Send, {%keyA% Up}
        sleep 3000
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 1000
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 150
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {space Down}
        sleep 50
        Send, {d Down}
        sleep 50
        Send, {space Up}
        sleep 250
        Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 300
        Send, {%keyW% Down}
        sleep 1000
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1000
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1000
        Send, {%keyA% Down}
        sleep 1300
        Send, {%keyA% Up}
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 8500
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 800
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 7500
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 750
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 800
        Send, {s Down}
        sleep 1000
        Send, {s Up}
        sleep 100
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 100
        Send, {s Down}
        sleep 400
        Send, {s Up}
        sleep 3400
        Send, {s Down}
        sleep 1700
        Send, {s Up}
        Send, {d Up}
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 175
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {space Down}
        sleep 50
        Send, {d Down}
        sleep 50
        Send, {space Up}
        sleep 300
        Send, {d Up}
        sleep 100
        Send, {space Down}
        sleep 50
        Send, {s Down}
        sleep 50
        Send, {space Up}
        sleep 600
        Send, {%keyA% Down}
        sleep 1900
        Send, {%keyA% Up}
        sleep 1800
        Send, {d Down}
        sleep 1400
        Send, {d Up}
        sleep 1500
        Send, {s Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 100
        Send, {%keyW% Up}
        sleep 100
        Send, {space Down}
        sleep 100
        Send, {space Up}
        Send, {s Down}
        sleep 175
        Send, {s Up}
        sleep 100
        Send, {space Down}
        sleep 50
        Send, {s Down}
        sleep 50
        Send, {space Up}
        sleep 50
        Send, {%keyA% Down}
        sleep 500
        Send, {%keyA% Up}
        sleep 500
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 5500
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1000
        Send, {d Down}
        sleep 400
        Send, {d Up}
        sleep 2900
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 2800
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 800
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 800
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 4200
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 3200
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1800
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 2500
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2900
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2000
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 750
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2000
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 750
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 1300
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1400
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 4600
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 1400
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 750
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 175
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1000
        Send, {d Down}
        sleep 800
        Send, {d Up}
        sleep 2100
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1700
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 750
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2400
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 750
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2800
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2800
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 750
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2800
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 500
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2800
        Send, {d Up}

        gosub DisableTimers

        MouseMove, %originalX%, %originalY%, 0

    }


; Non-VIP Easter Pathing
RunEasterPathingNonVip() {
    MouseGetPos, originalX, originalY
    global res, limitedPathing

    if (res = "1080p") {
        sleep 350
        MouseMove, 34, 463, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 388, 129, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}

    } else if (res = "1440p") {
        sleep 350
        MouseMove, 41, 615, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 516, 156, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}


    } else if (res = "1366x768") {
        sleep 350
        MouseMove, 28, 326, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 276, 108, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}
    }

        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 2400
        Send, {%keyA% Down}
        sleep 2400
        Send, {%keyW% Up}
        sleep 2400
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1800
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        sleep 300
        Send, {s Up}
        sleep 300

        gosub DisableTimers

        Send {Space Down}
        sleep 25
        Send {w Down}
        sleep 800
        Send {Space Up}
        sleep 200
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 420
        Send {w Up}
        sleep 100
        Send, {%keyA% Down}

        gosub EnableTimers

        sleep 1400
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2000
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 3500
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 600
        Send, {%keyA% Down}
        sleep 1000
        Send, {%keyA% Up}
        sleep 2400
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1800
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 300
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 5300
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2000
        Send, {d Down}
        sleep 700
        Send, {d Up}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 1200
        Send, {d Down}
        sleep 1000
        Send, {d Up}
        Send, {%keyA% Down}
        sleep 2200
        Send, {%keyA% Up}
        sleep 7000
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 900
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 3400
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1700
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 4300
        Send, {s Up}

        gosub DisableTimers

        Send, {esc}
        sleep 780
        Send, {r}
        sleep 780
        Send, {enter}
        sleep 3120

        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 2400
        Send, {%keyA% Down}
        sleep 2400
        Send, {%keyW% Up}
        sleep 2400
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1800
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
		Send, {d Down}
        sleep 300
        Send, {s Up}
		Send, {d Up}
        sleep 100
        Send, {d Down}
        sleep 960
        Send, {%keyW% Down}
        sleep 800
        Send, {%keyW% Up}
        sleep 1560

        gosub DisableTimers

        Send, {s Down}
        sleep 1440
        Send, {s Up}
        sleep 1200

        gosub EnableTimers

		sleep 3500
		Send, {d Up}
		sleep 100
		Send, {s Down}
		sleep 2500
		Send, {s Up}
		sleep 100
		Send, {d Down}
		sleep 3000
		Send, {d Up}
		sleep 100
		Send, {s Down}
		sleep 1500
		Send, {s Up}
		sleep 100
		Send, {%keyA% Down}
		sleep 10500
		Send, {%keyA% Up}
		sleep 100
		Send, {%keyW% Down}
		sleep 1500
		Send, {%keyW% Up}

        gosub DisableTimers

        if (limitedPathing) {
            MouseMove, %originalX%, %originalY%, 0
            return
        }

        Send, {esc}
        sleep 650
        Send, {r}
        sleep 650
        Send, {enter}
        sleep 2600

        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 780
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        sleep 780
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 780
        Send, {%keyA% Up}
        sleep 100
        Send, {d Down}
        sleep 780
        Send, {d Up}
        sleep 100
        Send, {d Down}
        sleep 780
        Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 780
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyA% Down}
        Send, {s Down}
        sleep 3240

        Send, {%keyA% Up}
        sleep 3900
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 1200
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 100
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {space Down}
        sleep 60
        Send, {d Down}
        sleep 60
        Send, {space Up}
        sleep 700
        Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 760
        Send, {%keyW% Down}
        sleep 1200
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1200
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1200
        Send, {%keyA% Down}
        sleep 1560
        Send, {%keyA% Up}
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 10200
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 960
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 9000
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 900
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 960
        Send, {s Down}
        sleep 1200
        Send, {s Up}
        sleep 100
        Send, {space Down}
        sleep 120
        Send, {space Up}
        sleep 100
        Send, {s Down}
        sleep 480
        Send, {s Up}
        sleep 4250
        Send, {s Down}
        sleep 3000
        Send, {s Up}
        Send, {d Up}
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 150
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {space Down}
        sleep 60
        Send, {d Down}
        sleep 60
        Send, {space Up}
        sleep 360
        Send, {d Up}
        sleep 100
        Send, {space Down}
        sleep 60
        Send, {s Down}
        sleep 60
        Send, {space Up}
        sleep 1300
        Send, {%keyA% Down}
        sleep 2600
        Send, {%keyA% Up}
        sleep 2160
        Send, {d Down}
        sleep 1680
        Send, {d Up}
        sleep 1800
        Send, {s Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 120
        Send, {%keyW% Up}
        sleep 100
        Send, {space Down}
        sleep 120
        Send, {space Up}
        Send, {s Down}
        sleep 250
        Send, {s Up}
        sleep 100
        Send, {space Down}
        sleep 60
        Send, {s Down}
        sleep 60
        Send, {space Up}
        sleep 60
        Send, {%keyA% Down}
        sleep 350
        Send, {%keyA% Up}
        sleep 500
        Send, {space Down}
        sleep 120
        Send, {space Up}
        sleep 6600
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 1080
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1200
        Send, {d Down}
        sleep 480
        Send, {d Up}
        sleep 3480
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 3360
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 1100
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1800
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 1150
        Send, {space Down}
        sleep 120
        Send, {space Up}
        sleep 960
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 5040
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 3840
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2160
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 3000
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 3480
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2400
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 900
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2400
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 900
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2000
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2600
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 5650
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 1680
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 900
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 210
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1200
        Send, {d Down}
        sleep 960
        Send, {d Up}
        sleep 2520
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2040
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 900
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 2880
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 900
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 3360
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2700
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 3360
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 900
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 3360
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 600
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 3360
        Send, {d Up}

        gosub DisableTimers

    MouseMove, %originalX%, %originalY%, 0
}

; Abyssal Easter Pathing
RunEasterPathingAbyssal() {
    MouseGetPos, originalX, originalY
    global res, pauseAutoRoll, limitedPathing

    if (pauseAutoRoll) {
        if (res = "1080p") {
            MouseMove, 756, 1017, 3
            sleep 200
            MouseClick, Left
        } else if (res = "1440p") {
            MouseMove, 1043, 1362, 3
            sleep 200
            MouseClick, Left
        } else if (res = "1366x768") {
            MouseMove, 511, 717, 3
            sleep 200
            MouseClick, Left
        }
    }

    if (res = "1080p") {
        sleep 350
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
        ClipBoard := "Abyssal Hunter"
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
        MouseMove, 34, 463, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 388, 129, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}

    } else if (res = "1440p") {
        sleep 350
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
        MouseMove, 41, 615, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 516, 156, 3
        sleep 200
        MouseClick, Left
        sleep 350
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}


    } else if (res = "1366x768") {
        sleep 350
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
        ClipBoard := "Abyssal Hunter"
        sleep 100
        Send, ^v
        sleep 200
        MouseMove, 584, 310, 3
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
        MouseMove, 28, 326, 3
        Sleep, 200
        MouseClick, Left
        Sleep, 200
        MouseMove, 276, 108, 3
        sleep 200
        MouseClick, Left
        sleep 350
        Send, {i down}
        sleep 4000
        Send, {i up}
        ;switch from mousewheel to keyboard
        Send, {i down}
        Sleep 4000
        Send, {i up}
		sleep 100
		;switch from mousewheel to keyboard
		Send, {o down}
		Sleep 4000
		Send, {o up}

    }
        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 1350
        Send, {%keyA% Down}
        sleep 1350
        Send, {%keyW% Up}
        sleep 1350
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
		Send, {d Down}
        sleep 100
        Send, {s Up}
        sleep 200
		Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 50

        Send, {space Down}
        sleep 600
        Send, {space Up}
        sleep 400
        Send, {%keyA% Up}

        Send, {%keyW% Down}
		sleep 1675
		Send, {%keyW% Up}
		sleep 100
		Send, {%keyA% Down}
		sleep 1800
		Send, {%keyA% Up}
		sleep 100
		Send, {s Down}
		sleep 500
		Send, {%keyA% Down}
		sleep 550
		Send, {%keyA% Up}
		sleep 600
		Send, {s Up}
		sleep 100
		Send, {%keyA% Down}
		sleep 800
		Send, {%keyA% Up}
		sleep 100
		Send, {s Down}
		sleep 400
		Send, {space Down}
		sleep 100
		Send, {space Up}

		sleep 3200
		Send, {s Up}
		sleep 100
		Send, {d Down}
		sleep 400
		Send, {d Up}
		sleep 100
		Send, {%keyW% Down}
		sleep 1600
		Send, {d Down}
		sleep 850
		Send, {d Up}
		sleep 300
		Send, {%keyW% Up}
		sleep 100
		Send, {d Down}
		sleep 300
		Send, {d Up}
		sleep 100
		Send, {s Down}
		sleep 750
		Send, {d Down}
		sleep 500
		Send, {d Up}
		Send, {%keyA% Down}
		sleep 1400
		Send, {%keyA% Up}
		sleep 3200
		Send, {s Up}
		sleep 100
		Send, {%keyA% Down}
		sleep 250
		Send, {%keyA% Up}
		sleep 100
		Send, {%keyW% Down}
		sleep 750
		Send, {%keyA% Down}
		sleep 300
		Send, {%keyA% Up}
		sleep 800
		Send, {%keyW% Up}
		sleep 100
		Send, {%keyA% Down}
		sleep 700
		Send, {%keyA% Up}
		sleep 100
		Send, {s Down}
		sleep 2200
        Send, {s Up}

        gosub DisableTimers

        Send, {esc}
        sleep 650
        Send, {r}
        sleep 650
        Send, {enter}
        sleep 2600

        gosub EnableTimers

        Send, {%keyW% Down}
        sleep 1250
        Send, {%keyA% Down}
        sleep 1250
        Send, {%keyW% Up}
        sleep 1250
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 940
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        Send, {d Down}
        sleep 190
        Send, {s Up}
        Send, {d Up}
        sleep 100
        Send, {d Down}
        sleep 400
        Send, {%keyW% Down}
        sleep 300
        Send, {%keyW% Up}
        sleep 800
        Send, {s Down}
        sleep 750
        Send, {s Up}
        sleep 2300
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 1100
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 1700
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 440
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 5200
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 400
        Send, {%keyW% Up}
        sleep 125

        gosub DisableTimers

        if (limitedPathing) {
            MouseMove, %originalX%, %originalY%, 0
            return
        }

        Send, {esc}
        sleep 650
        Send, {r}
        sleep 650
        Send, {enter}
        sleep 2600

        gosub EnableTimers

        sleep 1625
        Send, {%keyW% Down}
        sleep 410
        Send, {%keyW% Up}
        sleep 100
        Send, {s Down}
        sleep 410
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 410
        Send, {%keyA% Up}
        sleep 100
        Send, {d Down}
        sleep 410
        Send, {d Up}
        sleep 100
        Send, {d Down}
        sleep 410
        Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 410
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyA% Down}
        Send, {s Down}
        sleep 1900
        Send, {%keyA% Up}
        sleep 1875
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 625
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 100
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100
        Send, {space Down}
        sleep 50
        Send, {d Down}
        sleep 50
        Send, {space Up}
        sleep 160
        Send, {d Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 190
        Send, {%keyW% Down}
        sleep 625
        Send, {%keyW% Up}
        sleep 600
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 625
        Send, {%keyA% Down}
        sleep 810
        Send, {%keyA% Up}
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 5500
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 600
        Send, {s Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 4700
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 470
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 200
        Send, {s Down}
        sleep 625
        Send, {s Up}
        sleep 100
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 2300
        Send, {s Down}
        sleep 2875
        Send, {s Up}
        Send, {d Up}
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 180
        Send, {%keyW% Up}
        sleep 150
        Send, {%keyA% Up}
        sleep 100
        Send, {d Down}
        sleep 100
        Send, {space Down}
        sleep 50
        Send, {space Up}
        sleep 150
        Send, {d Up}
        sleep 100
        Send, {space Down}
        sleep 100
        Send, {s Down}
        sleep 50
        Send, {space Up}
        sleep 800
        Send, {%keyA% Down}
        sleep 1188
        Send, {%keyA% Up}
        sleep 1000
        Send, {d Down}
        sleep 800
        Send, {d Up}
        sleep 900
        Send, {s Up}
        sleep 100

		Send, {%keyW% Down}
        sleep 100
        Send, {%keyW% Up}
        sleep 100
        Send, {space Down}
		sleep 50
        Send, {s Down}
        sleep 50
        Send, {space Up}
        sleep 100
        Send, {s Up}
		sleep 100
		Send, {space Down}
        sleep 50
		Send, {s Down}
		sleep 50
        Send, {space Up}
        sleep 200
        Send, {%keyA% Down}
        sleep 310
        Send, {%keyA% Up}
        sleep 100
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 3700
        Send, {s Up}

        sleep 100
        Send, {d Down}
        sleep 700
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 625
        Send, {d Down}
        sleep 280
        Send, {d Up}
        sleep 1850
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 1850
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 940
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {space Down}
        sleep 100
        Send, {space Up}
        sleep 700

        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2625
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 1800
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1100
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 100
        Send, {s Down}
        sleep 1400
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 2000
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 1400
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 500
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1400
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 470
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 810
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 875
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 2875
        Send, {%keyA% Up}
        sleep 100
        Send, {s Down}
        sleep 1000
        Send, {s Up}
        sleep 100
        Send, {d Down}
        sleep 600
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        Send, {%keyA% Down}
        sleep 110
        Send, {%keyW% Up}
        Send, {%keyA% Up}
        sleep 100

        Send, {%keyW% Down}
        sleep 625
        Send, {d Down}
        sleep 500
        Send, {d Up}
        sleep 1500
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1062
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 500
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 1500
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 500
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1750
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 1350
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 1750
        Send, {d Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 500
        Send, {%keyW% Up}
        sleep 100
        Send, {%keyA% Down}
        sleep 1750
        Send, {%keyA% Up}
        sleep 100
        Send, {%keyW% Down}
        sleep 312
        Send, {%keyW% Up}
        sleep 100
        Send, {d Down}
        sleep 1750
        Send, {d Up}

        gosub DisableTimers

    } if (pauseAutoRoll) {
        if (res = "1080p") {
            MouseMove, 756, 1017, 3
            sleep 200
            MouseClick, Left
        } else if (res = "1440p") {
            MouseMove, 1043, 1362, 3
            sleep 200
            MouseClick, Left
        } else if (res = "1366x768") {
            MouseMove, 511, 717, 3
            sleep 200
            MouseClick, Left
        }
    }


RunEasterPathingNow:
    global toggle, restartPathing, firstLoop, easterPathingLastRun, easterPathingInterval, easterPathingWebhook, res, pathingMode

    Send, {Esc}
    sleep 500
    Send, r
    sleep 1000
    Send, {Enter}
    sleep 2000

    Send, {%keyW% up}
    Send, {%keyA% up}
    Send, {s up}
    Send, {d up}
    Send, {space up}
    Send, {e up}

    Suspend, Off

    if (easterPathingWebhook) {
        try SendWebhook(":egg: Starting Easter egg pathing (" . pathingMode . " at " . res . ")", "16636040")
    }

    RunEasterPathing()

    easterPathingLastRun := A_TickCount - easterPathingInterval + 60000

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
    IniRead, BiomeHeaven, %iniFilePath%, "Biomes", BiomeHeaven, 1
    IniRead, BiomeEgglan, %iniFilePath%, "Biomes", BiomeEgglan, 1
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
    GuiControl,, BiomeHeaven, %BiomeHeaven%
    GuiControl,, BiomeEgglan, %BiomeEgglan%
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
IniWrite, %BiomeHeaven%, %iniFilePath%, "Biomes", BiomeHeaven
IniWrite, %BiomeEgglan%, %iniFilePath%, "Biomes", BiomeEgglan
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
    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2) "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    json := "{"
    . """embeds"": ["
    . "{"
    . "    ""title"": """ title ""","
    . "    ""color"": " color ","
    . "    ""footer"": {""text"": ""EggSol v1.9.6-2"", ""icon_url"": ""https://maxstellar.github.io/fishSol%20icon.png""},"
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


; SC toggle
RunStrangeController() {
    global res
    global itemWebhook
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
            PixelSearch, Px, Py, 491, 711, 749, 723, 0x457dff, 3, Fast RGB
            if (!ErrorLevel) {
                break
            } else {
                MouseMove, 1279, 342, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 848, 479, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 682, 578, 3
        sleep 300
        MouseClick, Left
        sleep 300
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
            PixelSearch, Px, Py, 655, 916, 914, 929, 0x457dff, 3, Fast RGB
            if (!ErrorLevel) {
                break
            } else {
                MouseMove, 1704, 452, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1144, 643, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 920, 774, 3
        sleep 300
        MouseClick, Left
        sleep 300
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
            PixelSearch, Px, Py, 427, 518, 474, 530, 0x457dff, 3, Fast RGB
            if (!ErrorLevel) {
                break
            } else {
                MouseMove, 911, 242, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 616, 347, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 486, 413, 3
        sleep 300
        MouseClick, Left
        sleep 300
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
            PixelSearch, Px, Py, 491, 727, 748, 739, 0x457dff, 3, Fast RGB
            if (!ErrorLevel) {
                break
            } else {
                MouseMove, 1279, 342, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 848, 479, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 682, 578, 3
        sleep 300
        MouseClick, Left
        sleep 300
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
            PixelSearch, Px, Py, 755, 916, 913, 928, 0x457dff, 3, Fast RGB
            if (!ErrorLevel) {
                break
            } else {
                MouseMove, 1704, 452, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 1144, 643, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 920, 774, 3
        sleep 300
        MouseClick, Left
        sleep 300
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
            PixelSearch, Px, Py, 433, 518, 480, 530, 0x8b8b8b, 3, Fast RGB
            if (!ErrorLevel) {
                break
            } else {
                MouseMove, 911, 242, 3
                sleep 300
                MouseClick, Left
                sleep 300
                MouseMove, 616, 347, 3
                sleep 300
                MouseClick, Left
                sleep 300
            }
        }
        MouseMove, 486, 413, 3
        sleep 300
        MouseClick, Left
        sleep 300
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
    strangeControllerLastRun := 0
    biomeRandomizerLastRun := 0
    snowmanPathingLastRun := 0
    if (startTick = "") {
        startTick := A_TickCount
    }
    if (cycleCount = "") {
        cycleCount := 0
    }
    strangeControllerLastRun := 0
    biomeRandomizerLastRun := 0
    snowmanPathingLastRun := 0
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

if azertyPathing{
    Send, {q up}
    Send, {z up}
}
Else
{
    Send, {w up}
    Send, {a up}
}
Send, {s up}
Send, {d up}
Send, {space up}
Send, {e up}
Send, {esc up}
Send, {r up}

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
    global snowmanPathingLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    global hasCrafterPlugin
    global crafterToggle
    global autoCrafterDetection
    global autoCrafterLastCheck
    global autoCrafterCheckInterval
    global FixedMaxFish
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }
        if (easterInterval = 0 and easterPathing) {
            elapsed := A_TickCount - startTick
            if ((easterPathingLastRun = 0 && elapsed >= easterPathingTime) || (easterPathingLastRun > 0 && (elapsed - easterPathingLastRun) >= easterPathingInterval)) {
                PixelGetColor, fishingColor, 201, 924, RGB
                if (fishingColor = 0xFFFFFF) {
                    easterPathingPending := true
                } else {
                    Send, {Esc}
                    Sleep, 650
                    Send, R
                    Sleep, 650
                    Send, {Enter}
                    sleep 2600

                    RunEasterPathing()
                    easterPathingLastRun := elapsed
                    continue
                }
            }
        }
        Else
        {

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

        ; Snowman Pathing Toggle
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

        if (easterPathing) {
            elapsed := A_TickCount - startTick
            if ((easterPathingLastRun = 0 && elapsed >= easterPathingTime) || (easterPathingLastRun > 0 && (elapsed - easterPathingLastRun) >= easterPathingInterval)) {
                if (loopCount > maxLoopCount || restartPathing) {
                    easterPathingSkipFishing := true
                } else {
                    PixelGetColor, fishingColor, 201, 924, RGB
                    if (fishingColor = 0xFFFFFF) {
                        easterPathingPending := true
                    } else {
                        Send, {Esc}
                        Sleep, 650
                        Send, R
                        Sleep, 650
                        Send, {Enter}
                        sleep 2600

                        RunEasterPathing()
                        easterPathingLastRun := elapsed

                        restartPathing := true
                        continue
                    }
                }
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

        ; More snowman pathing
        loopCount++
        if (loopCount > maxLoopCount || restartPathing) {
            restartPathing := false

            if (snowmanPathing) {
            Sleep, 2000

        }

            if (pathingWebhook) {
                try SendWebhook(":moneybag: Starting Auto-Sell Pathing...", "16636040")
            }

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

        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 2600
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
            sleep 25
        }
        sleep 500
        Loop, 45
            {
            Click, WheelDown
            sleep 25
        }
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 828, 404, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 560, 640, 680, 645, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 828, 404, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 560, 640, 680, 645, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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
            ClipBoard := "Abyssal Hunter"
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 828, 404, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 560, 640, 680, 645, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            if (easterPathingSkipFishing) {
                Send, {Esc}
                Sleep, 650
                Send, R
                Sleep, 650
                Send, {Enter}
                sleep 2600
                RunEasterPathing()
                easterPathingLastRun := A_TickCount - startTick
                easterPathingSkipFishing := false
                restartPathing := true
                continue
            }
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
        try SendWebhook(":repeat: Auto Rejoin failsafe was triggered.", "3426654")
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

        if (easterPathingPending) {
            Send, {Esc}
            Sleep, 650
            Send, R
            Sleep, 650
            Send, {Enter}
            sleep 2600
            RunEasterPathing()
            easterPathingLastRun := A_TickCount - startTick
            easterPathingPending := false
            restartPathing := true
            continue
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
    global snowmanPathingLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    global hasCrafterPlugin
    global crafterToggle
    global autoCrafterDetection
    global autoCrafterLastCheck
    global autoCrafterCheckInterval
    global FixedMaxFish
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }

        if (easterInterval = 0 and easterPathing) {
            elapsed := A_TickCount - startTick
            if ((easterPathingLastRun = 0 && elapsed >= easterPathingTime) || (easterPathingLastRun > 0 && (elapsed - easterPathingLastRun) >= easterPathingInterval)) {
                    PixelGetColor, fishingColor, 265, 1236, RGB
                    if (fishingColor = 0xFFFFFF) {
                        easterPathingPending := true
                    } else {
                        Send, {Esc}
                        Sleep, 650
                        Send, R
                        Sleep, 650
                        Send, {Enter}
                        sleep 2600

                        RunEasterPathing()
                        easterPathingLastRun := elapsed

                        continue
                    }
            }
        }
        Else
        {
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

        ; Snowman Pathing Toggle
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

        if (easterPathing) {
            elapsed := A_TickCount - startTick
            if ((easterPathingLastRun = 0 && elapsed >= easterPathingTime) || (easterPathingLastRun > 0 && (elapsed - easterPathingLastRun) >= easterPathingInterval)) {
                if (loopCount > maxLoopCount || restartPathing) {
                    easterPathingSkipFishing := true
                } else {
                    PixelGetColor, fishingColor, 265, 1236, RGB
                    if (fishingColor = 0xFFFFFF) {
                        easterPathingPending := true
                    } else {
                        Send, {Esc}
                        Sleep, 650
                        Send, R
                        Sleep, 650
                        Send, {Enter}
                        sleep 2600

                        RunEasterPathing()
                        easterPathingLastRun := elapsed

                        restartPathing := true
                        continue
                    }
                }
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

        ; More snowman pathing
        loopCount++
        if (loopCount > maxLoopCount || restartPathing) {
            restartPathing := false

            if (snowmanPathing) {
            Sleep, 2000

        }

            if (pathingWebhook) {
                try SendWebhook(":moneybag: Starting Auto-Sell Pathing...", "16636040")
            }

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
        sleep 500
        Send, {Esc}
        sleep 650
        Send, {r}
        sleep 650
        Send, {Enter}
        sleep 2600
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
            sleep 25
        }
		sleep 500
		Loop, 35
            {
            Click, WheelDown
            sleep 25
        }
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 1117, 550, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 746, 853, 907, 860, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 1117, 550, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 746, 853, 907, 860, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 1117, 550, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 746, 853, 907, 860, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            if (easterPathingSkipFishing) {
                Send, {Esc}
                Sleep, 650
                Send, R
                Sleep, 650
                Send, {Enter}
                sleep 2600
                RunEasterPathing()
                easterPathingLastRun := A_TickCount - startTick
                easterPathingSkipFishing := false
                restartPathing := true
                continue
            }
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
        try SendWebhook(":repeat: Auto Rejoin failsafe was triggered.", "3426654")
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

        if (easterPathingPending) {
            Send, {Esc}
            Sleep, 650
            Send, R
            Sleep, 650
            Send, {Enter}
            sleep 2600
            RunEasterPathing()
            easterPathingLastRun := A_TickCount - startTick
            easterPathingPending := false
            restartPathing := true
            continue
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
    global snowmanPathingLastRun
    global startTick
    global failsafeWebhook
    global pathingWebhook
    global hasCrafterPlugin
    global crafterToggle
    global autoCrafterDetection
    global autoCrafterLastCheck
    global autoCrafterCheckInterval
    global FixedMaxFish
    loopCount := 0
    keyW := azertyPathing ? "z" : "w"
    keyA := azertyPathing ? "q" : "a"
    restartPathing := false
    Loop {
        if (!toggle) {
            break
        }


        if (easterInterval = 0 and easterPathing) {
            elapsed := A_TickCount - startTick
            if ((easterPathingLastRun = 0 && elapsed >= easterPathingTime) || (easterPathingLastRun > 0 && (elapsed - easterPathingLastRun) >= easterPathingInterval)) {
                PixelGetColor, fishingColor, 146, 654, RGB
                if (fishingColor = 0xFFFFFF) {
                    easterPathingPending := true
                } else {
                    Send, {Esc}
                    Sleep, 650
                    Send, R
                    Sleep, 650
                    Send, {Enter}
                    sleep 2600

                    RunEasterPathing()
                    easterPathingLastRun := elapsed

                    restartPathing := true
                    continue
                }
            }
        }
        Else
        {

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

        ; Snowman Pathing
        if (snowmanPathing) {
            elapsed := A_TickCount - startTick
            if ((snowmanPathingLastRun = 0 && elapsed >= snowmanPathingTime) || (snowmanPathingLastRun > 0 && (elapsed - snowmanPathingLastRun) >= snowmanPathingInterval)) {
                if (snowmanPathingWebhook) {
                    try SendWebhook(":moneybag: Resetting character after snowman pathing...", "16636040")
                }
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

        if (easterPathing) {
            elapsed := A_TickCount - startTick
            if ((easterPathingLastRun = 0 && elapsed >= easterPathingTime) || (easterPathingLastRun > 0 && (elapsed - easterPathingLastRun) >= easterPathingInterval)) {
                if (loopCount > maxLoopCount || restartPathing) {
                    easterPathingSkipFishing := true
                } else {
                    PixelGetColor, fishingColor, 146, 654, RGB
                    if (fishingColor = 0xFFFFFF) {
                        easterPathingPending := true
                    } else {
                        Send, {Esc}
                        Sleep, 650
                        Send, R
                        Sleep, 650
                        Send, {Enter}
                        sleep 2600

                        RunEasterPathing()
                        easterPathingLastRun := elapsed

                        restartPathing := true
                        continue
                    }
                }
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

        ; More snowman pathing
        loopCount++
        if (loopCount > maxLoopCount || restartPathing) {
            restartPathing := false

            if (snowmanPathing) {
            Sleep, 2000

        }

            if (pathingWebhook) {
                try SendWebhook(":moneybag: Starting Auto-Sell Pathing...", "16636040")
            }

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
        Send, {Esc}
        Sleep, 650
        Send, R
        Sleep, 650
        Send, {Enter}
        sleep 2600
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
            sleep 25
        }
		sleep 500
		Loop, 90
            {
            Click, WheelDown
            sleep 25
        }
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 586, 287, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 395, 455, 484, 459, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 586, 287, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 395, 455, 484, 459, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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
            ClipBoard := "Abyssal Hunter"
            sleep 100
            Send, ^v
            sleep 200
            MouseMove, 584, 310, 3
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

            while (loopCount < sellAllToggle ? min(fishingLoopCount, FixedMaxFish) : fishingLoopCount) {
                MouseMove, 586, 287, 3
                sleep 200
                MouseClick, Left
                sleep 400
                PixelSearch, , , 395, 455, 484, 459, 0xFFFFFF, 1, Fast RGB
                if ErrorLevel != 0
                    break
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

            if (easterPathingSkipFishing) {
                if (easterPathingWebhook) {
                    try SendWebhook(":egg: Starting Easter egg pathing (sell cycle finished)...", "16636040")
                }
                Send, {Esc}
                Sleep, 650
                Send, R
                Sleep, 650
                Send, {Enter}
                sleep 2600
                RunEasterPathing()
                easterPathingLastRun := A_TickCount - startTick
                easterPathingSkipFishing := false
                restartPathing := true
                continue
            }
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
        try SendWebhook(":repeat: Auto Rejoin failsafe was triggered.", "3426654")
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

        if (easterPathingPending) {
            if (easterPathingWebhook) {
                try SendWebhook(":egg: Starting Easter egg pathing (fishing minigame finished)...", "16636040")
            }
            Send, {Esc}
            Sleep, 650
            Send, R
            Sleep, 650
            Send, {Enter}
            sleep 2600
            RunEasterPathing()
            easterPathingLastRun := A_TickCount - startTick
            easterPathingPending := false
            restartPathing := true
            continue
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

PressE:
    Send, {e Down}
    ;removed sleep to avoid conflict in pathing
    SetTimer, UnPressE, -50
Return

UnPressE:
    Send, {e Up}
Return

ClearUI: ;click on aura to clear screen of most ui elements
    SetTimer, ClearUIClick, -250
ClearUIClick:
    if (res = "1080p") {
        Click, 30, 400, 1
    } else if (res = "1440p") {
        Click, 30, 540, 1
    } else if (res = "1366x768") {
        Click, 30, 285, 1
    }
return

MerchantClick1: ; 1440p
    Click, 1686, 1261, 1
Return

MerchantClick2: ; 1080p
    Click, 1265, 943, 1
Return

MerchantClick3: ; 768p
    Click, 910, 670, 1
Return

DisableTimers:
    SetTimer, PressE, Off
    SetTimer, UnPressE, Off ;secondary timer does not need to be renabled
    Send, {e up}
    SetTimer, ClearUI, Off
    SetTimer, ClearUIClick, Off ;secondary timer does not need to be renabled

    if (res = "1080p") {
        SetTimer, MerchantClick2, Off
    } else if (res = "1440p") {
        SetTimer, MerchantClick1, Off
    } else if (res = "1366x768") {
        SetTimer, MerchantClick3, Off
    }
Return

EnableTimers:
    SetTimer, PressE, 100
    SetTimer, ClearUI, 15000

    if (res = "1080p") {
        SetTimer, MerchantClick2, 5000
    } else if (res = "1440p") {
        SetTimer, MerchantClick1, 5000
    } else if (res = "1366x768") {
        SetTimer, MerchantClick3, 5000
    }
return
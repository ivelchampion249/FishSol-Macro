; nothing to see here :blush:
; #Requires AutoHotkey v1.1

/*
    for best results have gui transparency set at max so chat can't be seen through!
*/




#NoEnv
#SingleInstance, Force
#Persistent
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir % SubStr(A_ScriptDir, 1, StrLen(A_ScriptDir) - 8)
EnvGet, LocalAppData, LOCALAPPDATA
OnMessage(0x4a, "Receive_WM_COPYDATA")

global standalone := (A_ScriptDir ~= "\\plugins") != 0

global iniFilePath := A_WorkingDir "\settings.ini"
if (FileExist(iniFilePath)) {
    IniRead, res, %iniFilePath%, "Macro", "resolution"
    IniRead, tempWebhook, %iniFilePath%, "Macro", "webhookURL"
    IniRead, tempPSLink, %iniFilePath%, "Biomes", "privateServerLink" ;using biomes like temporarily
    if (tempWebhook != "ERROR" && tempPSLink != "ERROR")
    {
        webhookURL := tempWebhook
        privateServerLink := tempPSLink
        if (!InStr(webhookURL, "discord")) {
            ExitApp
        }
    } else {
        ExitApp
    }
}

global Tesseract := find_tesseract()
global TesseractDir := StrReplace(Tesseract, "\tesseract.exe", "")

; make window for communitcations
gui, new, -ToolWindow,easter.egg.pathing
gui, add, Text, ,TEST FILE STUFF
gui, show, w200 Hide
global LastLine := ""
global NewLine  := ""
try SendWebhook(":egg: EE.pathing started")
return

start:
Gosub, readlog
SetTimer, readlog, 15000
if res ~= "1440p"
{
    SetTimer, FS1440p, 100
    SetTimer, MerchantClick1, 5000
}
else if ~= "1080p"
{
    SetTimer, FS1080p, 100
    SetTimer, MerchantClick2, 5000
}
else
{
    SetTimer, FS768p, 100
    SetTimer, MerchantClick3, 5000
}
return

stop:
    if res ~= "1440p"
    {
        SetTimer, FS1440p, off
        SetTimer, MerchantClick1, off
    }
    else if ~= "1080p"
    {
        SetTimer, FS1080p, off
        SetTimer, MerchantClick2, off
    }
    else
    {
        SetTimer, FS768p, off
        SetTimer, MerchantClick3, off
    }
return

readlog:
    if roblox_check() {
        return
    }
    logDir := LocalAppData "\Roblox\logs"
    newestTime := 0
    newestFile := ""

    ; Find latest log file
    Loop, Files, %logDir%\*.log, F
    {
        if (A_LoopFileTimeModified > newestTime) {
            newestTime := A_LoopFileTimeModified
            newestFile := A_LoopFileFullPath
        }
    }

    if !newestFile
        return

    file := FileOpen(newestFile, "r")
    if !IsObject(file)
        return

    ; Read only the last ~10 KB (adjust if needed)
    size := file.Length
    chunkSize := 10240
    if (size > chunkSize)
        file.Seek(-chunkSize, 2) ; 2 = from end of file
    content := file.Read()
    file.Close()

    lines := StrSplit(content, "`n")
    
    Loop % lines.MaxIndex()
    {
        line := lines[lines.MaxIndex() - A_Index + 1]
        if InStr(line, "[FLog::Output]")
        {
            if RegExMatch(line, "([\d\w-\.:,]+)(?= \[FLog::Output\] egg spawned!)", m)
            {
                if (LastLine ~= m)
                    Break
                Else
                {
                    testLines := [ "Wait am [li\|] sti[li\|][li\|] Dreaming\?"
                                 , "Preparing Protoco[li\|]\..Do you want to be my friend\?."
                                 , "Scanning\. Egg cannon charging 2000\%\."
                                 , "Don.t forget to water the .sma[li\|I][li\|I] p[li\|I]ant\."
                                 , "Ho[li\|]y Eggeus"
                                 , "Am [li\|] in spaaaace right now\?[li\|\!]"
                                 , "A Specia[li\|] Egg has Spawned\."]
                    LastLine := m
                    chat_output := OCR("\ocr\screenshot.png")
                    ToolTip, %chat_output%, 0, 0
                    hasEgg := false
                    if chat_output ~= "\[Egg Spawned\]"
                        hasEgg := true
                    Loop % testLines.Length()
                    {
                        if (chat_output ~= testLines[A_Index]) or (chat_output ~= "[Egg Spawned] " . testLines[A_Index])
                        {
                            hasEgg := true
                            Break
                        }
                    }
                    if hasEgg
                        try SendWebhook(":egg: Rare Egg Spawn!")
                    Break
                }
            }
        }
    }
return


SendWebhook(title, color := "3468175") {
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
    . "    ""footer"": {""text"": ""EggSol v1.9.6-5-DEV"", ""icon_url"": ""https://maxstellar.github.io/fishSol%20icon.png""},"
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

; custom reciever
Receive_WM_COPYDATA(wParam, lParam)
{
    StringAddress := NumGet(lParam + 2*A_PtrSize)
    CopyOfData := StrGet(StringAddress)

    if CopyOfData ~= "stop"
    {
        Gosub, stop
        return true
    }

    if CopyOfData ~= "start"
    {
        Gosub, start
        return true
    }

    if CopyOfData ~= "kill"
    {
        SetTimer, killme, -1
        return true
    }

    return false
}

killme:
ExitApp
Return

; leave merchant click no auto detect version [update to smart version]
MerchantClick1: ; 1440p
    if roblox_check()
        Click, 1686, 1261, 3
Return

MerchantClick2: ; 1080p
    if roblox_check()
        Click, 1265, 943, 3
Return

MerchantClick3: ; 768p
    if roblox_check()
        Click, 910, 670, 3
Return


; questboard failsafe [done?]
FS1440p:
    if not roblox_check()
        return
    ; check for left and right arrows
    pixelgetcolor, c2, 1819, 720, RGB
    pixelgetcolor, c3, 740,  720, RGB
    if (c2 = 0xFFFFFF) and (c3 = 0xFFFFFF)
    {
        click, 1277, 1257
        click, 30,  610
        click, 516, 160
    }
Return

FS1080p:
    if not roblox_check()
        return
    ; check for left and right arrows
    pixelgetcolor, c2, 1364, 540, RGB
    pixelgetcolor, c3, 556,  540, RGB
    if (c2 = 0xFFFFFF) and (c3 = 0xFFFFFF)
    {
        click, 950, 936
        click, 30,  460
        click, 388, 130
    }
Return
FS768p:
    if not roblox_check()
        return
    ; check for left and right arrows
    pixelgetcolor, c2, 971, 384, RGB
    pixelgetcolor, c3, 396, 384, RGB
    ToolTip, % (c2 = 0xFFFFFF) "and" (c3 = 0xFFFFFF), 0, 0
    if (c2 = 0xFFFFFF) and (c3 = 0xFFFFFF)
    {
        click, 680, 668
        click, 30, 320
        click, 270, 110
    }
Return


roblox_check()
{
    IfWinActive, ahk_exe RobloxPlayerBeta.exe
        Return true
    Return false
}


OCR(InputFile)
{
    global Tesseract, TesseractDir
    snapshot_chat()
    commands := ".\tesseract.exe '" . A_WorkingDir . InputFile "' '" A_WorkingDir . "\ocr\last" "' -l eng"
    Return runWaitMany(commands)
}

runWaitMany(commands) {
    global Tesseract, TesseractDir, LINE_IDIENTIFIER

    RunWait % "powershell.exe -command ""set-location '" TesseractDir "' `; " commands """",, HIDE
    FileLocation := SubStr(A_ScriptDir, 1, StrLen(A_ScriptDir) - 8) "\ocr\last.txt"
    FileRead, output, % SubStr(A_ScriptDir, 1, StrLen(A_ScriptDir) - 8) "\ocr\last.txt"

    Return output
}

snapshot_chat()
{
    global res
    WinActivate, % "ahk_exe RobloxPlayerBeta.exe"
    MouseGetPos, PosX, PosY
    send, /           ; open chat
    height := (res = "1366x768") ? 190 : 290
    
    commands := " Add-Type -AssemblyName System.Drawing `;"
    . " $Bitmap = New-Object System.Drawing.Bitmap 450, " height " `;"
    . " $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap) `;"
    . " $Graphics.CopyFromScreen(10, 100, 0, 0, $Bitmap.Size) `;"
    . " $File = '" SubStr(A_ScriptDir, 1, StrLen(A_ScriptDir) - 8) "\ocr\screenshot.png' `;"
    . " $Bitmap.Save($File, [System.Drawing.Imaging.ImageFormat]::Png) `;"
    . " $Graphics.Dispose() `;"
    . " $Bitmap.Dispose() `;"
    RunWait % "powershell.exe -command """ commands """",, HIDE ; Get screenshot of active chat
    sleep, 1


    click, 140, 35, 1 ; close chat
    MouseMove, %PosX%, %PosY%, 1
}

; get location of tesseract install
find_tesseract()
{
    global iniFilePath

    if FileExist("C:\Program Files\Tesseract-OCR\tesseract.exe")
        return "C:\Program Files\Tesseract-OCR\tesseract.exe"

    if FileExist("C:\Program Files (x86)\Tesseract-OCR\tesseract.exe")
        return "C:\Program Files (x86)\Tesseract-OCR\tesseract.exe"

    if FileExist(A_AppData . "\Program\Tesseract-OCR\tesseract.exe")
        return A_AppData . "\Program\Tesseract-OCR\tesseract.exe"

    if FileExist(A_AppData . "\Tesseract-OCR\tesseract.exe")
        return A_AppData . "\Tesseract-OCR\tesseract.exe"

    IniRead, CustomTesseractLocation, %iniFilePath%, "OCR", "CustomTesseractLocation"
    if FileExist(CustomTesseractLocation)
        return CustomTesseractLocation
    
    throw Exception("Tesseract not found")
}
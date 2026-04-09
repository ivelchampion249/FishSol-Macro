; nothing to see here :blush:

/*
    for best results have gui transparency set at max so chat can't be seen through!
*/

; #Requires AutoHotkey v1.1
#NoEnv
#SingleInstance, Force
#Persistent
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
SetWorkingDir % SubStr(A_ScriptDir, 1, StrLen(A_ScriptDir) - 8)
EnvGet, LocalAppData, LOCALAPPDATA

global Tesseract := find_tesseract()
global TesseractDir := StrReplace(Tesseract, "\tesseract.exe", "")

OnMessage(0x4a, "Receive_WM_COPYDATA") ; script communications
FileReadLine, VersionLine, % A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1", 1

ExpectedFileVersion := "#version 1.3"
if not FileExist(A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1") or VersionLine != ExpectedFileVersion
{
    if FileExist(A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1")
    {
        FileSetAttrib, -R-A, % A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1"
        FileDelete, % A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1"
    }
    width := 450
    height1 := 290 ; or 190 for 768p
    height2 := 190
    X := 10
    Y := 100
    FileOut := % ExpectedFileVersion "`nSet-Location '" TesseractDir "'`n"
     . "# Get the height from config resolution`t`t`t`t`t`t`t`t`t`t`t`t`t`t`tBasically a bunch of replace symbols on the ini file to make it accessable as a variable`n"
     . "$Config = Get-Content """ A_WorkingDir "\settings.ini"" | Where-Object { $_ -Match ""="" } | ForEach-Object { $_ -Replace ""#.*"", """" } |"
     . " ForEach-Object { $_ -Replace ""\\"", ""\\"" } | ForEach-Object { $_ -Replace '""', """" } | ConvertFrom-StringData`n"
     . "If ($Config.resolution -Eq ""1366x768"") { $height = " height2 " } Else { $height = " height1 "}`n"
	 . "Add-Type -AssemblyName System.Drawing`n`n"
	 . "# Capture Chatbox into MemoryStream(RAM)`n"
	 . "$Bitmap = New-Object System.Drawing.Bitmap " width ", $height`n"
	 . "$Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)`n"
	 . "$Graphics.CopyFromScreen(" X ", " Y ", 0, 0, $Bitmap.Size)`n"
	 . "$MemoryStream = New-Object System.IO.MemoryStream`n"
	 . "$Bitmap.Save($MemoryStream, [System.Drawing.Imaging.ImageFormat]::Png)`n"
	 . "$Bytes = $MemoryStream.ToArray()`n`n"
	 . "# Define Tesseract Process`n"
	 . "$ProcStartInfo = New-Object System.Diagnostics.ProcessStartInfo`n"
	 . "$ProcStartInfo.FileName = '" Tesseract "'`n"
	 . "$ProcStartInfo.Arguments = 'stdin stdout -l eng'`n"
	 . "$ProcStartInfo.RedirectStandardInput = $true`n"
	 . "$ProcStartInfo.RedirectStandardOutput = $true`n"
	 . "$ProcStartInfo.UseShellExecute = $false`n"
	 . "$ProcStartInfo.CreateNoWindow = $true`n`n"
	 . "# Start Tesseract Shell`n"
	 . "$Shell = [System.Diagnostics.Process]::Start($ProcStartInfo)`n"
	 . "$Shell.StandardInput.BaseStream.Write($Bytes, 0, $Bytes.Length)`n"
	 . "$Shell.StandardInput.BaseStream.Close()`n"
	 . "$Result = $Shell.StandardOutput.ReadToEnd()`n`n"
	 . "$Shell.WaitForExit()`n"
	 . "$AHKMessage = ""Data:`{'$Result'`}:ataD""`n`n"
	 . "# Memory Cleanup`n"
	 . "$Graphics.Dispose()`; $Bitmap.Dispose()`; $MemoryStream.Flush()`; $MemoryStream.Dispose()`; $Shell.Dispose()`;`n`n"
	 . "# Define SendMessage and copydatastrut`n"
	 . "$MemberDef = @""`n[DllImport(""user32.dll"")]`npublic static extern IntPtr SendMessage(IntPtr hWnd, int Msg, IntPtr wParam, ref COPYDATASTRUCT lParam)`;`npublic struct COPYDATASTRUCT`n{`n    public IntPtr dwData`;`n    public int cbData`;`n    public IntPtr lpData`;`n}`n""@`n"
	 . "$WinAPI = Add-Type -MemberDefinition $MemberDef -Name ""Win32SendMessage"" -Namespace ""Win32"" -PassThru`n"
	 . "# Reuse Bytes variable`n"
	 . "$Bytes = [System.Text.Encoding]::Unicode.GetBytes($AHKMessage)`n"
	 . "$PTR = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($Bytes.Length)`n"
	 . "[System.Runtime.InteropServices.Marshal]::Copy($Bytes, 0, $PTR, $Bytes.Length)`n"
	 . "# Send data back to AHK`n"
	 . "$CopyDataStrut = [Win32.Win32SendMessage+COPYDATASTRUCT]::new()`n"
	 . "$CopyDataStrut.dwData = [IntPtr]::Zero`n"
	 . "$CopyDataStrut.cbData = $Bytes.Length`n"
	 . "$CopyDataStrut.lpData = $PTR`n"
	 . "$HWND = (Get-Process | Where-Object { $_.MainWindowTitle -like ""easter.egg.pathing""}).MainWindowHandle`n"
	 . "if ($HWND) {[Win32.Win32SendMessage]::SendMessage($HWND, 0x4a, [IntPtr]::Zero, [ref]$CopyDataStrut)}`n"
	 . "[System.Runtime.InteropServices.Marshal]::FreeHGlobal($PTR)`n"
	. "# THESE FILE CONTENTS CAN STILL BE PASTED INTO POWERSHELL MANUALLY"
    FileAppend, %FileOut%, % A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1"
    FileSetAttrib, +R-A, % A_WorkingDir "\ocr\MemoryOCR_CaptureRobloxChat.ps1"
}
global standalone := (A_ScriptDir ~= "\\plugins") != 0

global iniFilePath := A_WorkingDir "\settings.ini"

validWebhook := true
if (FileExist(iniFilePath)) {
    IniRead, res, %iniFilePath%, "Macro", "resolution"
    IniRead, tempWebhook, %iniFilePath%, "Macro", "webhookURL"
    IniRead, tempPSLink, %iniFilePath%, "Biomes", "privateServerLink" ;using biomes like temporarily
    if (tempWebhook != "ERROR" && tempPSLink != "ERROR")
    {
        webhookURL := tempWebhook
        privateServerLink := tempPSLink
        if (!InStr(webhookURL, "discord")) {
            validWebhook := false
        }
    } else {
        validWebhook := false
    }
}
Else
    validWebhook := false

; make window for communitcations
gui, new, +ToolWindow,easter.egg.pathing
gui, add, Text, ,TEST FILE STUFF
gui, show, w200 Minimize
global LastLine := ""
global NewLine  := ""

if standalone
    SetTimer, readlog, 60000
return

start:
    ; Gosub, readlog
    SetTimer, readlog, 60000
	ToolTip, % "Res: " res, 500, 90, 4
    Sleep 20000
    if (res = "1440p")
    {
        SetTimer, FS1440p, 100
        SetTimer, MerchantClick1, 5000
    }
    if (res = "1080p")
    {
		ToolTip, % "CHECK: ", 500, 120, 5
        SetTimer, MerchantClick2, 5000
        SetTimer, FS1080p, 100
    }
    if (res = "1366x768")
    {
        SetTimer, FS768p, 100
        SetTimer, MerchantClick3, 5000
    }
return

stop:
    SetTimer, readlog, Off
    if (res = "1440p")
    {
        SetTimer, FS1440p, off
        SetTimer, MerchantClick1, off
    }
    if (res = "1080p")
    {
        SetTimer, FS1080p, off
        SetTimer, MerchantClick2, off
    }
    if (res = "1366x768")
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
    if not validWebhook
        Return
    
    time := A_NowUTC
    timestamp := SubStr(time,1,4) "-" SubStr(time,5,2) "-" SubStr(time,7,2) "T" SubStr(time,9,2) ":" SubStr(time,11,2) ":" SubStr(time,13,2) ".000Z"

    json := "{"
    . """embeds"": ["
    . "{"
    . "    ""title"": """ title ""","
    . "    ""color"": " color ","
    . "    ""footer"": {""text"": ""Easter.Egg.Pathing"", ""icon_url"": ""https://maxstellar.github.io/fishSol%20icon.png""},"
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

	ToolTip, %CopyOfData%, 500, 30, 2
    if CopyOfData ~= "stop|pause"
    {
        ToolTip, Stop, 500, 0
        Gosub, stop
        return true
    }

    if CopyOfData ~= "start"
    {
        ToolTip, Start, 500, 0
        Gosub, start
        return true
    }

    if CopyOfData ~= "kill"
    {
        ToolTip, KillApp, 500, 0
        SetTimer, killme, -1
        return true
    }
    
    if InStr(CopyOfData, "Data:{") and InStr(CopyOfData, "}:ataD")
    {
        ReturnValue := RegExReplace(CopyOfData, "(?:Data:{)|(?:}:ataD)", "")
        SetTimer, SendToRead
        return true
    }
    Else
    {
        MsgBox, % CopyOfData
        return true
    }

    return false
}

SendToRead:
    testLines := [ "Wait am [li\|] sti[li\|][li\|] Dreaming\?"
                    , "Preparing Protoco[li\|]\..Do you want to be my friend\?."
                    , "Scanning\. Egg cannon charging 2000\%\."
                    , "Let.s have an egg hunt here"
                    , "Don.t forget to water the .sma[li\|I][li\|I] p[li\|I]ant\."
                    , "Ho[li\|]y Eggeus"
                    , "Am [li\|] in spaaaace right now\?[li\|\!]"
                    , "A Specia[li\|] Egg has Spawned\."]
    Eggs := [ "Dreamer Egg"
                    , "Egg v2.0"
                    , "The Egg of the Sky"
                    , "Forest Egg"
                    , "Blooming Egg"
                    , "Angelic Egg"
                    , "Andromeda Egg"
                    , "Royal or Hatch Egg"]
    hasEgg := false
    if chat_output ~= "\[Egg Spawned\]"
        hasEgg := true
    EggIndex := -1
    Loop % testLines.Length()
    {
        if (chat_output ~= testLines[A_Index]) or (chat_output ~= "[Egg Spawned] " . testLines[A_Index])
        {
            hasEgg := true
            EggIndex := A_Index
            Break
        }
    }
    if hasEgg and (EggIndex > 0)
        try SendWebhook(":egg: " Eggs[EggIndex] " Spawned!")
Return

F3:
killme:
ExitApp
Return

; leave merchant click no auto detect version [update to smart version]
; not running? maybe bugged
MerchantClick1: ; 1440p
    if not roblox_check()
        return
    Click, 1686, 1261, 3
Return

MerchantClick2: ; 1080p
	ToolTip, % "CAN RUN: " roblox_check(), 500, 60, 3
    if not roblox_check()
        return
    Click, 1265, 943, 3
Return

MerchantClick3: ; 768p
    if not roblox_check()
        return
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
    snapshot_chat(InputFile)
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

snapshot_chat(InputFile)
{
    global res
    ;force roblox to be in front
    while not roblox_check()
        WinActivate, % "ahk_exe RobloxPlayerBeta.exe"
    sleep 100

    MouseGetPos, PosX, PosY
    send, /           ; open chat
    height := (res = "1366x768") ? 190 : 290
    
    commands := "Add-Type -AssemblyName System.Drawing `; "
    . " $Bitmap = New-Object System.Drawing.Bitmap 450, " . height . " `; "
    . " $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap) `; "
    . " $Graphics.CopyFromScreen(10, 100, 0, 0, $Bitmap.Size) `; "
    . " $File = '" . SubStr(A_ScriptDir, 1, StrLen(A_ScriptDir) - 8) . InputFile . "' `; "
    . " $Bitmap.Save($File, [System.Drawing.Imaging.ImageFormat]::Png) `; "
    . " $Graphics.Dispose() `; "
    . " $Bitmap.Dispose() `; "
    Run % "powershell.exe -command """ commands """",, HIDE ; Get screenshot of active chat
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

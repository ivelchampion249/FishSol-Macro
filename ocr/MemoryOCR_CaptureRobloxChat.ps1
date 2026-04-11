#version 1.3.13
Set-Location 'C:\Program Files\Tesseract-OCR'
# Get the height from config resolution															Basically a bunch of replace symbols on the ini file to make it accessable as a variable
$Config = Get-Content "C:\Nades Programs\AutoHotkeys\EggSols\settings.ini" | Where-Object { $_ -Match "=" } | ForEach-Object { $_ -Replace "#.*", "" } | ForEach-Object { $_ -Replace "\\", "\\" } | ForEach-Object { $_ -Replace '"', "" } | ConvertFrom-StringData
If ($Config.resolution -Eq "1366x768") { $height = 190 } Else { $height = 290}
Add-Type -AssemblyName System.Drawing

# Capture Chatbox into MemoryStream(RAM)
$Bitmap = New-Object System.Drawing.Bitmap 450, $height
$Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
$Graphics.CopyFromScreen(10, 100, 0, 0, $Bitmap.Size)
$MemoryStream = New-Object System.IO.MemoryStream
$Bitmap.Save($MemoryStream, [System.Drawing.Imaging.ImageFormat]::Png)
$Bytes = $MemoryStream.ToArray()

# Define Tesseract Process
$ProcStartInfo = New-Object System.Diagnostics.ProcessStartInfo
$ProcStartInfo.FileName = 'C:\Program Files\Tesseract-OCR\tesseract.exe'
$ProcStartInfo.Arguments = 'stdin stdout -l eng'
$ProcStartInfo.RedirectStandardInput = $true
$ProcStartInfo.RedirectStandardOutput = $true
$ProcStartInfo.UseShellExecute = $false
$ProcStartInfo.CreateNoWindow = $true

# Start Tesseract Shell
$Shell = [System.Diagnostics.Process]::Start($ProcStartInfo)
$Shell.StandardInput.BaseStream.Write($Bytes, 0, $Bytes.Length)
$Shell.StandardInput.BaseStream.Close()
$Result = $Shell.StandardOutput.ReadToEnd()

$Shell.WaitForExit()
$AHKMessage = "Data:{'$Result'}:ataD"

# Memory Cleanup
$Graphics.Dispose(); $Bitmap.Dispose(); $MemoryStream.Flush(); $MemoryStream.Dispose(); $Shell.Dispose();

# Define SendMessage and copydatastrut
$MemberDef = @"
[DllImport("user32.dll")]
public static extern IntPtr SendMessage(IntPtr hWnd, int Msg, IntPtr wParam, ref COPYDATASTRUCT lParam);
public struct COPYDATASTRUCT
{
    public IntPtr dwData;
    public int cbData;
    public IntPtr lpData;
}
"@
$WinAPI = Add-Type -MemberDefinition $MemberDef -Name "Win32SendMessage" -Namespace "Win32" -PassThru
# Reuse Bytes variable
$Bytes = [System.Text.Encoding]::Unicode.GetBytes($AHKMessage)
$PTR = [System.Runtime.InteropServices.Marshal]::AllocHGlobal($Bytes.Length)
[System.Runtime.InteropServices.Marshal]::Copy($Bytes, 0, $PTR, $Bytes.Length)
# Send data back to AHK
$CopyDataStrut = [Win32.Win32SendMessage+COPYDATASTRUCT]::new()
$CopyDataStrut.dwData = [IntPtr]::Zero
$CopyDataStrut.cbData = $Bytes.Length
$CopyDataStrut.lpData = $PTR
$HWND = (Get-Process | Where-Object { $_.MainWindowTitle -like "easter.egg.pathing"}).MainWindowHandle
Start-Sleep 1
if ($HWND)
{
    for($i = 0; $i -lt 5; $i++) {
        $returnMessage = [Win32.Win32SendMessage]::SendMessage($HWND, 0x4a, [IntPtr]::Zero, [ref]$CopyDataStrut)
        if (1 -eq $returnMessage) {            Break
        }        else { Start-Sleep 1 }
    }
}
[System.Runtime.InteropServices.Marshal]::FreeHGlobal($PTR)
Start-Sleep 10
# THESE FILE CONTENTS CAN STILL BE PASTED INTO POWERSHELL MANUALLY
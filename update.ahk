;=============================================================
;
; FileName: FTools_Update
;
;     Date: 2012/07/09
;
;   Author: joyma
;
;=============================================================

UpdateURL = http://ecd.ecc.com/FTools/

Download(url, file)
{
    static vt
    if !VarSetCapacity(vt)
    {
        VarSetCapacity(vt, A_PtrSize*11), nPar := "31132253353"
        Loop Parse, nPar
            NumPut(RegisterCallback("DL_Progress", "F", A_LoopField, A_Index-1), vt, A_PtrSize*(A_Index-1))
    }
    global _cu
    SplitPath file, dFile
    SysGet m, MonitorWorkArea, 1
    y := mBottom-52-2, x := mRight-330-2, VarSetCapacity(_cu, 100), VarSetCapacity(tn, 520)
    , DllCall("shlwapi\PathCompactPathEx", "str", _cu, "str", url, "uint", 50, "uint", 0)
    Progress Hide CWFAFAF7 CT000020 CB445566 x%x% y%y% w330 h52 B1 FS8 WM700 WS700 FM8 ZH12 ZY3 C11,, %_cu%, AutoHotkeyProgress, Tahoma
    if (0 = DllCall("urlmon\URLDownloadToCacheFile", "ptr", 0, "str", url, "str", tn, "uint", 260, "uint", 0x10, "ptr*", &vt))
        FileCopy %tn%, %file%
    else
        ErrorLevel := 1
    Progress Off
    return !ErrorLevel
}
DL_Progress( pthis, nP=0, nPMax=0, nSC=0, pST=0 )
{
    global _cu
    if A_EventInfo = 6
    {
        Progress Show
        Progress % P := 100*nP//nPMax, % "Downloading:     " Round(np/1024,1) " KB / " Round(npmax/1024) " KB    [ " P "`% ]", %_cu%
    }
    return 0
}


DownloadStartTime = %A_Now%
TrayTip,,正在更新，请稍后……
Sleep,1000
FileDelete,%A_ScriptDir%/FTools.exe
Sleep,2000
URLDownloadToFile,%UpdateURL%FTools.exe,%A_ScriptDir%/FTools.exe
;Download("%UpdateURL%FTools.exe","FTools.exe.temp")
DownloadEndTime = %A_Now%
DownloadUseTime := DownloadEndTime - DownloadStartTime
;FileMove, %A_ScriptDir%\FTools.exe.temp, %A_ScriptDir%\FTools.exe,1
Sleep,2000
TrayTip,,
MsgBox,0,FTools已更新,FTools已更新至最新版！`n（耗时：%DownloadUseTime%秒）
Run,%A_ScriptDir%\FTools.exe
ExitApp



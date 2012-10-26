;=============================================================
;
; FileName: FTools
;
;     Date: 2012/06/25
;
;   Author: joyma
;
;=============================================================

#Include FTPv2.ahk ;引入FTP类库

#HotkeyInterval 2000  ; 随同 #HotkeyInterval 一起，指定 热键 激活的速率，当超过这一速率时，将会显示一个警告对话框。
#MaxHotkeysPerInterval 200

#NoEnv
#Persistent
#SingleInstance, Force ;保证程序单例运行
;#NoTrayIcon

VerCurrent = 0.9.6.1 ;定义当前版本号
UpdateURL = http://ecd.ecc.com/FTools/
;UpdateURL = http://localhost.kp/FTools/

;S 公共函数 检测配置文件配置项
CheckConfig(key,section,default)
{
	;MsgBox,%key% in %section%
	IniRead, z, %A_ScriptDir%\Config.ini, %section%, %key%
	If z=error
	{
		;MsgBox,error to read : %key% in %section%`n Now to write %default% of %key% in %section%
		IniWrite,%default%,%A_ScriptDir%\Config.ini,%section%,%key%
	}
	Else
	{
		;MsgBox,ok to read: %key%
	}
}
;E 公共函数 检测配置文件配置项


;S 新增功能ini检测
CheckConfig("fs_BuildShortcut","FToolsFunctionState",1)
CheckConfig("gs_BuildShortcut","FToolsGlobalState",1)
CheckConfig("FTbuildshortcut","FToolsKeyInfo","+!L")
CheckConfig("ShortcutPath","FToolsExtraConfig","D:\link\")
;E 新增功能ini检测

;S 使用功能、次数统计函数
SentToRecord(Function,Parameter)
{
	global VerCurrent
	global UpdateURL
	BaseURL = %UpdateURL%index.php/count/
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	RecordURL = %BaseURL%%Function%?%Parameter%&user=%A_UserName%&ip=%A_IPAddress1%&version=%VerCurrent%&os=%A_OSVersion%
	;MsgBox,%RecordURL%
	WebRequest.Open("GET", RecordURL)
	WebRequest.Send()
}
;E 使用功能、次数统计函数


;S 读取新人指数
IniRead, ShowNewTips, %A_ScriptDir%\Config.ini, FToolsSetting, ShowNewTips
;E 读取新人指数

;S 读取图片压缩比例
IniRead, ImgCompressQuality, %A_ScriptDir%\Config.ini, FToolsSetting, ImgCompressQuality
;E 读取图片压缩比例

;S 读取功能开关状态
IniRead, fs_StartWork, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_StartWork
IniRead, fs_PickColor, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_PickColor
IniRead, fs_BuildShortcut, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_BuildShortcut
IniRead, fs_ImgDemo, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_ImgDemo
IniRead, fs_TimeStamp, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_TimeStamp
IniRead, fs_CopyPath, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyPath
IniRead, fs_CopyName, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyName
IniRead, fs_CopyURL, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyURL
IniRead, fs_QuickOpen, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_QuickOpen
IniRead, fs_QuickSearch, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_QuickSearch
IniRead, fs_AlwaysTop, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_AlwaysTop
IniRead, fs_Transparency, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_Transparency
IniRead, fs_FTPupload, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPupload
IniRead, fs_FTPDelete, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPDelete
IniRead, fs_FTPCompare, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPCompare
IniRead, fs_FTPTimeStamp_wg, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPTimeStamp_wg
IniRead, fs_ImgCompress, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_ImgCompress
;E 读取功能开关状态

;S 读取快捷键配置文件
IniRead, FTopen, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTopen
IniRead, FTstartwork, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTstartwork
IniRead, FTpickcolor, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTpickcolor
IniRead, FTbuildshortcut, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTbuildshortcut
IniRead, FTimgdemo, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTimgdemo
IniRead, FTimgcompress, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTimgcompress
IniRead, FTtimestamp, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTtimestamp
IniRead, FTcopypath, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopypath
IniRead, FTcopyname, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopyname
IniRead, FTcopyurl, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopyurl
IniRead, FTquickopen, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquickopen
IniRead, FTquicksearch, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquicksearch
IniRead, FTquicksearch_url, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquicksearch_url
IniRead, FTPupload, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPupload
IniRead, FTPdelete, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPdelete
IniRead, FTPcompare, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPcompare
IniRead, FTPtimestamp_wg, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPtimestamp_wg
;E 读取快捷键配置文件

;S 读取其他配置
IniRead, BComparePath, %A_ScriptDir%\Config.ini, FToolsExtraConfig, BComparePath
IniRead, ShortcutPath, %A_ScriptDir%\Config.ini, FToolsExtraConfig, ShortcutPath
;E 读取其他配置

;S 子菜单定义

;E 子菜单定义

;S 改变hotkey键值可读
GetHotkeyName(p_hotkey)
{
	StringReplace, p_hotkey, p_hotkey, +, Shift +%A_space%
	StringReplace, p_hotkey, p_hotkey, #, Win +%A_space%
	StringReplace, p_hotkey, p_hotkey, !, Alt +%A_space%
	StringReplace, p_hotkey, p_hotkey, ^, Ctrl +%A_space%
	StringReplace, p_hotkey, p_hotkey, Numpad0, , Num 0
	StringReplace, p_hotkey, p_hotkey, NumpadIns, Num Ins
	StringReplace, p_hotkey, p_hotkey, Numpad1, Num 1
	StringReplace, p_hotkey, p_hotkey, NumpadEnd, Num End
	StringReplace, p_hotkey, p_hotkey, Numpad2, Num 2
	StringReplace, p_hotkey, p_hotkey, NumpadDown, Num Down
	StringReplace, p_hotkey, p_hotkey, Numpad3, Num 3
	StringReplace, p_hotkey, p_hotkey, NumpadPgDn, Num PgDn
	StringReplace, p_hotkey, p_hotkey, Numpad4, Num 4
	StringReplace, p_hotkey, p_hotkey, NumpadLeft, Num Left
	StringReplace, p_hotkey, p_hotkey, Numpad5, Num 5
	StringReplace, p_hotkey, p_hotkey, NumpadClear, Num Clear
	StringReplace, p_hotkey, p_hotkey, Numpad6, Num 6
	StringReplace, p_hotkey, p_hotkey, NumpadRight, Num Right
	StringReplace, p_hotkey, p_hotkey, Numpad7, Num 7
	StringReplace, p_hotkey, p_hotkey, NumpadHome, Num Home
	StringReplace, p_hotkey, p_hotkey, Numpad8, Num 8
	StringReplace, p_hotkey, p_hotkey, NumpadUp, Num Up
	StringReplace, p_hotkey, p_hotkey, Numpad9, Num 9
	StringReplace, p_hotkey, p_hotkey, NumpadPgUp, Num Page Up
	StringReplace, p_hotkey, p_hotkey, NumpadDot, Num Dot
	StringReplace, p_hotkey, p_hotkey, NumpadDel, Num Del
	StringReplace, p_hotkey, p_hotkey, NumpadDiv, Num /
	StringReplace, p_hotkey, p_hotkey, NumpadMult, Num *
	StringReplace, p_hotkey, p_hotkey, NumpadAdd, Num +
	StringReplace, p_hotkey, p_hotkey, NumpadSub, Num -
	StringReplace, p_hotkey, p_hotkey, NumpadEnter, Num Enter
	StringReplace, p_hotkey, p_hotkey, ScrollLock, Scroll Lock
	StringReplace, p_hotkey, p_hotkey, CapsLock, Caps Lock
	StringReplace, p_hotkey, p_hotkey, NumLock, Num Lock
	StringReplace, p_hotkey, p_hotkey, PgUp, Page Up
	StringReplace, p_hotkey, p_hotkey, PgDn, Page Down
	StringReplace, p_hotkey, p_hotkey, Browser_Back, Browser Back
	StringReplace, p_hotkey, p_hotkey, Browser_Forward, Browser Forward
	StringReplace, p_hotkey, p_hotkey, CtrlBreak, Break
	return p_hotkey
}
;E 改变hotkey键值可读

;S 重定义快捷键显示
FTstartwork_show:=GetHotkeyName(FTstartwork)
FTpickcolor_show:=GetHotkeyName(FTpickcolor)
FTbuildshortcut_show:=GetHotkeyName(FTbuildshortcut)
FTimgdemo_show:=GetHotkeyName(FTimgdemo)
FTtimestamp_show:=GetHotkeyName(FTtimestamp)
FTcopypath_show:=GetHotkeyName(FTcopypath)
FTcopyname_show:=GetHotkeyName(FTcopyname)
FTcopyurl_show:=GetHotkeyName(FTcopyurl)
FTquickopen_show:=GetHotkeyName(FTquickopen)
FTquicksearch_show:=GetHotkeyName(FTquicksearch)
FTPupload_show:=GetHotkeyName(FTPupload)
FTPdelete_show:=GetHotkeyName(FTPdelete)
FTPcompare_show:=GetHotkeyName(FTPcompare)
FTPtimestamp_wg_show:=GetHotkeyName(FTPtimestamp_wg)
FTimgcompress_show:=GetHotkeyName(FTimgcompress)
;E 重定义快捷键显示


;S 读取开关状态，并定义菜单，分配给子程序相应热键
Menu, Tray, NoStandard
Menu, Tray, Tip, FTools v%VerCurrent%
Menu, Tray, Add, &FTools v%VerCurrent% ,About
Menu, Tray, Default, &FTools v%VerCurrent%
Menu, Tray, Add,
If fs_StartWork=1
{
	Menu, Tray, Add, StartWork(%FTstartwork_show%) , chk_StartWork
	Hotkey, %FTstartwork%, StartWork, UseErrorLevel
	Menu, Tray, Add,
}
If fs_PickColor=1
{
	Menu, Tray, Add, PickColor(%FTpickcolor_show%)  , PickColor
	Hotkey, %FTpickcolor%, PickColor, UseErrorLevel
	Menu, Tray, Add,
}
If fs_BuildShortcut=1
{
	Menu, Tray, Add, BuildShortcut(%FTbuildshortcut_show%)  , chk_BuildShortcut
	Hotkey, %FTbuildshortcut%, BuildShortcut, UseErrorLevel
	Menu, Tray, Add,
}
If fs_ImgDemo=1
{
	Menu, Tray, Add, ImgDemo(%FTimgdemo_show%)  , chk_ImgDemo
	Hotkey, %FTimgdemo%, ImgDemo, UseErrorLevel
}
If fs_ImgCompress=1
{
	Menu, Tray, Add, ImgCompress(%FTimgcompress_show%)  , chk_ImgCompress
	Hotkey, %FTimgcompress%, ImgCompress, UseErrorLevel
}
If fs_TimeStamp=1
{
	Menu, Tray, Add, TimeStamp(%FTtimestamp_show%)  , chk_TimeStamp
	Hotkey, %FTtimestamp%, TimeStamp, UseErrorLevel
	Menu, Tray, Add,
}
if fs_CopyPath=1
{
	Menu, Tray, Add, CopyPath(%FTcopypath_show%) , chk_CopyPath
	Hotkey, %FTcopypath%, CopyPath, UseErrorLevel

}
If fs_CopyName=1
{
	Menu, Tray, Add, CopyName(%FTcopyname_show%) , chk_CopyName
	Hotkey, %FTcopyname%, CopyName, UseErrorLevel
}
If fs_CopyURL=1
{
	Menu, Tray, Add, CopyURL(%FTcopyurl_show%) , chk_CopyURL
	Hotkey, %FTcopyurl%, CopyURL, UseErrorLevel
	Menu, Tray, Add,
}
If fs_QuickOpen=1
{
	Menu, Tray, Add, QuickOpen(%FTquickopen_show%) , chk_QuickOpen
	Hotkey, %FTquickopen%, QuickOpen, UseErrorLevel
}
If fs_QuickSearch=1
{
	Menu, Tray, Add, QuickSearch(%FTquicksearch_show%) , chk_QuickSearch
	Hotkey, %FTquicksearch%, QuickSearch, UseErrorLevel
	Menu, Tray, Add,
}
If fs_AlwaysTop=1
{
	Menu, Tray, Add, AlwaysTop(Mouse) , chk_AlwaysTop
}
If fs_Transparency=1
{
	Menu, Tray, Add, Transparency(Mouse) , chk_Transparency
	Menu, Tray, Add,
}
If fs_FTPUpload=1
{
	Menu, Tray, Add, FTPUpload(%FTPupload_show%) ,chk_FTPupload
	Hotkey, %FTPupload%, FTPupload, UseErrorLevel
}
If fs_FTPDelete=1
{
	Menu, Tray, Add, FTPDelete(%FTPdelete_show%),chk_FTPDelete
	Hotkey, %FTPdelete%, FTPDelete, UseErrorLevel
}
If fs_FTPCompare=1
{
	Menu, Tray, Add, FTPCompare(%FTPcompare_show%) ,chk_FTPCompare
	Hotkey, %FTPcompare%, FTPCompare, UseErrorLevel
}
If fs_FTPTimeStamp_wg=1
{
	Menu, Tray, Add, FTPTimeStamp_wg(%FTPtimestamp_wg_show%) ,chk_FTPTimeStamp_wg
	Hotkey, %FTPtimestamp_wg%, FTPTimeStamp_wg, UseErrorLevel
}
Menu, Tray, Add,
Menu, Tray, Add, About , About
Menu, Tray, Add, Update , Update
Menu, Tray, Add, Setting, Setting
Menu, Tray, Add, Reload, TrayReload
Menu, Tray, Add, Exit  , TrayExit
;E 读取开关状态，并定义菜单，分配给子程序相应热键

Hotkey, %FTopen%, showMenu, UseErrorLevel

;S 读取用户上一次的开关状态
IniRead, gs_StartWork, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_StartWork
IniRead, gs_PickColor, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_PickColor
IniRead, gs_BuildShortcut, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_BuildShortcut
IniRead, gs_ImgDemo, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_ImgDemo
IniRead, gs_TimeStamp, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_TimeStamp
IniRead, gs_CopyPath, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_CopyPath
IniRead, gs_CopyName, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_CopyName
IniRead, gs_CopyURL, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_CopyURL
IniRead, gs_QuickOpen, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_QuickOpen
IniRead, gs_QuickSearch, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_QuickSearch
IniRead, gs_AlwaysTop, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_AlwaysTop
IniRead, gs_Transparency, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_Transparency
IniRead, gs_FTPupload, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_FTPupload
IniRead, gs_FTPDelete, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_FTPDelete
IniRead, gs_FTPCompare, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_FTPCompare
IniRead, gs_FTPTimeStamp_wg, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_FTPTimeStamp_wg
IniRead, gs_ImgCompress, %A_ScriptDir%\Config.ini, FToolsGlobalState, gs_ImgCompress
;E 读取用户上一次的开关状态


;S 定义全局变量 gs=Global State
/* 注释掉，改为读取配置文件
gs_StartWork=0
gs_PickColor=0
gs_CopyPath=0
gs_CopyName=0
gs_CopyURL=0
gs_QuickOpen=0
gs_QuickSearch=0
gs_AlwaysTop=0
gs_Transparency=0
gs_FTPupload=0
gs_FTPDelete=0
gs_FTPCompare=0
*/
;E 定义全局变量


;S 程序初始化
_init:

Parameter = StartWork=%fs_StartWork%&PickColor=%fs_PickColor%&BuildShortcut=%fs_BuildShortcut%&ImgDemo=%fs_ImgDemo%&TimeStamp=%fs_TimeStamp%&CopyPath=%fs_CopyPath%&CopyName=%fs_CopyName%&CopyURL=%fs_CopyURL%&QuickOpen=%fs_QuickOpen%&QuickSearch=%fs_QuickSearch%&AlwaysTop=%fs_AlwaysTop%&Transparency=%fs_Transparency%&FTPupload=%fs_FTPupload%&FTPdelete=%fs_FTPDelete%&FTPcompare=%fs_FTPCompare%&FTPTimeStamp_wg=%fs_FTPTimeStamp_wg%&ImgCompress=%fs_ImgCompress%
;MsgBox,%Parameter%
SentToRecord("startRecord",Parameter)


If (ShowNewTips = 1)
{
	SplashImage, %A_ScriptDir%/resource/show.png,,,,FTools v%VerCurrent%
	Sleep,3000
	SplashImage,off
	MsgBox,64,FTools v%VerCurrent% ,亲，欢迎使用FTools前端自动化工具集！`n`n检测到您是第一次使用本工具，现在将引导您配置本工具。
	MsgBox,64,FTools 新人设置 1/4 ,第一步，您需要确认开启工具中的哪些功能，通过勾选checkbox即可`n`n同时，您需要在输入框内按下快捷键已进行相应设置。


	Gui, Font, S12 CDefault bold, Verdana
	Gui, Add, Text, x10 y15 w630 h26 +Center, FTools Setting
	Gui, Font, S9 CDefault Normal, Verdana

	Gui, Add, CheckBox,vfs_StartWork x22 y50 w110 h30 +left, StartWork
	Gui, Add, Hotkey, x142 y50 w140 h30 vFTstartwork,
	Gui, Add, CheckBox,vfs_PickColor x302 y50 w110 h30 +left, PickColor
	Gui, Add, Hotkey, x422 y50 w140 h30 vFTpickcolor,
	Gui, Add, CheckBox,vfs_ImgDemo x22 y90 w110 h30 +left, ImgDemo
	Gui, Add, Hotkey, x142 y90 w140 h30 vFTimgdemo,
	Gui, Add, CheckBox,vfs_TimeStamp x302 y90 w110 h30 +left, TimeStamp
	Gui, Add, Hotkey, x422 y90 w140 h30 vFTtimestamp,
	Gui, Add, CheckBox,vfs_CopyPath x22 y130 w110 h30 +left, CopyPath
	Gui, Add, Hotkey, x142 y130 w140 h30 vFTcopypath,
	Gui, Add, CheckBox,vfs_CopyName x302 y130 w110 h30 +left, CopyName
	Gui, Add, Hotkey, x422 y130 w140 h30 vFTcopyname,
	Gui, Add, CheckBox,vfs_CopyURL x22 y170 w110 h30 +left, CopyURL
	Gui, Add, Hotkey, x142 y170 w140 h30 vFTcopyurl,
	Gui, Add, CheckBox,vfs_QuickOpen x302 y170 w110 h30 +left, QuickOpen
	Gui, Add, Hotkey, x422 y170 w140 h30 vFTquickopen,
	Gui, Add, CheckBox,vfs_QuickSearch x22 y210 w110 h30 +left, QuickSearch
	Gui, Add, Hotkey, x142 y210 w140 h30 vFTquicksearch,
	Gui, Add, Text, x320 y215 w120 h30 +left, QuickSearchUrl
	Gui, Add, DropDownList, x422 y210 w140 h120 vFTquicksearch_url Choose2, Baidu|Google
	Gui, Add, CheckBox,vfs_FTPupload x22 y250 w110 h30 +left, FTPupload
	Gui, Add, Hotkey, x142 y250 w140 h30 vFTPupload,
	Gui, Add, CheckBox,vfs_FTPdelete x302 y250 w110 h30 +left, FTPdelete
	Gui, Add, Hotkey, x422 y250 w140 h30 vFTPdelete,
	Gui, Add, CheckBox,vfs_FTPcompare x22 y290 w110 h30 +left, FTPcompare
	Gui, Add, Hotkey, x142 y290 w140 h30 vFTPcompare,
	Gui, Add, Text, x40 y335 w120 h30 +left, BComparePath
	Gui, Add, Edit, x142 y330 w420 h30 vBComparePath +BackgroundTrans,
	Gui, Add, CheckBox,vfs_FTPtimestamp_wg x22 y370 w110 h30 +left, FTPtimestamp
	Gui, Add, Hotkey, x142 y370 w140 h30 vFTPtimestamp_wg,
	Gui, Add, CheckBox,vfs_ImgCompress x22 y410 w110 h30 +left, ImgCompress
	Gui, Add, Hotkey, x142 y410 w140 h30 vFTimgcompress,
	Gui, Add, CheckBox,vfs_BuildShortcut x22 y450 w110 h30 +left, BuildShortcut
	Gui, Add, Hotkey, x142 y450 w140 h30 vFTbuildshortcut,
	Gui, Add, Text, x40 y495 w120 h30 +left, ShortcutPath
	Gui, Add, Edit, x142 y495 w420 h30 vShortcutPath +BackgroundTrans,
	;Gui, Add, Text,x302 y415 w50 h30 +left, Quality
	;Gui, Add, Edit, x352 y410 w50 h30 +Number +VScroll +Vertical vImgCompressQuality,
	;Gui, Add, Text, x402 y415 w50 h30,`%
	Gui, Add, Button, x142 y550 w80 h30 , Yes
	Gui, Add, Button, x262 y550 w80 h30 , No
	; 设置功能开关状态
	GuiControl, , fs_StartWork , %fs_StartWork%
	GuiControl, , fs_PickColor , %fs_PickColor%
	GuiControl, , fs_BuildShortcut , %fs_BuildShortcut%
	GuiControl, , fs_ImgDemo , %fs_ImgDemo%
	GuiControl, , fs_ImgCompress , %fs_ImgCompress%
	GuiControl, , ImgCompressQuality , %ImgCompressQuality%
	GuiControl, , fs_TimeStamp , %fs_TimeStamp%
	GuiControl, , fs_CopyPath , %fs_CopyPath%
	GuiControl, , fs_CopyName , %fs_CopyName%
	GuiControl, , fs_CopyURL , %fs_CopyURL%
	GuiControl, , fs_QuickOpen , %fs_QuickOpen%
	GuiControl, , fs_QuickSearch , %fs_QuickSearch%
	GuiControl, , fs_FTPupload , %fs_FTPupload%
	GuiControl, , fs_FTPdelete , %fs_FTPdelete%
	GuiControl, , fs_FTPcompare , %fs_FTPcompare%
	GuiControl, , fs_FTPtimestamp_wg , %fs_FTPtimestamp_wg%
	; 设置快捷键
	GuiControl, , FTstartwork, %FTstartwork%
	GuiControl, , FTpickcolor, %FTpickcolor%
	GuiControl, , FTbuildshortcut, %FTbuildshortcut%
	GuiControl, , FTimgdemo, %FTimgdemo%
	GuiControl, , FTimgcompress, %FTimgcompress%
	GuiControl, , FTtimestamp, %FTtimestamp%
	GuiControl, , FTcopypath, %FTcopypath%
	GuiControl, , FTcopyname, %FTcopyname%
	GuiControl, , FTcopyurl, %FTcopyurl%
	GuiControl, , FTquickopen, %FTquickopen%
	GuiControl, , FTquicksearch, %FTquicksearch%
	;GuiControl, , FTquicksearch_url, %FTquicksearch_url%
	GuiControl, , FTPupload, %FTPupload%
	GuiControl, , FTPdelete, %FTPdelete%
	GuiControl, , FTPcompare, %FTPcompare%
	GuiControl, , FTPtimestamp_wg, %FTPtimestamp_wg%
	GuiControl, , BComparePath, %BComparePath%
	GuiControl, , ShortcutPath, %ShortcutPath%
	SettingForm_x:=Round((A_ScreenWidth-630)/2)
	;MsgBox,%SettingForm_x%
	Gui, Show, x%SettingForm_x% y260 h600 w630, FTools 快捷键设置
	Return

	ButtonYes:
	{
		Gui, Submit, NoHide
		;获取checkbox中功能状态，并写入
		GuiControlGet, fs_StartWork
		GuiControlGet, fs_PickColor
		GuiControlGet, fs_BuildShortcut
		GuiControlGet, fs_ImgDemo
		GuiControlGet, fs_ImgCompress
		GuiControlGet, fs_TimeStamp
		GuiControlGet, fs_CopyPath
		GuiControlGet, fs_CopyName
		GuiControlGet, fs_CopyURL
		GuiControlGet, fs_QuickOpen
		GuiControlGet, fs_QuickSearch
		GuiControlGet, fs_FTPupload
		GuiControlGet, fs_FTPdelete
		GuiControlGet, fs_FTPcompare
		GuiControlGet, fs_FTPtimestamp_wg
		;写入配置信息
		IniWrite, %ImgCompressQuality%, %A_ScriptDir%\Config.ini, FToolsSetting, ImgCompressQuality
		;写入功能开关
		IniWrite, %fs_StartWork%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_StartWork
		IniWrite, %fs_PickColor%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_PickColor
		IniWrite, %fs_BuildShortcut%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_BuildShortcut
		IniWrite, %fs_ImgDemo%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_ImgDemo
		IniWrite, %fs_ImgCompress%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_ImgCompress
		IniWrite, %fs_TimeStamp%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_TimeStamp
		IniWrite, %fs_CopyPath%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyPath
		IniWrite, %fs_CopyName%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyName
		IniWrite, %fs_CopyURL%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyURL
		IniWrite, %fs_QuickOpen%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_QuickOpen
		IniWrite, %fs_QuickSearch%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_QuickSearch
		IniWrite, %fs_FTPupload%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPupload
		IniWrite, %fs_FTPdelete%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPdelete
		IniWrite, %fs_FTPcompare%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPcompare
		IniWrite, %fs_FTPtimestamp_wg%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPtimestamp_wg
		;写入快捷键
		IniWrite, %FTstartwork%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTstartwork
		IniWrite, %FTpickcolor%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTpickcolor
		IniWrite, %FTbuildshortcut%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTbuildshortcut
		IniWrite, %FTimgdemo%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTimgdemo
		IniWrite, %FTimgcompress%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTimgcompress
		IniWrite, %FTtimestamp%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTtimestamp
		IniWrite, %FTcopypath%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopypath
		IniWrite, %FTcopyname%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopyname
		IniWrite, %FTcopyurl%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopyurl
		IniWrite, %FTquickopen%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquickopen
		IniWrite, %FTquicksearch%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquicksearch
		IniWrite, %FTquicksearch_url%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquicksearch_url
		IniWrite, %FTPupload%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPupload
		IniWrite, %FTPdelete%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPdelete
		IniWrite, %FTPcompare%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPcompare
		IniWrite, %FTPtimestamp_wg%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPtimestamp_wg
		IniWrite, %BComparePath%, %A_ScriptDir%\Config.ini, FToolsExtraConfig, BComparePath
		IniWrite, %ShortcutPath%, %A_ScriptDir%\Config.ini, FToolsExtraConfig, ShortcutPath
		Gui, Destroy
		MsgBox,64,FTools 新人设置 2/4,快捷键及功能开关设置完毕！`n`n现在将协助您配置“一键工作”列表。`n`n您只需将目录地址或程序地址，按行贴入配置文件即可。
		RunWait,%A_ScriptDir%/StartLists.ini
		MsgBox,64,FTools 新人设置 3/4,亲，恭喜您，您已经基本设置完毕！`n`n还有，记得配置您的FTP信息哦~！
		MsgBox,48,FTools 新人设置 4/4,好了，现在工具将自动重启已更新配置信息~！耗时预计0.00001秒~`n`n然后，您就可以开始工作啦啦啦~~~！
		IniWrite, 0, %A_ScriptDir%\Config.ini, FToolsSetting, ShowNewTips
		Reload
		Return
	}
	ButtonNo:
	{
		MsgBox,16,FTools 新人设置,亲，我知道您是不小心关闭了。`n没关系，咱们再来一次吧~下次要认真了哦~~！
		Reload
	}




}


;S 菜单初始是否选中状态
If(fs_StartWork=1 && gs_StartWork=1)
{
	menu,TRAY,Check,StartWork(%FTstartwork_show%)
}
/* gs_PickColor 不适合为1
If(gs_PickColor=1)
{
	menu,TRAY,Check,PickColor(%FTpickcolor_show%)
}
*/
If(fs_BuildShortcut=1 && gs_BuildShortcut=1)
{
	menu,TRAY,Check,BuildShortcut(%FTbuildshortcut_show%)
}
If(fs_ImgDemo=1 && gs_ImgDemo=1)
{
	menu,TRAY,Check,ImgDemo(%FTimgdemo_show%)
}
If(fs_ImgCompress=1 && gs_ImgCompress=1)
{
	menu,TRAY,Check,ImgCompress(%FTimgcompress_show%)
}
If(fs_TimeStamp=1 && gs_TimeStamp=1)
{
	menu,TRAY,Check,TimeStamp(%FTtimestamp_show%)
}
If(fs_CopyPath=1 && gs_CopyPath=1)
{
	menu,TRAY,Check,CopyPath(%FTcopypath_show%)
}
If(fs_CopyName=1 && gs_CopyName=1)
{
	menu,TRAY,Check,CopyName(%FTcopyname_show%)
}
If(fs_QuickOpen=1 && gs_QuickOpen=1)
{
	menu,TRAY,Check,QuickOpen(%FTquickopen_show%)
}
If(fs_CopyURL=1 && gs_CopyURL=1)
{
	menu,TRAY,Check,CopyURL(%FTcopyurl_show%)
}
If(fs_QuickSearch=1 && gs_QuickSearch=1)
{
	menu,TRAY,Check,QuickSearch(%FTquicksearch_show%)
}
If(fs_AlwaysTop=1 && gs_AlwaysTop=1)
{
	menu,TRAY,Check,AlwaysTop(Mouse)
}
If(fs_Transparency=1 && gs_Transparency=1)
{
	menu,TRAY,Check,Transparency(Mouse)
}
If(fs_FTPupload=1 && gs_FTPupload=1)
{
	menu,TRAY,Check,FTPUpload(%FTPupload_show%)
}
If(fs_FTPDelete=1 && gs_FTPDelete=1)
{
	menu,TRAY,Check,FTPDelete(%FTPdelete_show%)
}
If(fs_FTPCompare=1 && gs_FTPCompare=1)
{
	menu,TRAY,Check,FTPCompare(%FTPcompare_show%)
}
If(fs_FTPTimeStamp_wg=1 && gs_FTPTimeStamp_wg=1)
{
	menu,TRAY,Check,FTPTimeStamp_wg(%FTPtimestamp_wg_show%)
}
;E 菜单初始是否选中状态
Gosub,CheckUpdate
Return
;E 程序初始化

;=======================================================================
;S 通用函数

;向配置文件写入当前功能开关状态
FuntionStateWriteInConfig(key,value)
{
	IniWrite,%value%, %A_ScriptDir%\Config.ini, FToolsGlobalState, %key%
	;MsgBox,%key%:%value%
}

;检测鼠标是否在窗口标题栏
MouseIsOverTitlebar(HeightOfTitlebar = 30)
{
        CoordMode,Mouse,Screen

        WinGetActiveStats,ActiveTitle,width,height,xPos,yPos
        MouseGetPos,x,y
        If ((x >= xPos) && (x <= xPos + width) && (y >= yPos) && (y <= yPos + HeightOfTitlebar))
                Return,%ActiveTitle%
        Else
                Return,false
}
;调节窗口透明度
ChangeTransparency(ActiveWinTitle,flag = "increase",amount = 2)
{
        static t = 255
        If (flag == "increase")
        {
                tmp := t + amount
        }
        Else If (flag == "decrease")
                tmp := t - amount
        If (tmp > 255)
                tmp = 255
        Else If (tmp < 0)
                tmp = 0
        WinSet,Transparent,%tmp%,%ActiveWinTitle%
        ;ToolTip,当前透明度:%tmp%
        ;Sleep,1000
        Tooltip

        t := tmp
        Return
}

;返回错误提示
Quit(Message="")
{
	if Message
		MsgBox, 16, Error!, %Message%, 5
	;ExitApp
}

;显示信息
Msg(Message="")
{
	MsgBox, 64, , %Message%, 5
	;ExitApp
	Return
}

;提示
TTip(Message="")
{
	ToolTip %Message%
}
;提示2
TrTip(Message="")
{
	TrayTip,FTools:,%Message%,1000
}

;E 通用函数


;任意位置呼出菜单
ShowMenu:
Menu,Tray,Show
Return

;Function Begin********************************************************************************************

;=======================================================================
;S StartWork 打开工作目录、程序
chk_StartWork:
If gs_StartWork=0
{
	menu,TRAY,Check,StartWork(%FTstartwork_show%)
	gs_StartWork=1
	FuntionStateWriteInConfig("gs_StartWork",1)
}
Else If gs_StartWork=1
{
	menu,TRAY,unCheck,StartWork(%FTstartwork_show%)
	gs_StartWork=0
	FuntionStateWriteInConfig("gs_StartWork",0)
}
Return

StartWork:
If gs_StartWork=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)
	Loop
	{
		FileReadLine,line,%A_ScriptDir%\StartLists.ini,%A_Index%
		FirstChar := SubStr(line, 1 ,1)
		If ErrorLevel
			Break

		If(FirstChar == ";")
		{
			;ToolTip, %line% 遇到注释行，跳过
			Continue
		}
		Run,%line%
		;MsgBox,%line%
		ToolTip,%line%已打开
		Sleep, 1000
	}
	ToolTip,
	MsgBox, 64, Success, 亲，目录（程序）已经打开，您可以开始工作啦~, 3
	menu,TRAY,unCheck,StartWork(%FTstartwork_show%)
	gs_StartWork=0
	Return

}
Else
 TrayTip,, 亲，尚未开启StartWork ,3000
Return
;E 打开工作目录、程序

;=======================================================================
;S PickColor 取色
PickColor:
If gs_PickColor=0
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)
	menu,TRAY,Check,PickColor(%FTpickcolor_show%)
	gs_PickColor=1
	;FuntionStateWriteInConfig("gs_PickColor",1)
	Loop
	{
	  GetKeyState,estate,ESC,p
	  If estate=D
	  {
	    ToolTip,
		gs_PickColor=0
		menu,TRAY,UnCheck,PickColor(%FTpickcolor_show%)
		Break
	  }
	  Sleep,100
	  MouseGetPos,x,y
	  PixelGetColor,rgb,x,y,RGB
	  StringTrimLeft,rgb,rgb,2
	  ToolTip,%rgb%`nPress F12 to copy
	  GetKeyState,state,F12,P
	  If state=D
		Clipboard=%rgb%

}

	Return
}
else if gs_PickColor=1
{
	menu,TRAY,UnCheck,PickColor(%FTpickcolor_show%)
	gs_PickColor=0
	;FuntionStateWriteInConfig("gs_PickColor",0)
}
Return
;E PickColor 取色

;=======================================================================
;S BuildShortcut 建立快捷方式
chk_BuildShortcut:
If gs_BuildShortcut=0
{
	menu,TRAY,Check,BuildShortcut(%FTbuildshortcut_show%)
	gs_BuildShortcut=1
	FuntionStateWriteInConfig("gs_BuildShortcut",1)
}
Else If gs_BuildShortcut=1
{
	menu,TRAY,unCheck,BuildShortcut(%FTbuildshortcut_show%)
	gs_BuildShortcut=0
	FuntionStateWriteInConfig("gs_BuildShortcut",0)
}
Return

BuildShortcut:
If gs_BuildShortcut=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)
	clipboard=
	send ^c
	ClipWait, 2
	if ErrorLevel
	{
		MsgBox, 亲，复制失败，再试一次吧~
		return
	}
	clipboard=%clipboard%
	ShortcutLinkPath:=clipboard
	InputBox,ShortcutLinkName,FTools BuildShortcut,亲，请输入快捷方式的名称：,,260, 140
	if ErrorLevel
	{
		Return
	}
	else
	{
		;MsgBox,%ShortcutLinkPath%`n%ShortcutPath%%ShortcutLinkName%.lnk
		FileCreateShortcut, %ShortcutLinkPath%, %ShortcutPath%\%ShortcutLinkName%.lnk
		;IfExist,%links%\%alias%.lnk
		TrayTip,FTools Tips,%ShortcutPath%\%ShortcutLinkName%.lnk 创建成功!,10
		Return
	}

}
Else
 TrayTip,, 亲，尚未开启BuildShortcut ,3000
Return
;E BuildShortcut 建立快捷方式

;=======================================================================
;S ImgDemo 生成demo图
chk_ImgDemo:
If gs_ImgDemo=0
{
	menu,TRAY,Check,ImgDemo(%FTimgdemo_show%)
	gs_ImgDemo=1
	FuntionStateWriteInConfig("gs_ImgDemo",1)
}
Else If gs_ImgDemo=1
{
	menu,TRAY,unCheck,ImgDemo(%FTimgdemo_show%)
	gs_ImgDemo=0
	FuntionStateWriteInConfig("gs_ImgDemo",0)
}
Return

ImgDemo:
If gs_ImgDemo=1
{
	Send ^c
	url:="http://ppms.paipaioa.com/php/imgDemo.php?size="
	url.=Clipboard
	imgSize:=Clipboard
	;MsgBox,%url%
	IfNotExist,C:\ImgDemoTemp
	{
		FileCreateDir,C:\ImgDemoTemp
	}
	URLDownloadToFile,%url%,C:\ImgDemoTemp\%Clipboard%.jpg
	;Sleep,6000
	FileDelete,C:\ImgDemoTemp\%Clipboard%.jpg
	url_new = http://ppms.paipaioa.com/img/demo/%Clipboard%.png
	url_new_img =`<img src`=`"http://ppms.paipaioa.com/img/demo/%Clipboard%.png`" `/ `>
	Clipboard:=url_new_img
	ClipWait,1000
	;MsgBox,%Clipboard%
	Send ^v
	FileRemoveDir,C:\ImgDemoTemp,1
	Clipboard:=url_new
	Sleep,2000
	Parameter = fname=%A_ThisLabel%&fcnt=%imgSize%
	SentToRecord("useRecord",Parameter)
	Return

}
Else
 TrayTip,, 亲，尚未开启ImgDemo ,3000
Return
;E ImgDemo 生成demo图


;=======================================================================
;S ImgCompress 图片压缩
chk_ImgCompress:
If gs_ImgCompress=0
{
	menu,TRAY,Check,ImgCompress(%FTimgcompress_show%)
	gs_ImgCompress=1
	FuntionStateWriteInConfig("gs_ImgCompress",1)
}
Else If gs_ImgCompress=1
{
	menu,TRAY,unCheck,ImgCompress(%FTimgcompress_show%)
	gs_ImgCompress=0
	FuntionStateWriteInConfig("gs_ImgCompress",0)
}
Return

ImgCompress:
If gs_ImgCompress=1
{

	Clipboard_old :=Clipboard
	Clipboard =
	Send ^c
	ClipWait,1000

	Gosub,SubImgCompress

	Parameter = fname=%A_ThisLabel%&fcnt=%FileName%[%FileSizeOld%/%FileSizeNew%/%CompressK%]
	SentToRecord("useRecord",Parameter)

	Return

}
Else
 TrayTip,, 亲，尚未开启ImgCompress ,3000
Return
;E ImgCompress 图片压缩


;=======================================================================
;S TimeStamp 打印时间戳
chk_TimeStamp:
If gs_TimeStamp=0
{
	menu,TRAY,Check,TimeStamp(%FTtimestamp_show%)
	gs_TimeStamp=1
	FuntionStateWriteInConfig("gs_TimeStamp",1)
}
Else If gs_TimeStamp=1
{
	menu,TRAY,unCheck,TimeStamp(%FTtimestamp_show%)
	gs_TimeStamp=0
	FuntionStateWriteInConfig("gs_TimeStamp",0)
}
Return

TimeStamp:
If gs_TimeStamp=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	Clipboardold:=Clipboard
	Clipboard=%A_Now%
	Send ^v
	Sleep,1000
	Clipboard:=Clipboardold
	Return
}
Else
 TrayTip,, 亲，尚未开启TimeStamp ,3000
Return
;E TimeStamp 打印时间戳

;=======================================================================
;S CopyPath拷贝路径

chk_CopyPath:
If gs_CopyPath=0
{
	menu,TRAY,Check,CopyPath(%FTcopypath_show%)
	gs_CopyPath=1
	FuntionStateWriteInConfig("gs_CopyPath",1)
}
Else If gs_CopyPath=1
{
	menu,TRAY,unCheck,CopyPath(%FTcopypath_show%)
	gs_CopyPath=0
	FuntionStateWriteInConfig("gs_CopyPath",0)
}
Return

CopyPath:
If gs_CopyPath=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	value:=chr(13)
	this_path:=
	clipold=%clipboard%
	clipboard=
	send ^c
	ClipWait, 0.5
	if ErrorLevel
	{
		clipboard=%clipold%
		return
	}
	StringSplit,Myarray,clipboard,%value%
	SplitPath,Myarray1,,this_path
	clipboard=%clipboard%
	;FileAppend,%clipboard%,%this_path%\filepath.txt
	;Run, %this_path%\filepath.txt
	TrayTip,CopyPath,文件路径列表（已拷贝至剪贴板）：`n%Clipboard%,3000

}
Else
 TrayTip,, 亲，尚未开启CopyPath ,3000
Return
;E CopyPath拷贝路径

;=======================================================================
;S CopyName 拷贝文件名

chk_CopyName:
If gs_CopyName=0
{
	menu,TRAY,Check,CopyName(%FTcopyname_show%)
	gs_CopyName=1
	FuntionStateWriteInConfig("gs_CopyName",1)
}
Else If gs_CopyName=1
{
	menu,TRAY,unCheck,CopyName(%FTcopyname_show%)
	gs_CopyName=0
	FuntionStateWriteInConfig("gs_CopyName",0)
}
Return

CopyName:
If gs_CopyName=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	value:=chr(13)
	a_blank:=
	this_path:=
	Send ^c
	clipwait
	StringSplit,Myarray,clipboard,%value%
	SplitPath,Myarray1,,this_path
	clipboard=
	loop,%Myarray0%
	{
	this_file:=Myarray%a_index%
	StringReplace,this_filename,this_file,%this_path%\,%a_blank%
	;FileAppend,%this_filename%,%this_path%\filename.txt
	clipboard.=this_filename
	}
	;Run, %this_path%\filename.txt
	TrayTip,CopyName,文件名列表（已拷贝至剪贴板）：`n%Clipboard%,3000
}
Else
 TrayTip,, 亲，尚未开启CopyName ,3000
Return
;E CopyName 拷贝文件名

;=======================================================================
;S CopyURL 拷贝文件URL地址

chk_CopyURL:
If gs_CopyURL=0
{
	menu,TRAY,Check,CopyURL(%FTcopyurl_show%)
	gs_CopyURL=1
	FuntionStateWriteInConfig("gs_CopyURL",1)
}
Else If gs_CopyURL=1
{
	menu,TRAY,unCheck,CopyURL(%FTcopyurl_show%)
	gs_CopyURL=0
	FuntionStateWriteInConfig("gs_CopyURL",0)
}
Return

CopyURL:
If gs_CopyURL=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	Gosub,GetFileLists

	Gosub,CheckPath

	Gosub,ReadFtpInfo

	Gosub,CopyURLaddress

	Return

}
Else
 TrayTip,, 亲，尚未开启CopyURL ,3000
Return
;E CopyURL 拷贝文件URL地址

;=======================================================================
;S 打开选中字符串

chk_QuickOpen:
If gs_QuickOpen=0
{
	menu,TRAY,Check,QuickOpen(%FTquickopen_show%)
	gs_QuickOpen=1
	FuntionStateWriteInConfig("gs_QuickOpen",1)
}
Else If gs_QuickOpen=1
{
	menu,TRAY,unCheck,QuickOpen(%FTquickopen_show%)
	gs_QuickOpen=0
	FuntionStateWriteInConfig("gs_QuickOpen",0)
}
Return

QuickOpen:
If gs_QuickOpen=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	clipold=%clipboard%
	clipboard=
	send ^c
	ClipWait, 0.5
	Run,%clipboard%
	ToolTip,已打开路径“%clipboard%”
	Sleep,2000
	ToolTip
}
Else
 TrayTip,, 亲，尚未开启QuickOpen ,3000
Return
;E 打开选中字符串

;=======================================================================
;S 搜索选中字符串

chk_QuickSearch:
If gs_QuickSearch=0
{
	menu,TRAY,Check,QuickSearch(%FTquicksearch_show%)
	gs_QuickSearch=1
	FuntionStateWriteInConfig("gs_QuickSearch",1)
}
Else If gs_QuickSearch=1
{
	menu,TRAY,unCheck,QuickSearch(%FTquicksearch_show%)
	gs_QuickSearch=0
	FuntionStateWriteInConfig("gs_QuickSearch",0)
}
Return

QuickSearch:
If gs_QuickSearch=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	send ^c
	ClipWait, 0.5
	;%FTquicksearch_url%.=%clipboard%
	;MsgBox,,,%FTquicksearch_url%
	If (FTquicksearch_url ="Baidu")
	{
		;MsgBox,,,Baidu
		Run,http://www.baidu.com/s?wd=%clipboard%
		Return
	}
	else If (FTquicksearch_url ="Google")
	{
		;MsgBox,,,Google
		Run,https://www.google.com/#hl=zh-CN&q=%clipboard%
		Return
	}
	Else
	{
		MsgBox,,FTools Tips,亲，请先在Setting中选择搜索引擎~
		Return
	}
}
Else
 TrayTip,, 亲，尚未开启QuickSearch ,3000
Return
;E 搜索选中字符串

;=======================================================================
;S AlwaysTop 窗口置顶
chk_AlwaysTop:
If gs_AlwaysTop=0
{
	menu,TRAY,Check,AlwaysTop(Mouse)
	gs_AlwaysTop=1
	FuntionStateWriteInConfig("gs_AlwaysTop",1)
}
Else If gs_AlwaysTop=1
{
	menu,TRAY,unCheck,AlwaysTop(Mouse)
	gs_AlwaysTop=0
	FuntionStateWriteInConfig("gs_AlwaysTop",0)
}
Return

AlwaysTop:
^MButton::
If gs_AlwaysTop=1
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	ActiveWinTitle := MouseIsOverTitlebar()
	If (ActiveWinTitle)
			WinSet,AlwaysOnTop,Toggle,%ActiveWinTitle%
	Else
			MouseClick,Middle
	Return
}
Else
 TrayTip,, 亲，尚未开启AlwaysTop ,3000
Return
;E AlwaysTop 窗口置顶

;=======================================================================
;S Transparency 窗口透明度调节
chk_Transparency:
If gs_Transparency=0
{
	menu,TRAY,Check,Transparency(Mouse)
	gs_Transparency=1
	FuntionStateWriteInConfig("gs_Transparency",1)
}
Else If gs_Transparency=1
{
	menu,TRAY,unCheck,Transparency(Mouse)
	gs_Transparency=0
	FuntionStateWriteInConfig("gs_Transparency",0)
}
Return

Transparency:
WheelDown::
If gs_Transparency=1
{
	ActiveWinTitle := MouseIsOverTitlebar()
	If (ActiveWinTitle)
	{
			ChangeTransparency(ActiveWinTitle,"decrease",50)
	}
	Else
			MouseClick,WD
	Return
}
Else
	MouseClick,WD
	;TrayTip,, 亲，尚未开启Transparency ,3000
Return

WheelUp::
If gs_Transparency=1
{
	ActiveWinTitle := MouseIsOverTitlebar()
	If (ActiveWinTitle)
	{
			ChangeTransparency(ActiveWinTitle,"increase",50)
	}
	Else
			MouseClick,WU
	Return
}
Else
	MouseClick,WU
	;TrayTip,, 亲，尚未开启Transparency ,3000
Return

;窗口微移
+!Up::
WinGetPos,, Y,,, A
WinMove, A,,, Y-1
Return
+!Down::
WinGetPos,, Y,,, A
WinMove, A,,, Y+1
Return
+!Left::
WinGetPos, X,,,, A
WinMove, A,,X-1
Return
+!Right::
WinGetPos, X,,,, A
WinMove, A,, X+1
Return

;E Transparency 窗口透明度调节

;=======================================================================
;S FTPupload 上传
chk_FTPupload:
If gs_FTPupload=0
{
	menu,TRAY,Check,FTPUpload(%FTPupload_show%)
	gs_FTPupload=1
	FuntionStateWriteInConfig("gs_FTPupload",1)
}
Else If gs_FTPupload=1
{
	menu,TRAY,unCheck,FTPUpload(%FTPupload_show%)
	gs_FTPupload=0
	FuntionStateWriteInConfig("gs_FTPupload",0)
}
Return

FTPupload:
If gs_FTPupload=1
{


	Gosub,GetFileListsAndImgCompress

	Gosub,CheckPath

	Gosub,ReadFtpInfo

	Gosub,UploadFile

	Parameter = fname=%A_ThisLabel%&fcnt=%Document%%File_name%[%Server%:%Port%]
	SentToRecord("useRecord",Parameter)

	Return
}
Else
 TrayTip,, 亲，尚未开启FTPupload ,3000
Return
;E FTPupload 上传

;=======================================================================
;S FTPDelete 删除
chk_FTPDelete:
If gs_FTPDelete=0
{
	menu,TRAY,Check,FTPDelete(%FTPdelete_show%)
	gs_FTPDelete=1
	FuntionStateWriteInConfig("gs_FTPDelete",1)
}
Else If gs_FTPDelete=1
{
	menu,TRAY,unCheck,FTPDelete(%FTPdelete_show%)
	gs_FTPDelete=0
	FuntionStateWriteInConfig("gs_FTPDelete",0)
}
Return

FTPDelete:
If gs_FTPDelete=1
{

	Gosub,GetFileLists

	Gosub,CheckPath

	Gosub,ReadFtpInfo

	Gosub,DeleteFile

	Parameter = fname=%A_ThisLabel%&fcnt=%Document%%File_name%[%Server%:%Port%]
	SentToRecord("useRecord",Parameter)

	Return
}
Else
 TrayTip,, 亲，尚未开启FTPDelete,3000
Return
;E FTPDelete 删除

;=======================================================================
;S FTPCompare 对比
chk_FTPCompare:
If gs_FTPCompare=0
{
	menu,TRAY,Check,FTPCompare(%FTPcompare_show%)
	gs_FTPCompare=1
	FuntionStateWriteInConfig("gs_FTPCompare",1)
}
Else If gs_FTPCompare=1
{
	menu,TRAY,unCheck,FTPCompare(%FTPcompare_show%)
	gs_FTPCompare=0
	FuntionStateWriteInConfig("gs_FTPCompare",0)
}
Return

FTPCompare:
If gs_FTPCompare=1
{

	Gosub,GetFileLists

	Gosub,CheckPath

	Gosub,ReadFtpInfo

	Gosub,CompareFile

	Parameter = fname=%A_ThisLabel%&fcnt=%Document%%File_name%[%Server%:%Port%]
	SentToRecord("useRecord",Parameter)

	Return
}
Else
 TrayTip,, 亲，尚未开启FTPCompare,3000
Return
;E FTPCompare 对比

;=======================================================================
;S FTPTimeStamp_wg 网购时间戳上传
chk_FTPTimeStamp_wg:
If gs_FTPTimeStamp_wg=0
{
	menu,TRAY,Check,FTPTimeStamp_wg(%FTPTimeStamp_wg_show%)
	gs_FTPTimeStamp_wg=1
	FuntionStateWriteInConfig("gs_FTPTimeStamp_wg",1)
}
Else If gs_FTPTimeStamp_wg=1
{
	menu,TRAY,unCheck,FTPTimeStamp_wg(%FTPTimeStamp_wg_show%)
	gs_FTPTimeStamp_wg=0
	FuntionStateWriteInConfig("gs_FTPTimeStamp_wg",0)
}
Return

FTPTimeStamp_wg:
If gs_FTPTimeStamp_wg=1
{

	Gosub,GetFileLists

	Gosub,CheckPath

	Gosub,ReadFtpInfo

	CSS_Compress_Url = http://ppms.paipaioa.com/php/wg_css_compress.php?cssPath=%Sub_Path%%File_Name%

	WebRequest := ComObjCreate("MSXML2.ServerXMLHTTP")

	WebRequest.Open("GET", CSS_Compress_Url)

	WebRequest.Send()

	updateFileLists := WebRequest.ResponseText

	StringReplace,updateFileLists,updateFileLists,<br>,`n,UseErrorLevel

	Clipboard := updateFileLists

	ClipWait,0.5

	TrayTip,FTools Tips,亲，以下文件列表已经复制到剪贴板：`n%updateFileLists% ,300

	Parameter = fname=%A_ThisLabel%&fcnt=%Sub_Path%%File_Name%
	SentToRecord("useRecord",Parameter)

	Return
}
Else
 TrayTip,, 亲，尚未开启FTPTimeStamp_wg,3000
Return
;E FTPTimeStamp_wg 网购时间戳上传

;=======================================================================
;S 更新
update:
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	;getVerUrl=http://w3c.im/FTools/version.php
	;getVerUrl:=http://w3c.im/FTools/version.php?VerCurrent=%VerCurrent%
	TrayTip,,正在获取最新版本号，请稍等片刻……
	URLDownloadToFile,%UpdateURL%version.php,version
	FileRead,VerLastest,version
	FileRead,UpdateDetailTitle,version
	FileRead,UpdateDetailContent,version

	Regular=(?<=<h1>)\S+(?=</h1>)
	RegExMatch(VerLastest,Regular,VerLastest)

	Regular2=(?<=<p class="UpdateDetailTitle">)\S+(?=</p>)
	RegExMatch(UpdateDetailTitle,Regular2,UpdateDetailTitle)

	Regular3=(?<=<p class="UpdateDetailContent">)\S+(?=</p>)
	RegExMatch(UpdateDetailContent,Regular3,UpdateDetailContent)

	StringReplace,UpdateDetailContent,UpdateDetailContent,<br>,`n,1

	If ( StrLen(VerLastest) <1  )
	{
		TrayTip,,
		MsgBox,0,未获取最新版本号,亲，当前无法获取最新版本号，请检查您的网络连接后重试。`n（Tips：很可能是被可恶的8000给墙了）
	}
	Else
	{
		If (VerCurrent < VerLastest)
		{
			TrayTip,,
			MsgBox,4,FTools有新版本啦,FTools有新版本啦，是否更新?`n【当前版本为：%VerCurrent%，最新版本为：%VerLastest%】`n`n%UpdateDetailTitle%`n%UpdateDetailContent%
			IfMsgBox Yes
			{
				Run,%A_ScriptDir%/update.exe
				Sleep,1000
				ExitApp
			}
			Else
			{
				MsgBox,0,取消更新,亲，最新版本有更多的功能哦~`n（您可通过点击托盘菜单“Update”来再次更新）

			}

		}
		Else If (VerCurrent >= VerLastest)
		{
			TrayTip,,
			MsgBox,0,当前已是最新版本,亲，当前已是最新版本，暂无需更新！
		}
	}
	FileDelete,version
}

;MsgBox,Whatever go on~
Return
;E 更新

;=======================================================================
;S 打开时检测更新
CheckUpdate:
{

	;getVerUrl=http://w3c.im/FTools/version.php
	;getVerUrl:=http://w3c.im/FTools/version.php?VerCurrent=%VerCurrent%
	URLDownloadToFile,%UpdateURL%version.php,version
	FileRead,VerLastest,version
	FileRead,UpdateDetailTitle,version
	FileRead,UpdateDetailContent,version

	Regular=(?<=<h1>)\S+(?=</h1>)
	RegExMatch(VerLastest,Regular,VerLastest)

	Regular2=(?<=<p class="UpdateDetailTitle">)\S+(?=</p>)
	RegExMatch(UpdateDetailTitle,Regular2,UpdateDetailTitle)

	Regular3=(?<=<p class="UpdateDetailContent">)\S+(?=</p>)
	RegExMatch(UpdateDetailContent,Regular3,UpdateDetailContent)

	StringReplace,UpdateDetailContent,UpdateDetailContent,<br>,`n,1

	If ( StrLen(VerLastest) <1  )
	{
		;TrayTip,,
		;MsgBox,0,未获取最新版本号,亲，当前无法获取最新版本号，请检查您的网络连接后重试。`n（Tips：很可能是被可恶的8000给墙了）
	}
	Else
	{
		If (VerCurrent < VerLastest)
		{
			TrayTip,,
			MsgBox,4,FTools有新版本啦,FTools有新版本啦，是否更新?`n【当前版本为：%VerCurrent%，最新版本为：%VerLastest%】`n`n%UpdateDetailTitle%`n%UpdateDetailContent%
			IfMsgBox Yes
			{
				Run,%A_ScriptDir%/update.exe
				Sleep,1000
				ExitApp
			}
			Else
			{
				MsgBox,0,取消更新,亲，最新版本有更多的功能哦~`n（您可通过点击托盘菜单“更新”来再次更新）

			}

		}
		Else If (VerCurrent >= VerLastest)
		{
			;TrayTip,,
			;MsgBox,0,当前已是最新版本,亲，当前已是最新版本，暂无需更新！
		}
	}
	FileDelete,version
	Return
}
;E 打开时检测更新



;=======================================================================
;关于
About:
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	Run,http://yevolcn.github.com/FTools/
Return

;=======================================================================
;设置
Setting:
{
	Parameter = fname=%A_ThisLabel%
	SentToRecord("useRecord",Parameter)

	Gui, Font, S12 CDefault bold, Verdana
	Gui, Add, Text, x10 y15 w630 h26 +Center, FTools Setting
	Gui, Font, S9 CDefault Normal, Verdana

	Gui, Add, CheckBox,vfs_StartWork x22 y50 w110 h30 +left, StartWork
	Gui, Add, Hotkey, x142 y50 w140 h30 vFTstartwork,
	Gui, Add, CheckBox,vfs_PickColor x302 y50 w110 h30 +left, PickColor
	Gui, Add, Hotkey, x422 y50 w140 h30 vFTpickcolor,
	Gui, Add, CheckBox,vfs_ImgDemo x22 y90 w110 h30 +left, ImgDemo
	Gui, Add, Hotkey, x142 y90 w140 h30 vFTimgdemo,
	Gui, Add, CheckBox,vfs_TimeStamp x302 y90 w110 h30 +left, TimeStamp
	Gui, Add, Hotkey, x422 y90 w140 h30 vFTtimestamp,
	Gui, Add, CheckBox,vfs_CopyPath x22 y130 w110 h30 +left, CopyPath
	Gui, Add, Hotkey, x142 y130 w140 h30 vFTcopypath,
	Gui, Add, CheckBox,vfs_CopyName x302 y130 w110 h30 +left, CopyName
	Gui, Add, Hotkey, x422 y130 w140 h30 vFTcopyname,
	Gui, Add, CheckBox,vfs_CopyURL x22 y170 w110 h30 +left, CopyURL
	Gui, Add, Hotkey, x142 y170 w140 h30 vFTcopyurl,
	Gui, Add, CheckBox,vfs_QuickOpen x302 y170 w110 h30 +left, QuickOpen
	Gui, Add, Hotkey, x422 y170 w140 h30 vFTquickopen,
	Gui, Add, CheckBox,vfs_QuickSearch x22 y210 w110 h30 +left, QuickSearch
	Gui, Add, Hotkey, x142 y210 w140 h30 vFTquicksearch,
	Gui, Add, Text, x320 y215 w120 h30 +left, QuickSearchUrl
	Gui, Add, DropDownList, x422 y210 w140 h120 vFTquicksearch_url Choose2, Baidu|Google
	Gui, Add, CheckBox,vfs_FTPupload x22 y250 w110 h30 +left, FTPupload
	Gui, Add, Hotkey, x142 y250 w140 h30 vFTPupload,
	Gui, Add, CheckBox,vfs_FTPdelete x302 y250 w110 h30 +left, FTPdelete
	Gui, Add, Hotkey, x422 y250 w140 h30 vFTPdelete,
	Gui, Add, CheckBox,vfs_FTPcompare x22 y290 w110 h30 +left, FTPcompare
	Gui, Add, Hotkey, x142 y290 w140 h30 vFTPcompare,
	Gui, Add, Text, x40 y335 w120 h30 +left, BComparePath
	Gui, Add, Edit, x142 y330 w420 h30 vBComparePath +BackgroundTrans,
	Gui, Add, CheckBox,vfs_FTPtimestamp_wg x22 y370 w110 h30 +left, FTPtimestamp
	Gui, Add, Hotkey, x142 y370 w140 h30 vFTPtimestamp_wg,
	Gui, Add, CheckBox,vfs_ImgCompress x22 y410 w110 h30 +left, ImgCompress
	Gui, Add, Hotkey, x142 y410 w140 h30 vFTimgcompress,

	Gui, Add, CheckBox,vfs_BuildShortcut x22 y450 w110 h30 +left, BuildShortcut
	Gui, Add, Hotkey, x142 y450 w140 h30 vFTbuildshortcut,
	Gui, Add, Text, x40 y495 w120 h30 +left, ShortcutPath
	Gui, Add, Edit, x142 y495 w420 h30 vShortcutPath +BackgroundTrans,
	;Gui, Add, Text,x302 y415 w50 h30 +left, Quality
	;Gui, Add, Edit, x352 y410 w50 h30 +Number +VScroll +Vertical vImgCompressQuality,
	;Gui, Add, Text, x402 y415 w50 h30,`%
	Gui, Add, Button, x142 y550 w80 h30 , OK
	Gui, Add, Button, x262 y550 w80 h30 , Cancle
	; 设置功能开关状态
	GuiControl, , fs_StartWork , %fs_StartWork%
	GuiControl, , fs_PickColor , %fs_PickColor%
	GuiControl, , fs_BuildShortcut , %fs_BuildShortcut%
	GuiControl, , fs_ImgDemo , %fs_ImgDemo%
	GuiControl, , fs_ImgCompress , %fs_ImgCompress%
	GuiControl, , ImgCompressQuality , %ImgCompressQuality%
	GuiControl, , fs_TimeStamp , %fs_TimeStamp%
	GuiControl, , fs_CopyPath , %fs_CopyPath%
	GuiControl, , fs_CopyName , %fs_CopyName%
	GuiControl, , fs_CopyURL , %fs_CopyURL%
	GuiControl, , fs_QuickOpen , %fs_QuickOpen%
	GuiControl, , fs_QuickSearch , %fs_QuickSearch%
	GuiControl, , fs_FTPupload , %fs_FTPupload%
	GuiControl, , fs_FTPdelete , %fs_FTPdelete%
	GuiControl, , fs_FTPcompare , %fs_FTPcompare%
	GuiControl, , fs_FTPtimestamp_wg , %fs_FTPtimestamp_wg%
	; 设置快捷键
	GuiControl, , FTstartwork, %FTstartwork%
	GuiControl, , FTpickcolor, %FTpickcolor%
	GuiControl, , FTbuildshortcut, %FTbuildshortcut%
	GuiControl, , FTimgdemo, %FTimgdemo%
	GuiControl, , FTimgcompress, %FTimgcompress%
	GuiControl, , FTtimestamp, %FTtimestamp%
	GuiControl, , FTcopypath, %FTcopypath%
	GuiControl, , FTcopyname, %FTcopyname%
	GuiControl, , FTcopyurl, %FTcopyurl%
	GuiControl, , FTquickopen, %FTquickopen%
	GuiControl, , FTquicksearch, %FTquicksearch%
	;GuiControl, , FTquicksearch_url, %FTquicksearch_url%
	GuiControl, , FTPupload, %FTPupload%
	GuiControl, , FTPdelete, %FTPdelete%
	GuiControl, , FTPcompare, %FTPcompare%
	GuiControl, , FTPtimestamp_wg, %FTPtimestamp_wg%
	GuiControl, , BComparePath, %BComparePath%
	GuiControl, , ShortcutPath, %ShortcutPath%
	SettingForm_x:=Round((A_ScreenWidth-630)/2)
	;MsgBox,%SettingForm_x%
	Gui, Show, x%SettingForm_x% y260 h600 w630, FTools 快捷键设置
	Return
}
Return

ButtonOK:
{
	Gui, Submit, NoHide
	;获取checkbox中功能状态，并写入
	GuiControlGet, fs_StartWork
	GuiControlGet, fs_PickColor
	GuiControlGet, fs_BuildShortcut
	GuiControlGet, fs_ImgDemo
	GuiControlGet, fs_ImgCompress
	GuiControlGet, fs_TimeStamp
	GuiControlGet, fs_CopyPath
	GuiControlGet, fs_CopyName
	GuiControlGet, fs_CopyURL
	GuiControlGet, fs_QuickOpen
	GuiControlGet, fs_QuickSearch
	GuiControlGet, fs_FTPupload
	GuiControlGet, fs_FTPdelete
	GuiControlGet, fs_FTPcompare
	GuiControlGet, fs_FTPtimestamp_wg
	;写入配置信息
	IniWrite, %ImgCompressQuality%, %A_ScriptDir%\Config.ini, FToolsSetting, ImgCompressQuality
	;写入功能开关
	IniWrite, %fs_StartWork%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_StartWork
	IniWrite, %fs_PickColor%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_PickColor
	IniWrite, %fs_BuildShortcut%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_BuildShortcut
	IniWrite, %fs_ImgDemo%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_ImgDemo
	IniWrite, %fs_ImgCompress%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_ImgCompress
	IniWrite, %fs_TimeStamp%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_TimeStamp
	IniWrite, %fs_CopyPath%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyPath
	IniWrite, %fs_CopyName%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyName
	IniWrite, %fs_CopyURL%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_CopyURL
	IniWrite, %fs_QuickOpen%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_QuickOpen
	IniWrite, %fs_QuickSearch%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_QuickSearch
	IniWrite, %fs_FTPupload%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPupload
	IniWrite, %fs_FTPdelete%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPdelete
	IniWrite, %fs_FTPcompare%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPcompare
	IniWrite, %fs_FTPtimestamp_wg%, %A_ScriptDir%\Config.ini, FToolsFunctionState, fs_FTPtimestamp_wg
	;写入快捷键
	IniWrite, %FTstartwork%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTstartwork
	IniWrite, %FTpickcolor%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTpickcolor
	IniWrite, %FTbuildshortcut%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTbuildshortcut
	IniWrite, %FTimgdemo%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTimgdemo
	IniWrite, %FTimgcompress%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTimgcompress
	IniWrite, %FTtimestamp%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTtimestamp
	IniWrite, %FTcopypath%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopypath
	IniWrite, %FTcopyname%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopyname
	IniWrite, %FTcopyurl%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTcopyurl
	IniWrite, %FTquickopen%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquickopen
	IniWrite, %FTquicksearch%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquicksearch
	IniWrite, %FTquicksearch_url%, %A_ScriptDir%\Config.ini, FToolsKeyInfo, FTquicksearch_url
	IniWrite, %FTPupload%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPupload
	IniWrite, %FTPdelete%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPdelete
	IniWrite, %FTPcompare%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPcompare
	IniWrite, %FTPtimestamp_wg%, %A_ScriptDir%\Config.ini, FToolsFtpKeyInfo, FTPtimestamp_wg
	IniWrite, %BComparePath%, %A_ScriptDir%\Config.ini, FToolsExtraConfig, BComparePath
	IniWrite, %ShortcutPath%, %A_ScriptDir%\Config.ini, FToolsExtraConfig, ShortcutPath
	Gui, Destroy
	TrayTip,FTools Setting,工具2秒内将自动重启，已更新快捷键配置。
	Sleep,2000
	Reload
Return
}

ButtonCancle:
GuiClose:
	Gui, Destroy
Return

;=======================================================================
;重启
TrayReload:
f9::
	Reload
Return


;=======================================================================
;~ ;退出
TrayExit:
	Exitapp
Return

;=======================================================================
;复制文件url地址
CopyURLaddress:
{
	Clipboard =
	loop,%File_Address0%
    {
        File_Address:=File_Address%a_index%
        ;MsgBox,第%a_index%个文件：%File_Address%
        SplitPath,File_Address,File_name
		Clipboard.=Url
        Clipboard.=Sub_Path
		Clipboard.=File_name
		Clipboard.="`n"
    }
	TrayTip,CopyURL,文件列表（已拷贝至剪贴板）：`n%Clipboard%,3000

	;MsgBox,已拷贝URL地址至剪贴板

	Return

}


;=======================================================================
;上传文件子程序
UploadFile:
{
    ;上传
    ftp1 := new FTP()
    ftp1 ? TTip("成功连接！") : Quit("无法打开连接！")

    ftp1.Open(Server, Port, UserName, Password) ? TTip("成功连接到FTP！") : Quit(ftp1.LastError)

    sOrgPath := ftp1.GetCurrentDirectory()
    sOrgPath ? TTip("获得上传目录 : " sOrgPath) : Msg(ftp1.LastError)

    ftp1.SetCurrentDirectory(Document) ? TTip("设置目录为"Document) : Msg(ftp1.LastError)

    ;MsgBox,服务器：%Server%`n用户名：%UserName%`n密码：%Password%`n目录：%Document%

	Clipboard=
    loop,%File_Address0%
    {
        File_Address:=File_Address%a_index%
        ;MsgBox,第%a_index%个文件：%File_Address%
        SplitPath,File_Address,File_name
		Clipboard.=Url
        Clipboard.=Sub_Path
		Clipboard.=File_name
		Clipboard.="`n"
        ftp1.PutFile(File_Address,File_name,0) ? TrTip("文件上传成功！`n文件路径已复制到剪贴板！") : Msg(ftp1.LastError)

    }


    ;ftp1.PutFile(File_Address1) ? Msg("文件上传成功！") : Msg(ftp1.LastError)

    ftp1 := ""
    ToolTip,
    ;MsgBox, 64, Success, 妹的，终于完了, 3
    Return
    ;上传


}


;=======================================================================
;文件比较子程序
CompareFile:
{
    ;文本比较
    ftp1 := new FTP()
    ftp1 ? TTip("成功连接！") : Quit("无法打开连接！")

    ftp1.Open(Server, Port, UserName, Password) ? TTip("成功连接到FTP！") : Quit(ftp1.LastError)

    sOrgPath := ftp1.GetCurrentDirectory()
    sOrgPath ? TTip("获得上传目录 : " sOrgPath) : Msg(ftp1.LastError)

    ftp1.SetCurrentDirectory(Document) ? TTip("设置目录为"Document) : Msg(ftp1.LastError)

    SplitPath,File_Address1,File_name ;取出文件名

    ;MsgBox,当前目录：%Document%`n当前文件地址：%File_Address1%`n文件名：%File_name%

    RemoteFile=%Document%%File_name% ;设置远程文件地址

    LocalFile=%File_Address1% ;设置本地文件地址

    LocalFile_remote=%File_Address1%_remote ;设置下载到的本地临时文件地址

    IfExist,%LocalFile_remote%
    {
        ;MsgBox,检测到存在文件%LocalFile_remote%，开始删除
        FileDelete,%LocalFile_remote%
    }

    ;MsgBox,远程地址：%RemoteFile%`n本地地址：%LocalFile_remote%

    ftp1.GetFile(RemoteFile, LocalFile_remote,1)?TTip("下载成功"File_name) : Msg(ftp1.LastError)

    ftp1 := ""
    ToolTip,

    ;MsgBox,开始比较

    RunWait,%BComparePath% %LocalFile_remote% %LocalFile%

	Sleep,300

	FileDelete,%LocalFile_remote%

    Return
    ;文本比较


}


;=======================================================================
;文件删除子程序
DeleteFile:
{
    ;删除文件
    ftp1 := new FTP()
    ftp1 ? TTip("成功连接！") : Quit("无法打开连接！")

    ftp1.Open(Server, Port, UserName, Password) ? TTip("成功连接到FTP！") : Quit(ftp1.LastError)

    sOrgPath := ftp1.GetCurrentDirectory()
    sOrgPath ? TTip("获得上传目录 : " sOrgPath) : Msg(ftp1.LastError)

    ftp1.SetCurrentDirectory(Document) ? TTip("设置目录为"Document) : Msg(ftp1.LastError)

    SplitPath,File_Address1,File_name ;取出文件名

    ;MsgBox,当前目录：%Document%`n当前文件地址：%File_Address1%`n文件名：%File_name%

    RemoteFile=%Document%%File_name% ;设置远程文件地址

    LocalFile=%File_Address1% ;设置本地文件地址

    ;MsgBox,远程地址：%RemoteFile%`n本地地址：%LocalFile%

    ftp1.Deletefile(RemoteFile) ? TTip("远程删除成功") : Msg(ftp1.LastError)

    ftp1 := ""
    ToolTip,

    FileDelete,%LocalFile% ;删除本地文件

	MsgBox,,FTPdelete,文件%File_name%已从本地和FTP删除。

    Return
    ;删除文件

}



;=======================================================================
;获取操作文件列表
GetFileLists:
{
    value:=chr(13)
    clipold=%clipboard%
    Clipboard =
    Send,^c
    ClipWait, 0.5
    if ErrorLevel
    {
        clipboard=%clipold%
        return
    }

    StringSplit,File_Address,clipboard,%value%

    SplitPath,File_Address1,File_Name,File_Path ;获取文件完整路径File_Path(不包含文件名)

    global File_Path

    ;MsgBox,一共有%File_Address0%个文件开始上传

    Return
}

;=======================================================================
;获取配置文件路径
CheckPath:
{
	Sub_Path =

	Sub_Path_Temp =

    StringSplit, File_Path_All, File_Path,`\ ;以\为分隔符，拆分路径File_Path，为了获取子目录的层级

    File_Path=%File_Path%\

    Path_length:=StrLen(File_Path)

	LastLength := 0

	LastLength_all := 0

    IfExist,%File_Path%Ftp_Info.ini

    {
        ;MsgBox,在第(0)层找到配置文件找到配置文件：%File_Path%Ftp_Info.ini

        File_Path_Final:=File_Path

        Return
    }

	Loop,%File_Path_All0% ;这里设置最大循环路径为子字符串条数
	{

		LastCounter:=(File_Path_All0-a_index+1) ;设置计数器，获取倒数a_index子字符串

		StringLen, LastLength, File_Path_All%LastCounter% ;获取倒数a_index子字符串长度

		LastLength_all+=LastLength + 1

		StringTrimRight,File_Path_Result,File_Path,%LastLength_all% ;从路径中移除倒数a_index长度的字符串，获得File_Path_Result

		IfExist,%File_Path_Result%Ftp_Info.ini ;如果存在配置文件
		{
			StringMid, Sub_Path_Temp, File_Path, %Path_Length%, %LastLength_all%, L ;获取剔除掉的子字符串Sub_Path_Temp

			Loop,1
			{
				StringReplace,Sub_Path,Sub_Path_Temp,`\,`/,UseErrorLevel ;将Sub_Path_Temp中的\替换为/
				 if ErrorLevel = 0  ; 不需要再进行替换。
					break
			}

			File_Path_Final:=File_Path_Result

			;MsgBox,配置文件地址: %File_Path_Final%Ftp_Info.ini`n子路径: %Sub_Path%

			Break

		}

	}

	IfNotExist,%File_Path_Result%Ftp_Info.ini
	{
		MsgBox,FTools Tips,亲，实在找不到配置文件了，你确定配置了么？
		MsgBox,%File_Path_Result%
	}


    Return
}




;=======================================================================
;读取配置文件信息
ReadFtpInfo:
{
    ;MsgBox,开始读取文件配置
    IniRead, f_server, %File_Path_Final%Ftp_Info.ini, FTP_Info, Server
	IniRead, f_port, %File_Path_Final%Ftp_Info.ini, FTP_Info, Port
    IniRead, f_username, %File_Path_Final%Ftp_Info.ini, FTP_Info, UserName
    IniRead, f_password, %File_Path_Final%Ftp_Info.ini, FTP_Info, Password
    IniRead, f_document, %File_Path_Final%Ftp_Info.ini, FTP_Info, Document
	IniRead, f_urladress, %File_Path_Final%Ftp_Info.ini, FTP_Info, Url

    Server:=f_server
	Port:=f_port
    UserName:=f_username
    Password:=f_password
    Document:=f_document
    Document.=Sub_Path
	URL:=f_urladress

    ;MsgBox,地址：%Server%`n端口：%Port%`n用户名：%UserName%`n密码：%Password%`n目录：%Document%`nURL：%URL%
    Return
}

;=======================================================================
;获取操作文件列表并压缩图片
GetFileListsAndImgCompress:
{
    value:=chr(13)
    clipold=%clipboard%
    Clipboard =
    Send,^c
    ClipWait, 0.5
    if ErrorLevel
    {
        clipboard=%clipold%
        return
    }

	File_Address =

    StringSplit,File_Address,clipboard,%value%

    SplitPath,File_Address1,File_Name,File_Path ;获取文件完整路径File_Path(不包含文件名)

	StringSplit,FileNameSplit,File_Name,`. ;取出文件名FileNameSplit1（不含后缀），后缀名FileNameSplit2

    global File_Path

	If ( fs_ImgCompress==1 && gs_ImgCompress==1 )
	{
		if(FileNameSplit2 == "jpg" || FileNameSplit2 == "png")
		{
			;MsgBox,开始压缩图片
			Gosub,SubImgCompress
			Sleep,2000
		}
	}

    ;MsgBox,一共有%File_Address0%个文件开始上传

    Return
}


;=======================================================================
;图片压缩
SubImgCompress:
{
	SplitPath,clipboard,FileName,FileDocument ;取出文件名、目录
	FileFullPath=%FileDocument%\%FileName%
	StringSplit,FileNameSplit,FileName,`. ;取出文件名FileNameSplit1（不含后缀），后缀名FileNameSplit2
	FileGetSize,FileSizeOld,%FileFullPath%,K

	If (FileNameSplit2 == "jpg")
	{
		JpgExecutePath = %A_ScriptDir%\resource\jpg.exe -optimize -perfect %FileFullPath% %FileFullPath%
		;MsgBox,%JpgExecutePath%
		RunWait , %JpgExecutePath% , ,hide
		FileGetSize,FileSizeNew,%FileFullPath%,K
		CompressK:=Round((FileSizeOld-FileSizeNew)/FileSizeOld*100)
		TrayTip,FTools ImgCompress,亲，本次压缩减小了%CompressK%`%的体积`n当前图片大小约为：%FileSizeNew%Kb,2000

	}
	Else If (FileNameSplit2 == "png")
	{
		PngExecutePath = %A_ScriptDir%\resource\png.exe -file:`"%FileFullPath%`"
		;MsgBox,%PngExecutePath%
		RunWait , %PngExecutePath% ,, hide
		FileGetSize,FileSizeNew,%FileFullPath%,K
		CompressK:=Round((FileSizeOld-FileSizeNew)/FileSizeOld*100)
		TrayTip,FTools ImgCompress,亲，本次压缩减小了%CompressK%`%的体积`n当前图片大小约为：%FileSizeNew%Kb,2000
	}
	Else
	{
		;TrayTip,FTools ImgCompress,亲，只有JPG 或 PNG 文件可以压缩哦~!,2000
		;MsgBox,%Clipboard%
		Clipboard := Clipboard_old
	}
	Return
}


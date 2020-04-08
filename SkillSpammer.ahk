#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance


if (!JEE_AhkIsAdmin())	{
	MsgBox, You need to run as Admin!
	ExitApp
}

Gui, Add, GroupBox, x11 y2 w370 h50 , Add Click

Gui, Add, CheckBox, x21 y22 w38 h24 vF1ClickStatus gSubmitClickStatus, F1
Gui, Add, CheckBox, x61 y22 w38 h24 vF2ClickStatus gSubmitClickStatus, F2
Gui, Add, CheckBox, x101 y22 w38 h24 vF3ClickStatus gSubmitClickStatus, F3
Gui, Add, CheckBox, x141 y22 w38 h24 vF4ClickStatus gSubmitClickStatus, F4
Gui, Add, CheckBox, x181 y22 w38 h24 vF5ClickStatus gSubmitClickStatus, F5
Gui, Add, CheckBox, x221 y22 w38 h24 vF6ClickStatus gSubmitClickStatus, F6
Gui, Add, CheckBox, x261 y22 w38 h24 vF7ClickStatus gSubmitClickStatus, F7
Gui, Add, CheckBox, x301 y22 w38 h24 vF8ClickStatus gSubmitClickStatus, F8
Gui, Add, CheckBox, x341 y22 w38 h24 vF9ClickStatus gSubmitClickStatus, F9
; Generated using SmartGUI Creator 4.0
Gui, Show, x404 y316 h67 w393, Ragnarok Skill Spammer

Gui, Add, Link, x341 y52 w40 h20 , <a href="https://github.com/Enkimaru/RagnarokSkillSpammer">v1.02</a>

Gui, Submit, NoHide
gosub, updateFKeys

Menu, Tray, Add, Restore, Restore
Menu, Tray, default, Restore
Menu, Tray, Click, 2
return

SubmitClickStatus:
	Gui, Submit, NoHide
	gosub, updateFKeys
return

updateFKeys:
{
	i := 1
	Loop, 9 {
		hotkey, f%i%, spam
		i := i + 1
	}	
}
return

spam:
{
	#If WinActive("ahk_class Ragnarok")
		while getkeystate(a_thishotkey, "p") {
				ControlSend, ahk_parent, {%a_thishotkey%}, ahk_class Ragnarok
				if (%a_thishotkey%ClickStatus == true)
					ControlClick,, ahk_class Ragnarok
				Sleep, 10
		}
}
return
	
;==================================================

JEE_AhkIsAdmin()
{
	;see AHK source code: os_version.h
	;see also:
	;Operating System Version (Windows)
	;https://msdn.microsoft.com/en-gb/library/windows/desktop/ms724832(v=vs.85).aspx
	;Using the Windows Headers (Windows)
	;https://msdn.microsoft.com/en-us/library/windows/desktop/aa383745(v=vs.85).aspx
	vVersion := DllCall("kernel32\GetVersion", "UInt")
	if (vVersion & 0xFF < 5)
		return 1

	;SC_MANAGER_LOCK := 0x8
	hSC := DllCall("advapi32\OpenSCManager", "Ptr",0, "Ptr",0, "UInt",0x8, "Ptr")
	vRet := 0
	if hSC
	{
		if (vLock := DllCall("advapi32\LockServiceDatabase", "Ptr",hSC, "Ptr"))
		{
			DllCall("advapi32\UnlockServiceDatabase", "Ptr",vLock)
			vRet := 1
		}
		else
		{
			vLastError := DllCall("kernel32\GetLastError", "UInt")
			;ERROR_SERVICE_DATABASE_LOCKED := 1055
			if (vLastError = 1055)
				vRet := 1
		}
		DllCall("advapi32\CloseServiceHandle", "Ptr",hSC)
	}
	return vRet
}
;==============================

GuiSize:
  if (A_EventInfo = 1)
    WinHide
  return

Restore:
  gui +lastfound
  WinShow
  WinRestore
  return

GuiClose:
	ExitApp
#Include lib\Constants.ahk
#Include Lib\Lists.ahk
#Include Lib\Main_Tool.ahk


Menu, Tray, Add, Load AC File, LoadAcFileLabel
Menu, Tray, Add, Exit, ExitAll
Menu, Tray, NoStandard

BuildTool()
Return


LoadAcFileLabel:
	Selected_List := GetList()
	LoadList(Selected_List)
	Selected_List = 
	return

ExitAll:
	ExitApp
	Return

;--------------------------------------------------------------------------------- Hot Keys

;Main Win show hotkey (Alt + Accent) Press again while tool is shown to deactivate tool. escape or the tool loosing focus will also deactivate & hide
!`::			
	ShowTool()
	return

;Dev Keys
!r::
	Reload
	Return
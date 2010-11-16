;Functions For Building the Listview

BuildTool() {
	global AutoListbox, ListWidth, ListHeight
	
	Gui, -Caption +AlwaysOnTop +ToolWindow +LastFoundExist
	ToolWindowHwnd := WinExist() ;getting Hwnd of tool window to use below for context sensitive hotkeys
	gui, Add, Listview, x0 y0 w%ListWidth% h%ListHeight% vAutoListbox gEnter_Catch backgroundC0C0C0 , Entry|Description
	ToolShown = 0
	Hotkey, IfWinActive, AHK_ID%ToolWindowHwnd%
	Hotkey, Enter, Enter_Catch, ON
	Hotkey, NumPadEnter, Enter_Catch, ON
	Return
	
	
	Enter_Catch:
		SendText := GetSelected()
		HideTool()
		SendEntry(SendText)
		return
		
	
	GuiEscape:
		HideTool()
		Return
}

ShowTool() {
	Global ActiveHwnd, ToolShown, ListWidth, ListHeight
	
	If ToolShown
	{
		HideTool()
		return
	}
	WinGet, ActiveHwnd, ID, A
	;~ If (A_CaretX = 0 || A_CaretY = 0 || A_CaretX = "" || A_CaretY = "")
		;~ return
	WinGetPos, X, Y, Width, Height, AHK_ID %ActiveHwnd%
	LowerLeftX := X + Width - ListWidth - 10
	LowerLeftY := Y + Height - ListHeight - 10
	Gui, Show, w%ListWidth% h%ListHeight% x%LowerLeftX% y%LowerLeftY%
	OnMessage(0x0006, "WM_ACTIVATE") ;Monitoring If the tool has lost active status
	ToolShown = 1
	
	/* Positioning Formulas relative to the active window
	
	Upper Right Corner
		LowerLeftX := X + Width - ListWidth - 10
		LowerLeftY := Y + 10
		
	Upper Left Corner
		LowerLeftX := X + 10
		LowerLeftY := Y + 10
		
	Lower Left Corner
		LowerLeftX := X + 10
		LowerLeftY := Y + Height - ListHeight - 10
		
	Lower Right Corner
		LowerLeftX := X + Width - ListWidth - 10
		LowerLeftY := Y + Height - ListHeight - 10
	*/

	Return
}

HideTool() {
	global ToolShown
	
	Gui, Hide
	OnMessage(0x0006, "")
	ToolShown = 0
}

WM_ACTIVATE(wParam) {
	
	If wParam
		Return
	else
	{
		HideTool()
		return
	}
}

GetSelected() {
	Global AutoListbox
	
	Gui, Default
	LV_GetText(Selected_Text, LV_GetNext(0, "Focused"))
	Return Selected_Text
}

SendEntry(Text) {
	global ActiveHwnd
	
	WinActivate, ahk_id %ActiveHwnd%
	WinWaitActive, ahk_id %ActiveHwnd%, , 2
		If ErrorLevel
		{
			MsgBox Trouble Activating the Window!
			return
		}
	SendInput, %Text%
}

;functions for building the lists

LoadList(File_List) {
	Global AutoListbox, StringDelimiter
	
	Gui, Default
	LV_Delete()
	Loop
	{
		IniRead, ReadLine, %File_List%, Entry_List, %A_Index%
			If (ReadLine = "ERROR" || ReadLine = "")
				break
		StringReplace, ReadLine, ReadLine, %StringDelimiter%, %A_Tab%
		StringSplit, Out_, ReadLine, %A_Tab%
		LV_Add("", Out_1, Out_2)
	}
	LV_ModifyCol()
}

GetList() {
	
	FileSelectFile, Selected_List
	Return Selected_List
}

AddToList(ListPath, Entry, Description) {
	global StringDelimiter
	
	Loop
	{
		IniRead, ReadKeyNumber, %ListPath%, Entry_List, %A_Index%
			If (ReadKeyNumber = "ERROR" || ReadKeyNumber = "")
			{
				FinalLineNumber := A_Index
				break
			}
	}
	IniWrite, % Entry . StringDelimiter . Description, %ListPath%, Entry_List, %FinalLineNumber%
}
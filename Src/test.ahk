
#Include initools.ahk
;获取常用的目录列表
Show_RecentDir(Current_Pair)
{
	Gui Font, s12 Bold cBlue, 微软雅黑
	Gui, Add, Button, Hidden Default, OK
	Gui, Add, ListView, r10 w700 gMyListView, 路径名称|路径
	For key, value in Current_Pair
	{
		LV_Add("", key, value)
	}
	LV_ModifyCol()
	Gui, Show

}

; Enter 键来打开对应的路径
ButtonOK:
GuiControlGet, FocusedControl, FocusV
if FocusedControl != "MyListView"
    return
Else
{
	RowNumber := 0  
	RowNumber := LV_GetNext(RowNumber)
    if not RowNumber
        return
	if RowNumber = 0
		return 
    LV_GetText(Text, RowNumber,2)
    run %Text%
}
return

; 双击对应的条目打开对应的目录
MyListView:
if (A_GuiEvent = "DoubleClick")
{
    RowNumber := 0  
	RowNumber := LV_GetNext(RowNumber)
    if not RowNumber
        return
	if RowNumber = 0
		return 
    LV_GetText(Text, RowNumber,2)
    run %Text%
}	
return



Hotkey,^!d,hellow
return

hellow:
Dir_Map = {}
Dir_Map := Ini_Parser("config.ini","Dir")
Show_RecentDir(Dir_Map)
MsgBox, hello
return








; Enter 键来打开对应的路径
ButtonOK:
GuiControlGet, FocusedControl, FocusV
if FocusedControl != "MyListView"
    return
Else
{
	RowNumber := 0  
	RowNumber := LV_GetNext(RowNumber)
    if not RowNumber
        return
	if RowNumber = 0
		return 
    LV_GetText(Text, RowNumber,2)
    run %Text%
}
return

; 双击对应的条目打开对应的目录
MyListView:
if (A_GuiEvent = "DoubleClick")
{
    RowNumber := 0  
	RowNumber := LV_GetNext(RowNumber)
    if not RowNumber
        return
	if RowNumber = 0
		return 
    LV_GetText(Text, RowNumber,2)
    run %Text%
}	
return


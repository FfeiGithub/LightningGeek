
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


; 对目录进行排序
#IfWinActive, ahk_class CabinetWClass
c:: ;explorer - sort files by date modified
;#IfWinActive, ahk_class ExploreWClass
;n:: ;explorer - sort files by date modified
WinGet, hWnd, ID, A
for oWin in ComObjCreate("Shell.Application").Windows

for oWin in ComObjCreate("Shell.Application").Windows
{
	;msgbox flag %flag%
	if (oWin.HWND = hWnd)
	{
		if (flag==0)
		{	
		;MsgBox, % oWin.Document.SortColumns ;show current sort columns
		oWin.Document.SortColumns := "prop:System.DateModified;" ;sort by date modified ascending (oldest first)
		;oWin.Document.SortColumns := "prop:-System.DateModified;" ;sort by date modified descending (newest first)
		;oWin.Document.SortColumns := "prop:System.ItemNameDisplay;" ;sort by name ascending (A-Z)
		;oWin.Document.SortColumns := "prop:-System.ItemNsameDisplay;" ;sort by name descending (A-Z)
		flag=1
		;MsgBox date0
		break
		}
		else if (flag==1)
		{
		;MsgBox, % oWin.Document.SortColumns ;show current sort columns
		;oWin.Document.SortColumns := "prop:System.DateModified;" ;sort by date modified ascending (oldest first)
		oWin.Document.SortColumns := "prop:-System.DateModified;" ;sort by date modified descending (newest first)
		;oWin.Document.SortColumns := "prop:System.ItemNameDisplay;" ;sort by name ascending (A-Z)
		;oWin.Document.SortColumns := "prop:-System.ItemNameDisplay;" ;sort by name descending (A-Z)
		;MsgBox date1
		flag=0
		break
		}
		else
		{
		flag=0
		}
	}
}
oWin := ""
return

#IfWinActive


#IfWinActive, ahk_class CabinetWClass
n:: ;explorer - sort files by date modified
;#IfWinActive, ahk_class ExploreWClass
;n:: ;explorer - sort files by date modified
WinGet, hWnd, ID, A
for oWin in ComObjCreate("Shell.Application").Windows
{

	
	if (oWin.HWND = hWnd)
	{
		
		if (flag==0)
		{
			msgbox name1
		;MsgBox, % oWin.Document.SortColumns ;show current sort columns
		;oWin.Document.SortColumns := "prop:System.DateModified;" ;sort by date modified ascending (oldest first)
		;oWin.Document.SortColumns := "prop:-System.DateModified;" ;sort by date modified descending (newest first)
		oWin.Document.SortColumns := "prop:System.ItemNameDisplay;" ;sort by name ascending (A-Z)
		;oWin.Document.SortColumns := "prop:-System.ItemNameDisplay;" ;sort by name descending (A-Z)
		flag=1
		break
		}
		else if (flag==1)
		{
			
		;MsgBox, % oWin.Document.SortColumns ;show current sort columns
		;oWin.Document.SortColumns := "prop:System.DateModified;" ;sort by date modified ascending (oldest first)
		;oWin.Document.SortColumns := "prop:-System.DateModified;" ;sort by date modified descending (newest first)
		;oWin.Document.SortColumns := "prop:System.ItemNameDisplay;" ;sort by name ascending (A-Z)
		oWin.Document.SortColumns := "prop:-System.ItemNameDisplay;" ;sort by name descending (A-Z)
		flag=0
		msgbox name2
		break
		}
		else{
		flag=0
		}
	}
}
oWin := ""
return
#IfWinActive

esc::Reload


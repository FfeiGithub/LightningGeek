RunOrActivateProgram(Program = "", WorkingDir="", WindowSize="")
{ 
    SplitPath Program, ExeFile 
    Process, Exist, %ExeFile% 
    PID = %ErrorLevel% 
    if (PID = 0) { 
    Run, %Program%, %WorkingDir%, %WindowSize% 
    }else{ 
    WinActivate, ahk_pid %PID% 
    } 
}

;获取选择的文件路径
Explorer_GetSelection(hwnd="")   ;函数
{  
    WinGet, process, processName, % "ahk_id" hwnd := hwnd? hwnd:WinExist("A")  
    WinGetClass class, ahk_id %hwnd%  
    if (process != "explorer.exe")  
        return  
    if (class ~= "Progman|WorkerW") {  
            ControlGet, files, List, Selected Col1, SysListView321, ahk_class %class%  
            Loop, Parse, files, `n, `r  
                ToReturn .= A_Desktop "\" A_LoopField "`n"  
        } else if (class ~= "(Cabinet|Explore)WClass") {  
            for window in ComObjCreate("Shell.Application").Windows 
			{
				try{
                if (window.hwnd==hwnd)  
                    sel := window.Document.SelectedItems  
				}catch e {
					continue
				}
			}
            for item in sel  
                ToReturn .= item.path "`n"  
        }  
    return Trim(ToReturn,"`n")  
} 

; 修改当前的目录地址
Explorer_Navigate(FullPath, hwnd="") {	; by Learning one
	hwnd := (hwnd="") ? WinExist("A") : hwnd ; if omitted, use active window
	WinGet, ProcessName, ProcessName, % "ahk_id " hwnd
	if (FullPath = "")
		return
	if (ProcessName != "explorer.exe")	; not Windows explorer
		return
	For pExp in ComObjCreate("Shell.Application").Windows
	{
		if (pExp.hwnd = hwnd) {	; matching window found
			pExp.Navigate("file:///" FullPath)
			return
		}
	}
}

Explorer_Enter_ParentDir(FullPath, hwnd="")
{
	MsgBox, enterParent
	WinGetClass,sClass,A
	if (sClass=”TFcFormMain” or sClass=”TTOTAL_CMD” or sClass=”ExploreWClass”)
	Send, {BS}
	else if (sClass=”CabinetWClass” || sClass=”#32770″)
	Send, !{up}
	return
}



;获取常用的目录列表
Show_RecentDir_ListView(Current_Pair)
{
	Gui Font, s12 Bold cBlue, 微软雅黑
	;Gui, Add, Button, r1 w1,Hidden Default, OK
	Gui, Add, ListView,W400 gMyListView, 路径名称|路径
	For key, value in Current_Pair
	{
		LV_Add("", key, value)
	}
	LV_ModifyCol()
	Gui, show
}

;; Enter 键来打开对应的路径
;ButtonOK:
;MsgBox,hello
;GuiControlGet, FocusedControl, FocusV
;if FocusedControl != "MyListView"
;    return
;Else
;{
;	
;	RowNumber := 0  
;	RowNumber := LV_GetNext(RowNumber)
;    if not RowNumber
;        return
;	if RowNumber = 0
;		return 
;    LV_GetText(Text, RowNumber,2)
;    run %Text%
;}
;return
;
;; 双击对应的条目打开对应的目录
;MyListView:
;if (A_GuiEvent = "DoubleClick")
;{
;    RowNumber := 0  
;	RowNumber := LV_GetNext(RowNumber)
;    if not RowNumber
;        return
;	if RowNumber = 0
;		return 
;    LV_GetText(Text, RowNumber,2)
;    run %Text%
;}	
;return






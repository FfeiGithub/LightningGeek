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



;{ GuiButtonIcon
; Fanatic Guru
; 2014 05 31
; Version 2.0
;
; FUNCTION to Assign an Icon to a Gui Button
;
;------------------------------------------------
;
; Method:
;   GuiButtonIcon(Handle, File, Options)
;
;   Parameters:
;   1) {Handle} 	HWND handle of Gui button
;   2) {File} 		File containing icon image
;   3) {Index} 		Index of icon in file
;						Optional: Default = 1
;   4) {Options}	Single letter flag followed by a number with multiple options delimited by a space
;						W = Width of Icon (default = 16)
;						H = Height of Icon (default = 16)
;						S = Size of Icon, Makes Width and Height both equal to Size
;						L = Left Margin
;						T = Top Margin
;						R = Right Margin
;						B = Botton Margin
;						A = Alignment (0 = left, 1 = right, 2 = top, 3 = bottom, 4 = center; default = 4)
;
; Return:
;   1 = icon found, 0 = icon not found
;
GuiButtonIcon(Handle, File, Index := 1, Options := "")
{
	RegExMatch(Options, "i)w\K\d+", W), (W="") ? W := 16 :
	RegExMatch(Options, "i)h\K\d+", H), (H="") ? H := 16 :
	RegExMatch(Options, "i)s\K\d+", S), S ? W := H := S :
	RegExMatch(Options, "i)l\K\d+", L), (L="") ? L := 0 :
	RegExMatch(Options, "i)t\K\d+", T), (T="") ? T := 0 :
	RegExMatch(Options, "i)r\K\d+", R), (R="") ? R := 0 :
	RegExMatch(Options, "i)b\K\d+", B), (B="") ? B := 0 :
	RegExMatch(Options, "i)a\K\d+", A), (A="") ? A := 4 :
	Psz := A_PtrSize = "" ? 4 : A_PtrSize, DW := "UInt", Ptr := A_PtrSize = "" ? DW : "Ptr"
	VarSetCapacity( button_il, 20 + Psz, 0 )
	NumPut( normal_il := DllCall( "ImageList_Create", DW, W, DW, H, DW, 0x21, DW, 1, DW, 1 ), button_il, 0, Ptr )	; Width & Height
	NumPut( L, button_il, 0 + Psz, DW )		; Left Margin
	NumPut( T, button_il, 4 + Psz, DW )		; Top Margin
	NumPut( R, button_il, 8 + Psz, DW )		; Right Margin
	NumPut( B, button_il, 12 + Psz, DW )	; Bottom Margin	
	NumPut( A, button_il, 16 + Psz, DW )	; Alignment
	SendMessage, BCM_SETIMAGELIST := 5634, 0, &button_il,, AHK_ID %Handle%
	return IL_Add( normal_il, File, Index )
}

move_Win()
{
    PostMessage, 0xA1, 2
}

SetTitleMatchMode RegEx
return

; show cmd.exe in currentWindow
#IfWinActive
OpenCmdInCurrent()
{
	WinGetText, full_path, A
	StringSplit, word_array, full_path, `n
	full_path = %word_array9%
	full_path := RegExReplace(full_path, "^地址: ", "")

	; Just in case - remove all carriage returns (`r)
	StringReplace, full_path, full_path, `r, , all

	IfInString full_path, \
	{
		Run, cmd /K cd /D "%full_path%"
	}
	else
	{
		Run, cmd /K cd /D "C:\ "
	}
}







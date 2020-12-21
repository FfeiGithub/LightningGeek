#NoEnv
#SingleInstance Force

#Include initools.ahk
#Include function.ahk
#Include systemCmd.ahk

;映射打开第三方App的快捷键接口
Key_Map := {}
Key_Map := Ini_Parser("config.ini","App")

For key, value in Key_Map
{
	Hotkey, %key%, Open3rdApp
}

Web_Map := Ini_Parser("config.ini","Web")
For key, value in Web_Map
{
	Hotkey,%key%, RunWeb
}

Cmd_Map := Ini_Parser("config.ini","Cmd")
For key, value in Cmd_Map
{
	Hotkey,%key%,%value%
}

; 通过Ctrl + G在目录下打开cmd.exe
Hotkey, IfWinActive, ahk_class CabinetWClass
Hotkey, ^g,Cmd_ShowCmdInCurrentDir

Hotkey, IfWinActive, ahk_class CabinetWClass
Hotkey, F4, Cmd_OpenFileWithDefaultEditor
return 

; 以Notepat++ 打开对应的文档文件快捷键设定为F4保持和TotalCommand一致
Cmd_OpenFileWithDefaultEditor:
selectFilePath := % Explorer_GetSelection(hwnd)
DefaultApp_Map := Ini_Parser("config.ini","DefaultApp")
Default_Editor := "Default_Text_Editor"
Default_Editor_Addr := DefaultApp_Map[Default_Editor]
Run,%Default_Editor_Addr% %selectFilePath%
return

;Run the web
RunWeb:
MyVar := Web_Map[A_ThisHotkey]
Run, %MyVar%
return

;Run the app
Open3rdApp:
MyVar = ""
MyVar := Key_Map[A_ThisHotkey]
RunOrActivateProgram(MyVar)
return

;Copy file Path
cmd_CopyFilePath:
clipboard := % Explorer_GetSelection(hwnd) ;
Tooltip,%clipboard%
Sleep,800
Tooltip,
return

cmd_SwitchCurrentDir:
clipboard_current := % Explorer_GetSelection(hwnd) ;
Explorer_Navigate(clipboard_current)
return

cmd_SwitchParentDir:
clipboard_current := % Explorer_GetSelection(hwnd) ;
Explorer_Enter_ParentDir(clipboard_current)
return


;quit the app
cmd_ExitApp:
ExitApp
return

;Pause the app
Cmd_PauseApp:
Suspend
return

cmd_ShowRecentDir:
Dir_Map := Ini_Parser("config.ini","Dir")
Dir_Map_index := Ini_Parser_Index("config.ini","Dir")
Show_RecentDir_Menu(Dir_Map_index)
return

Show_RecentDir_Menu(Current_Pair)
{
	For index, element in Current_Pair
	{
		Menu, MyMenu, Add, %element%, MenuHandler
	}
	
	Current_Exe_locate_dir := "打开程序所在目录"
	close_all_open_dir_menuitem := "关闭所有打开目录"
	Menu, MyMenu, Add, %Current_Exe_locate_dir%, cmd_ShowMyExeDir
	Menu, MyMenu, Add, %close_all_open_dir_menuitem%, cmd_CloseAllFolder
	Menu, MyMenu, show
}

cmd_ShowMyExeDir:
Run, explorer.exe %A_WorkingDir%, C:\Windows, max
return

; 以最大化的方式打开某个目录
MenuHandler:
menu_value := Dir_Map[A_ThisMenuItem]
IfInString menu_value, \
{
	Run, explorer.exe %menu_value%, C:\Windows, max
}
else
{
	Run, explorer.exe "C:\Users\%A_UserName%\%menu_value%"
}
return

;关闭所有资源管理器的目录
cmd_CloseAllFolder:
GroupAdd, Explore, ahk_class CabinetWClass
GroupClose, Explore, A
return


cmd_ShowSysCmdMenu:
Sys_Cmd_Map := Ini_Parser("config.ini","WindowsCmd")
Sys_Cmd_Index := Ini_Parser_Index("config.ini","WindowsCmd")
Show_SysCmd_Menu(Sys_Cmd_Index)
return

Show_SysCmd_Menu(SysCmd_Pair)
{
	for index, element in SysCmd_Pair 
	{
		Menu, SysCmdMenu, Add, %element%, SysCmdHandler
	}
	;Menu,MyMenu,color,4d9cf8
	Menu,SysCmdMenu, show
}

SysCmdHandler:
sys_cmd_menu_value := Sys_Cmd_Map[A_ThisMenuItem]
Call_SystemCmd(sys_cmd_menu_value)
return


Cmd_ShowToolsBar:
User_Tool_Map := Ini_Parser("config.ini","MyTools")
User_Tool_Index := Ini_Parser_Index("config.ini","MyTools")
Show_Tool_bar(User_Tool_Index,User_Tool_Map)
return

Show_Tool_bar(Tool_Bar_Pair, User_Tool_Map)
{
	if WinExist("Tools_AHK_Feifei")
	{
		Gui, Destroy
		return
	}
		

	for index, element in Tool_Bar_Pair 
	{
		Gui, Add, Button, w70 h60 hwndIcon%index% gButton,
		exe_Path := User_Tool_Map[element]
		GuiButtonIcon(Icon%index%, exe_Path,, "w32 h32")
		
		%element:
		
	}
	x_Position := A_ScreenWidth - 110
	y_Position := A_ScreenHeight/10
	Gui,Show,X%x_Position% Y%y_Position% W90, Tools_AHK_Feifei
	;Gui +Resize -MaximizeBox
	Winset, Alwaysontop, , A
	OnMessage(0x201, "move_Win")
	WinSet, Style, -0xC00000, A
	WinSet, Transparent, 250, A
}

Cmd_DestroyToolsBar:
Gui, Destroy
return

GuiClose:
Gui, Destroy
return

Button:
GuiControlGet, control, Focus
current_exe := User_Tool_Map[control]
RunOrActivateProgram(current_exe)
PostMessage, 0xA1, 2
return

Cmd_ShowCmdInCurrentDir:
OpenCmdInCurrent()
return



;Gui, Add, Button, w22 h22 hwndIcon
;if !GuiButtonIcon(Icon, "some.exe") ; Example of Icon not found
;    GuiButtonIcon(Icon, "shell32.dll") ; Not Found then do this
;
;Gui, Add, Button, w22 h22 hwndIcon
;GuiButtonIcon(Icon, A_AhkPath)
;Gui, Add, Button, w22 h22 hwndIcon
;GuiButtonIcon(Icon, "shell32.dll", 23)
;
;Gui, Add, Button, w38 h60 hwndIcon1
;Gui, Add, Button, w38 h60 hwndIcon2
;Gui, Add, Button, w70 h60 hwndIcon3, Open
;Gui, Add, Button, w70 h60 hwndIcon4, Save
;Gui, Add, Button, w70 h60 hwndIcon5
;GuiButtonIcon(Icon1, "shell32.dll", 1, "s32")
;GuiButtonIcon(Icon2, "imageres.dll", 46, "s32 a1")
;GuiButtonIcon(Icon3, "shell32.dll", 46, "s32 a0 l2")
;GuiButtonIcon(Icon4, "shell32.dll", 259, "s32 a1 r2")
;GuiButtonIcon(Icon5, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe",,"w32 h32")
;
;Gui, Show
;
;Return
;
;ButtonOpen:
;MsgBox, %A_GuiControl%
;return







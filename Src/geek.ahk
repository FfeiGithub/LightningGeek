#NoEnv
#SingleInstance Force

#Include initools.ahk
#Include function.ahk

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
Pause
return

cmd_ShowRecentDir:
Dir_Map := Ini_Parser("config.ini","Dir")
Show_RecentDir_Menu(Dir_Map)
return

Show_RecentDir_Menu(Current_Pair)
{
	For key, value in Current_Pair
	{
		Menu, MyMenu, Add, %key%, MenuHandler
	}
	;Menu,MyMenu,color,4d9cf8
	Menu,MyMenu, show,960,540
}

; 以最大化的方式打开某个目录
MenuHandler:
menu_value := Dir_Map[A_ThisMenuItem]
Run, explorer.exe %menu_value%, C:\Windows, max
return

;关闭所有资源管理器的目录
cmd_CloseAllFolder:
GroupAdd, Explore, ahk_class CabinetWClass
GroupClose, Explore, A
return





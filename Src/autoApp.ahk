; #NoTrayIcon  ;不显示托盘图标
; Function to run a program or activate an already running instance 

Menu, Tray, Icon, auto.ico,1,1

RunOrActivateProgram(Program, WorkingDir="", WindowSize=""){ 
    SplitPath Program, ExeFile 
    Process, Exist, %ExeFile% 
    PID = %ErrorLevel% 
    if (PID = 0) { 
    Run, %Program%, %WorkingDir%, %WindowSize% 
    }else{ 
    WinActivate, ahk_pid %PID% 
    } 
}

;打开or切换谷歌浏览器  Alt+ Windows + C
#!c::
RunOrActivateProgram("C:\Program Files (x86)\Google\Chrome\Application\chrome.exe")
return 

;打开or切换Notepad++ Alt+ Windows + N
#!n::
RunOrActivateProgram("C:\Program Files (x86)\Notepad++\notepad++.exe")
return 

;打开or切换VS  Alt + Windows + V
#!v::
RunOrActivateProgram("C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe")
return

;打开or切换TotalCommand  Alt + Windows + T
#!t::
RunOrActivateProgram("F:\totalcmd\TOTALCMD64.EXE")
return

;打开or切换Everything  Alt + Windows + E
#!e::
Run "C:\Program Files\Everything\Everything.exe"
return


;打开or切换Cocall  Alt + Windows + O
#!o::
RunOrActivateProgram("C:\Program Files\CoCall5\CoCall5.exe")
return

;打开or切换QTCreator  Alt + Windows + Q
#!q::
RunOrActivateProgram("C:\Qt\Qt5.14.1\Tools\QtCreator\bin\qtcreator.exe")
return

;打开or切换有道云笔记  Alt + Windows + Y
#!y::
RunOrActivateProgram("C:\Program Files (x86)\Youdao\YoudaoNote\YoudaoNote.exe")
return

;打开or切换VMware Alt + Windows + V
#!m::
RunOrActivateProgram("C:\Program Files (x86)\VMware\VMware Workstation\vmware.exe")
return

;百度翻译  Ctrl + Windows + F
#^F::
run https://fanyi.baidu.com/?aldtype=16047
return




;控制面板
Call_SystemCmd(argument="")
{
	switch argument
	{
		case "cmd_RunSysControl":
		Run,Control,,Max
		return

		; 计算器
		case "cmd_RunSysCalc":
		Run,calc
		return

		; 注册表
		case "cmd_RunSysReg":
		Run, regedit.exe,,Max
		return

		;远程桌面
		case "cmd_RunSysRemoteControl":
		Run, mstsc,,Max
		return

		;获得系统属性
		case "cmd_RunSysDmCpl":
		Run, sysdm.cpl,,Max
		return

		;网络状态管理
		case "cmd_RunSysNetWorkInfo":
		Run, ncpa.cpl,,Max
		return

		;程序安装和卸载
		case "cmd_RunSysExeControl":
		Run, appwiz.cpl,,Max
		return

		;防火墙
		case "cmd_RunSysFireWall":
		Run, Firewall.cpl,,Max
		return

		; 声音控制和修复
		case "cmd_RunSysVoiceControl":
		Run, mmsys.cpl,,Max
		return

		;获得系统信息
		case "cmd_RunSys32Info":
		Run, msinfo32,,Max
		return 

		case "cmd_RunCreateShareDir":
		Run, shrpubw,,Max
		return

		case "cmd_RunShowScreenInfo":
		Run, desk.cpl,,Max
		return

		case "cmd_RunSysTaskSchedule":
		Run,taskschd.msc
		return

		case "cmd_RunSysLanguageFirstChoose":
		Run,ms-settings:regionlanguage,,Max
		return
		
		case "cmd_GetEnvVarsConfig":
		Run, sysdm.cpl,,Max
		return

	}
}

Ini_Parser(ini_file_path="", section = "")
{
	;读取ini文件并
	keyValueMap := {}
	
	if(ini_file_path == "")
	{
		Return keyValueMap
	}
	
	;分割字符串并进行提取信息
	currentsection =
	FileRead, filecontent, %ini_file_path%
	StringSplit, line, filecontent, `r`n, ,
	
	
	Loop, %line0%
	{
		;空行跳过
		value := line%A_Index%
		StringLength = StrLen(value)
		if StringLength = 0
		{
			continue
		}
		; 跳过分组[groupname]
		FSection := RegExMatch(value,  "\[.*\]" )
		if  FSection =  1
		{
			currentsection := RegExReplace(value,  "\[(.*)\]" ,  "$1" ) ;正则替换并赋值临时section $为向后引用
			continue
		}
		 
		; 提取特定group的子项目
		if currentsection = %section%
		{
			FKey := RegExMatch(value,  ".*=.*" ) ;正则表达式匹配key
			if  FKey =  1
			{
				TKey := RegExReplace(value,  "(.*)=.*" ,  "$1" ) ;正则替换并赋值临时key
				StringReplace, TKey, TKey, ., _, All
				TValue := RegExReplace(value,  ".*=(.*)" ,  "$1" ) ;正则替换并赋值临时value
				keyValueMap[TKey] := TValue
			}
		}	
	
	}
	return KeyValueMap
}




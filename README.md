#FTools

####An automation tools for Front-end Developer based on Autohotkey.


##目录结构：

	resource	
		对应程序所需要的外部资源

	config.ini	
		配置文件（快捷键等）

	StartLists.ini
		一键打开目录、程序 配置文件

	FTools.ahk
		程序文件

	FTPv2.ahk
		FTP类库

	FTools.exe
		已编译的可执行程序


##功能列表 :

	StartWork
		通过配置StartLists.ini，写入要打开的目录、文件列表，即可实现一键打开

	PickColor
		（下一版本即将废弃）

	BuildShortcut
		选中文件，按下快捷键，即可创建文件快捷方式到指定目录，方便 Win+R 打开

	ImgDemo（内网使用）
		输入诸如100x200的字符串，选中，按下快捷键，即可生成[code]<img src="http://ppms.paipaioa.com/img/demo/100x200.png" alt="img" / >[/code]，并在服务器端建立对应的图片文件

	ImgCompress
		开启后，按下快捷键即可对图片进行无损压缩处理。在开启状态下，通过FTPupload上传图片也会进行相应的无损压缩。

	TimeStamp
		按下快捷键，即可生成诸如“20120926195828”之类的时间戳字符串
	
	

	
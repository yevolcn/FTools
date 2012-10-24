#FTools

####An automation tools for Front-end Developer based on Autohotkey.

######下载地址：<http://yevolcn.github.com/FTools/>


##目录结构：

* resource	
对应程序所需要的外部资源

* icon.ico	
程序的图标文件

* config.ini	
配置文件（快捷键、程序路径等）

* StartLists.ini	
一键打开目录、程序 配置文件

* Ftp_Info.ini		
FTP配置文档，放置于需要开启此功能的根目录下

* FTPv2.ahk	
FTP类库

* FTools.ahk	
主程序文件

* FTools.exe	
主程序已编译的可执行程序

* Update.ahk	
更新程序文件

* Update.exe	
更新程序已编译的可执行程序


##功能列表 :

* StartWork		
需**配置StartLists.ini**，写入要打开的目录、文件列表，即可实现一键打开

* PickColor		
（正式版本中将废弃）

* BuildShortcut		
选中文件，按下快捷键，即可**创建文件快捷方式**到指定目录，方便 Win+R 打开

* ImgDemo（内网使用）		
输入诸如**100x200**的字符串，选中，按下快捷键，即可生成`<img src="http://ppms.paipaioa.com/img/demo/100x200.png" / >`，并在**服务器端建立**对应的图片文件

* ImgCompress		
开启后，按下快捷键即可对图片进行**无损压缩**处理。在开启状态下，通过FTPupload上传图片也会进行相应的无损压缩

* TimeStamp		
按下快捷键，即可生成诸如“20120926195828”的**时间戳字符串**

* CopyPath	
选中文件（或文件列表），按下快捷键，即可将文件（或文件列表）**路径**复制进剪贴板

* CopyName	
选中文件（或文件列表），按下快捷键，即可将文件（或文件列表）**名称**复制进剪贴板

* CopyURL	
需**配置Ftp_info.ini中的URL项**，选中文件（或文件列表），按下快捷键，即可将文件（或文件列表）**对应的URL地址**复制进剪贴板

* QuickOpen		
选中欲打开的**文件（或文件夹）地址**，按下快捷键，即可打开对应地址

* QuickSearch	
选中欲查询的**字符串**，按下快捷键，即可通过浏览器打开对应的**搜索引擎**进行查询（需在Setting中配置搜索引擎类型）

* AlwaysTop		
在窗口标题栏区域，同时按下**Ctrl和鼠标中键**，即可将当前**窗口置顶**（再次按下取消置顶）

* Transparency	
在窗口标题栏区域，**鼠标上下滚轮**，即可对当前窗口进行**透明度调节**

* FTPUpload		
需**配置Ftp_info.ini**，选中文件，按下快捷键，即可将**文件上传**至相应位置

* FTPDelete		
需**配置Ftp_info.ini**，选中文件，按下快捷键，即可同时**删除本地和FTP相应文件**

* FTPCompare	
需**配置Ftp_info.ini**，选中文件，按下快捷键，即可将**本地文件和FTP相应文件进行对比**（需在Setting中配置BeyondCompare程序路径）

* FTPTimeStamp_wg（内网使用）		
选中css文件，按下快捷键，即可在dev环境中**压缩生成.min.css文件**，同时**生成对应的时间戳文件**，并将相应文件列表复制进剪贴板

* About		
打开FTools的**说明**页面

* Update		
**更新**FTools版本

* Setting		
配置FTools中的**操作快捷键和参数**，并设置**功能是否开启**（可见）

* Reload		
重新打开程序

* Exit		
退出程序



	
	

	
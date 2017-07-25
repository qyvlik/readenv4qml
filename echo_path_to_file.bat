@echo %path% > path.txt
@echo msgbox "echo path to txt success",64,"echo path to txt success">alert.vbs && start alert.vbs && ping -n 2 127.1>nul && del alert.vbs

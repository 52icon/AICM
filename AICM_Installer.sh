#!/bin/bash

function crontab_installer () {
    yum install -y vixie-cron lftp #不想写判定了，直接无脑装，把判定交给软件包管理 因为基本所有Linux发行版都预装了Crontab
    apt-get install -y cron lftp 
}

function set_time_u () {
echo -e "请输入客户端开始压缩时间"
echo -e "依照Crontab的表达式"
echo -e "不懂请百度 Google Bing" 
read time_u
echo -e "$time_u root /usr/bin/AICM/AICM_Client.sh >> /usr/bin/AICM/AICM.log" >> /etc/crontab
}

#Start
echo -e "\033[41m####AICloudMirror Installer####\033[0m"
echo -e "I:安装AICM_Client"
#echo -e "c:安装AICM客户端"
#echo -e "add:添加服务端下载任务"
echo -e "Ctrl+C 退出安装"
read installdy  
case $installdy in
	I)
	   crontab_installer
       wget --no-check-certificate https://raw.githubusercontent.com/EwigeveMicca/AICM/master/AICM_Client.sh -P /usr/bin/AICM/
       wget --no-check-certificate https://raw.githubusercontent.com/EwigeveMicca/AICM/master/AICM.cfg -P /usr/bin/AICM/
	   chmod 777 /usr/bin/AICM/AICM_Client.sh
	   mkdir /usr/bin/AICM/tmp
	   set_time_u
	   echo -e ”安装完成 现在你可能需要配置/usr/bin/AICM/AICM.cfg“
	   
	   ;;
#	s)
#	   crontab_installer
#	   wget --no-check-certificate https://raw.githubusercontent.com/EVECloud/AICM/master/AICM_Server.sh -P /usr/bin/AICM/AICM_Server.sh
#	   set_time_d
#	   touch /usr/bin/AICM/AICM_DL.txt
#	   lastdy
#	   ;;
#	add)
#	   set_dl
#	   ;;
	*)
	   echo -e "请输入正确选项"
	   ;;
esac
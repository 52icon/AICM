#!/bin/bash

function crontab_installer () {
    yum install -y vixie-cron #不想写判定了，直接无脑装，把判定交给软件包管理 因为基本所有Linux发行版都预装了Crontab
    apt-get install -y cron
}

function lastdy () {
echo -e "安装执行完毕"
} 

function set_time_u () {
echo -e "请输入客户端开始压缩时间"
echo -e "依照Crontab的表达式"
echo -e "不懂请去www.evec.cc查看教程" 
read time_u
echo -e "$time_u root /usr/bin/AICM/AICM_Client.sh >> /usr/bin/AICM/AICM.log" >> /etc/crontab
}

function set_time_d () {
echo -e "请输入服务端开始下载时间"
echo -e "依照Crontab的表达式"
echo -e "不懂请去www.evec.cc查看教程"
echo -e "推荐间隔1个小时，建议在服务器上测试压缩时间"
read time_d
echo -e "$time_d root /usr/bin/AICM/AICM_Server.sh >> /usr/bin/AICM/AICM.log" >> /etc/crontab
}

function set_dl () {
echo -e "请输入下载URL"
echo -e "仅支持单条添加"
echo -e "目前仅支持单机备份"
read dls
echo -e "$dls/" >> /usr/bin/AICM/AICM_DL.txt
}

function install_web () {
echo -e "请确认已经将配置文件配置完毕"
echo -e "请确定服务端已经布置了web服务"
echo -e "按下Ctrl+C退出，输入 y 继续"
read webset
if [[ $webset == "y" ]]; then
	wget --no-check-certificate https://raw.githubusercontent.com/EVECloud/AICM/master/AICM_Web.tar.gz -P $backupsave
	cd $backupsave
	tar -zxf AICM_Web.tar.gz
fi
}


#Start
echo -e "\033[41m####AICloudMirror Installer####\033[0m"
echo -e "s:安装AICM服务端"
echo -e "c:安装AICM客户端"
echo -e "w:安装AICM Web端 (实验室功能)"
#echo -e "add:添加服务端下载任务"
echo -e "Ctrl+C 退出安装"
read installdy  

case $installdy in
	c)
	   crontab_installer
       wget --no-check-certificate https://raw.githubusercontent.com/EVECloud/AICM/master/AICM_Client.sh -P /usr/bin/AICM/AICM_Client.sh
       wget --no-check-certificate https://raw.githubusercontent.com/EVECloud/AICM/master/AICM.cfg -P /usr/bin/AICM/AICM.cfg
	   set_time_u
	   lastdy
	   ;;
	s)
	   crontab_installer
	   wget --no-check-certificate https://raw.githubusercontent.com/EVECloud/AICM/master/AICM_Server.sh -P /usr/bin/AICM/AICM_Server.sh
	   set_time_d
	   touch /usr/bin/AICM/AICM_DL.txt
	   lastdy
	   ;;
#	add)
#	   set_dl
#	   ;;
    w)
	   install_web
	   ;;
	*)
	   echo -e "请输入正确选项"
	   ;;
esac

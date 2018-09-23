#!/bin/bash
DengYu=$(date +%Y%m%d)
DengYuriver=$(date +%Y-%m-%d,%H:%m)
source /usr/bin/AICM/AICM.cfg

function BACKUPSQLBYDENGYU () {
mysqldump -u $sqluser -p$sqlpasswd $sqlname > $DengYu.sql
mv $DengYu.sql $webdir/$DengYu.sql
if [[ $targzpasswdonoffpack == "yes" ]]; then
	tar -czf - $webdir/$DengYu.sql | openssl aes-256-cfb8 -salt -k $targzpasswd -out $webdir/$DengYu.sql.tar.gz
	else
	tar czf $webdir/$DengYu.sql.tar.gz $webdir/$DengYu.sql	
fi
sleep $sleeptime
rm -f $webdir/$DengYu.sql.tar.gz
}

function BACKUPFILEBYDENGYU () {
if [[ $targzpasswdonoffpack == "yes" ]]; then
	tar -czf - $filedir/$DengYu.tar.gz | openssl aes-256-cfb8 -salt -k $targzpasswd -out $DengYu.tar.gz
	else
	tar czf $filedir/$DengYu.tar.gz $filedir
fi
mv $DengYu.tar.gz $webdir/$DengYu.tar.gz
sleep $sleeptime
rm -f $webdir/$DengYu.tar.gz
}

if [[ $backupsqlservicedengyu == "yes" ]]; then
    BACKUPSQLBYDENGYU
    else
    echo "$DengYuriver[AICM] SQLBakcup任务未激活" >> /usr/bin/AICM/AICM.log
fi

if [[ $backupfileservicedengyu == "yes" ]]; then 
    BACKUPFILEBYDENGYU
    else
    echo "$DengYuriver[AICM] FileBakcup任务未激活" >> /usr/bin/AICM/AICM.log
fi

echo "$DengYuriver[AICM] 所有任务执行完毕" >> /usr/bin/AICM/AICM.log

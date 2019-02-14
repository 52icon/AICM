#!/bin/bash
DengYu=$(date +%Y%m%d)
DengYuriver=$(date +%Y-%m-%d,%H:%m)
source /usr/bin/AICM/AICM.cfg

function BACKUPSQLBYDENGYU () {
mysqldump -u $sqluser -p$sqlpasswd $sqlname > $DengYu.sql
mv $DengYu.sql $aicmtmpdir/$DengYu.sql
if [[ $targzpasswdonoffpack == "yes" ]]; then
	tar -czf - $aicmtmpdir/$DengYu.sql | openssl aes-256-cfb8 -salt -k $targzpasswd -out $aicmtmpdir/$DengYu.sql.tar.gz
	else
	tar czf $aicmtmpdir/$DengYu.sql.tar.gz $aicmtmpdir/$DengYu.sql
    rm -rf $aicmtmpdir/$DengYu.sql	
fi
}

function BACKUPFILEBYDENGYU () {
if [[ $targzpasswdonoffpack == "yes" ]]; then
	tar -czf - $filedir | openssl aes-256-cfb8 -salt -k $targzpasswd -out $aicmtmpdir/$DengYu.tar.gz
	else
	tar czf $filedir/$DengYu.tar.gz $filedir
fi
}


function upupup () {
lftp -u ${DYSFTPUSER},${DYSFTPPASSWD} sftp://${AICMSERVERIP}:${SFTPPORT} <<EOF
cd ${DYSFTPBUDIR}/
lcd ${aicmtmpdir}
mput ${DengYu}*
by
EOF

if [[ $keeplocaldata == "no" ]]; then
    rm -rf ${aicmtmpdir}/${DengYu}*
fi
}

function upupups () {
lftp -u ${DYSFTPUSER},${DYSFTPPASSWD} sftp://${AICMSERVERIP}:${SFTPPORT} <<EOF
cd ${DYSFTPBUDIR}/
lcd ${aicmtmpdir}
mput ${DengYu}*
by
EOF

lftp -u ${DYSFTPUSER2},${DYSFTPPASSWD2} sftp://${AICMSERVERIP2}:${SFTPPORT2} <<EOF
cd ${DYSFTPBUDIR2}/
lcd ${aicmtmpdir}
mput ${DengYu}*
by
EOF

if [[ $keeplocaldata == "no" ]]; then
    rm -rf ${aicmtmpdir}/${DengYu}*
fi
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
upupup

function whowillup () {
if [[ $aloneserver == "yes" ]]; then
	upupup
	else
	upupups
fi
}

whowillup

echo "$DengYuriver[AICM] 所有任务执行完毕" >> /usr/bin/AICM/AICM.log

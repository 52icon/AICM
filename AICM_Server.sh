#!/bin/bash
DengYu=$(date +%Y%m%d)
DengYuriver=$(date +%Y-%m-%d,%H:%m)
speedu=k
source /usr/bin/AICM/AICM.cfg



if [[ $limitrated == "yes" ]]; then
    wget --limit-rate=$speedd$speedu -c http://$ipdy/$DengYu.sql.tar.gz -P $backupsave
    wget --limit-rate=$speedd$speedu -c http://$ipdy/$DengYu.tar.gz -P $backupsave
    else
    wget -c http://$ipdy/$DengYu.sql.tar.gz -P $backupsave
    wget -c http://$ipdy/$DengYu.tar.gz -P $backupsave
fi

#!/bin/bash
DengYu=$(date +%Y%m%d)
DengYuriver=$(date +%Y-%m-%d,%H:%m)
source /usr/bin/AICM/AICM.cfg

wget -c http://$ipdy/$DengYu.sql.tar.gz -P $backupsave
wget -c http://$ipdy/$DengYu.tar.gz -P $backupsave

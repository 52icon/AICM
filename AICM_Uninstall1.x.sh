#!/bin/bash
sed -i '/AICM_Client.sh/d' /etc/crontab
rm -rf /usr/bin/AICM/
echo -e “卸载完毕”

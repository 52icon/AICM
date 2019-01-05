#!/bin/bash
sed -i '/usr/bin/AICM/AICM_Client.sh' /etc/crontab
rm -rf /usr/bin/AICM/
echo -e “卸载完毕”



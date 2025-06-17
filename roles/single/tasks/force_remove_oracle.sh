#!/bin/bash

MASTER_HOSTNAME=""
ALL_HOSTS="192.168.2.153"
root_pass="changeme"

for i in $(echo $ALL_HOSTS)
do

    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "firewall-cmd --zone=public --permanent --remove-port={1521,5500,5520,3938}/tcp"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "firewall-cmd --reload"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "systemctl stop dbora"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "systemctl disable dbora"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "rm -fv /etc/systemd/system/dbora.service"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "systemctl daemon-reload"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "for i in \$(echo 'oinstall dba oper backupdba dgdba kmdba racdba'); do groupdel \$i; done"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "userdel oracle"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "rm -fv /etc/security/limits.d/30-oracle-limits.conf /etc/sysctl.d/98-oracle-sysctl.conf"
    sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@$i "rm -rfv /u01 /u02 /etc/oraInst.loc /etc/oratab /opt/ORCLfmap /home/oracle"

done


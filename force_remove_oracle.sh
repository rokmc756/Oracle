#!/bin/bash

MASTER_HOSTNAME=""
ALL_HOSTS="rk8-single-db"

# ssh root@$MASTER_HOSTNAME su "hadoop -c 'hadoop-daemon.sh stop zkfc'"

for i in $(echo $ALL_HOSTS)
do

   ssh root@$i "firewall-cmd --zone=public --permanent --remove-port={1521,5500,5520,3938}/tcp"
   ssh root@$i "firewall-cmd --reload"
   ssh root@$i "for i in \$(echo 'oinstall dba oper backupdba dgdba kmdba racdba'); do groupdel \$i; done"
   ssh root@$i "userdel oracle"
   ssh root@$i "rm -f /etc/security/limits.d/30-oracle-limits.conf /etc/sysctl.d/98-oracle-sysctl.conf"
   ssh root@$i "rm -rf /u01 /u02 /etc/oraInst.loc /etc/oratab /home/oracle"

done

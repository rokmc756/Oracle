#!/bin/bash

root_pass="changeme"

for i in $(seq 153 153)
do

   sshpass -p "$root_pass" ssh -o StrictHostKeyChecking=no root@192.168.2.$i reboot

done


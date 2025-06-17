for i in `echo 1 3 8 9`
do

    nc -vz 192.168.2.24$i 22
    ssh-keyscan 192.168.2.24$i >/dev/null 2>&1

done


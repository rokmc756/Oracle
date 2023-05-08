# cd /root/work
# ansible-playbook oracle19c_rdbmsinstall.yml --skip-tags=db19c_exeorainstroot,db19c_exeroot
--- during running of play book 
[root@ansible01 work]# ansible-playbook oracle19c_rdbmsinstall.yml --skip-tags=db19c_exeorainstroot,db19c_exeroot


https://facedba.blogspot.com/2022/04/install-oracle-19c-database-software.html


[oracle@rk8-single-db dbhome_1]$ export CV_ASSUME_DISTID=RHEL8.5 && ./runInstaller -silent -responseFile /u01/stage/19cEE_SoftOnly.rsp -noconfig -ignorePrereqFailure
Launching Oracle Database Setup Wizard...

[WARNING] [INS-35950] Installer has detected an invalid entry in the central inventory corresponding to Oracle home (/u01/app/oracle/product/19c/dbhome_1).
   ACTION: Choose a different location as Oracle home.
The response file for this session can be found at:
 /u01/app/oracle/product/19c/dbhome_1/install/response/db_2023-05-08_02-21-56AM.rsp

## What is the Purpose and Intension of this Oracle Playbook?
This playbook is intended to deploy/install Oracle Database easily and conveniently, configure remote connection, create new users and change pasword of sys,system users and so on on Baremetal, Virtual Machines and Cloud Infrastructure.\
\
Because there would be many opportunities to simulate or reproduce issues on development or test environment if you are running Oracle Database and encounter issues  in production.\
\
If you are quite farmilar with ansible and Oracle Database you could also utilize it in your production.\
As it provides easy and quick installation and uninstallation you could use efficently your hardware or virtualization resources especially in case who you are developer,dba and system administartor / engineer and so on.

## Where is it orignially came from and how has it been changed?
Basic playbook was came from the following article. Howerver there has been many changes based on ansible role, configuring OS environment and user and password settings and so on.\
https://facedba.blogspot.com/2022/04/install-oracle-19c-database-software.html

## Supported Oracle Database, Platform and OS
Virtual Machines\
Cloud Infrastructure\
Baremetal\
Oracle Database 19c and 21c on RHEL and Rocky Linux 8.x has been verified

## Prerequisite
MacOS or Fedora/CentOS/RHEL installed with ansible as ansible host.\
At least three supported OS should be prepared with yum repository configured.

## Prepare ansible host to run oralce playbook
* MacOS
```
$ xcode-select --install
$ brew install ansible
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
```

* Fedora/CentOS/RHEL
```
$ sudo yum install ansible
$ sudo yum install sshpass
```

## Prepareing OS
Configure Yum / Local & EPEL Repostiory

## Download / Configure / Run Oracle Playbook
#### 1) Clone Oracle Playbook into Your Local Machine
```
$ git clone https://github.com/rokmc756/Oracle
```
#### 2)  Go to Oracle directory
```
$ cd Oracle
```
#### 3) Change password for sudo user of ansible or target host
```
$ vi Makefile
~~ snip
ANSIBLE_HOST_PASS="changeme"    # It should be changed with password of user in ansible host that sudo user would be run.
ANSIBLE_TARGET_PASS="changeme"  # It should be changed with password of sudo user in managed nodes that sudo user would be installed.
~~ snip
```
#### 4) Change your sudo user and password on target host
```
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"     # Replace with username of sudo user
remote_machine_password="changeme"   # Replace with password of sudo user

[databases]
rk8-oracle ansible_ssh_host=192.168.2.153    # Change IP address of oracle host
```
#### 5) Set Oracle Version and Binary Filename
```
$ vi group_vars/all.yml
~~ snip
_oracle:
  cluster_name: jack-kr-oracle
  major_version: "21"
  minor_version: ""
  patch_version: "c"
  build_version: ""
  os_version: el8
  arch_type: x86_64
  bin_type: rpm
  db_name: oracle_testdb
  db_user: jomoon
  domain: "jtest.pivotal.io"
  repo_url: ""
  download_url: ""
  download: false
  host_num: "{{ groups['all'] | length }}"
  base_path: "/root"
  user:               "oracle"
  password:           "changeme"
  root_user:          "root"
  mount_directory:    "/"
  root_directory:     "/u01"
  app_dir:            "/u01/app"
  stage_dir:          "/u01/stage"
  sub_root_directory: "/u02"
  sub_oradata:        "/u02/oradata"
  base_dir:           "/u01/app/oracle"
  inventory:          "/u01/app/oraInventory"
  scripts_directory:  "/u01/app/scripts"
  home_dir:           "/u01/app/oracle/product/21c/dbhome_1"
  rsp:                "Oracle_EE_SoftOnly"
  binary:             "LINUX.X64_193000_db_home.zip"  #  "LINUX.X64_213000_db_home.zip"
  install_group:
    - { group: "oinstall",  gid: "1501" }
    - { group: "dba",       gid: "1502" }
    - { group: "oper",      gid: "1503" }
    - { group: "backupdba", gid: "1504" }
    - { group: "dgdba",     gid: "1505" }
    - { group: "kmdba",     gid: "1506" }
    - { group: "racdba",    gid: "1507" }
  ports:
    - { proto: "tcp",       port: "1521" }
    - { proto: "tcp",       port: "5500" }
    - { proto: "tcp",       port: "5520" }
    - { proto: "tcp",       port: "3938" }
~~ snip
# You could modify many options such as user, password and the location of directories and so on at here
```
#### 6) Download Oracle Binary for the the following link
* https://www.oracle.com/kr/database/technologies/oracle-database-software-downloads.html
#### 7) Lacate it into role/oracle/files directory
```
$ mv LINUX.X64_193000_db_home.zip role/oracle/files
# If you want to use 21 version,
$ mv LINUX.X64_213000_db_home.zip role/oracle/files
```
#### 8) Set hosts and role name
```
$ vi setup-temp.yml.tmp
---
- hosts: all
  become: yes
  gather_facts: true
  vars:
    print_debug: true
  roles:
    - temp
```
#### 9) Install Oracle Database at Once or Seperately
```
$ make single r=prepare s=os
$ make single r=setup s=pkgs
$ make single r=create s=swap
$ make single r=prepare s=db
$ make single r=setup s=db
$ make single r=config s=ora
$ make single r=deploy s=db
$ make single r=config s=db
$ make single r=create s=db
$ make single r=remove s=ora
$ make single r=copy s=examples
$ make single r=enable s=omf
$ make single r=create s=users
$ make single r=enable s=remote

or
$ make single r=install s=all
```
#### 10) Run the following script To uninstall oracle after modifying your user and hostname
```
$ make oracle r=delete s=force
```
#### 11) Run make deinstall if you just want to destroy oracle software only deployed at $ORACLE_HOME directory.
```
$ make single r=deinstall s=db
$ make single r=disable s=swap

or
$ make single r=uninstall s=all (X)
```


#### 12) Start and Stop Oracle Database Service

```
$ make single r=start s=db

or
$ make single r=stop s=db
```


## Planning
- [X] Add Uninstall
- [ ] Deinstall Not Working Currently
- [ ] Need Imporovement to Create Multi Tenant Databases -  https://mikedietrichde.com/2018/11/13/how-to-speed-up-multitenant-custom-database-creation/
- [ ] ADD Upgrade
- [ ] Consider playbook to add RAC referring to this link - https://github.com/oravirt/ansible-oracle, http://www.koreaoug.org/install/9222
- [ ] Install Oracle Grid Software
- [ ] Deinstall RAC - https://oracledbwr.com/step-by-step-deleting-node-in-oracle-rac-12c-release-1-environment/
- [ ] RAC DB 1 : Not in the discovery yet - https://www.cnblogs.com/liufarui/p/10962411.html,
- [ ] RAC DB 2 : https://dbalifeeasy.com/tag/ora-15014-path-orclocr_vote01-is-not-in-the-discovery-set/
- [ ] RAC DB 3 : https://baazi.wordpress.com/tag/ora-15018-ora-15031-ora-15014/



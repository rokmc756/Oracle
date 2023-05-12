## What is the purpose and intension of this oracle playbook?
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
~~~
$ xcode-select --install
$ brew install ansible
$ brew install https://raw.githubusercontent.com/kadwanev/bigboybrew/master/Library/Formula/sshpass.rb
~~~

* Fedora/CentOS/RHEL
~~~
$ sudo yum install ansible
$ sudo yum install sshpass
~~~

## Prepareing OS
Configure Yum / Local & EPEL Repostiory

## Download / configure / run oracle playbook
* Clone orlace playbook into your local machine
~~~
$ git clone https://github.com/rokmc756/oracle
~~~
* Go to oracle directory
~~~
$ cd oracle
~~~
* Change password for sudo user of ansible or target host
~~~
$ vi Makefile
~~ snip
ANSIBLE_HOST_PASS="changeme"    # It should be changed with password of user in ansible host that sudo user would be run.
ANSIBLE_TARGET_PASS="changeme"  # It should be changed with password of sudo user in managed nodes that sudo user would be installed.
~~ snip
~~~
* Change your sudo user and password on target host
~~~
$ vi ansible-hosts
[all:vars]
ssh_key_filename="id_rsa"
remote_machine_username="jomoon"     # Replace with username of sudo user
remote_machine_password="changeme"   # Replace with password of sudo user

[databases]
rk8-oracle ansible_ssh_host=192.168.0.189    # Change IP address of oracle host
~~~
* Set version and binary filename of Oracle
~~~
$ vi role/oracle/var/mail.yml
~~ snip
oracle_major_version: "19"
oracle_patch_version: "c"
~~ snip
oracle_binary:      "LINUX.X64_213000_db_home.zip"
~~ snip
# You could modify many options such as user, password and the location of directories and so on at here
~~~
Download Oracle Binary for the the following link - https://www.oracle.com/kr/database/technologies/oracle-database-software-downloads.html\
* Lacate it into role/oracle/files directory
~~~
$ mv LINUX.X64_193000_db_home.zip role/oracle/files
# If you want to use 21 version,
$ mv LINUX.X64_213000_db_home.zip role/oracle/files
~~~
* Set hosts and role name
~~~
$ vi setup-hosts.yml
---
- hosts: rk8-oracle
  become: yes
  roles:
    - oracle
~~~
* Install Oracle Database at once or seperately
~~~
$ make install
or
$ make prepare
$ make deploy
$ make setup
$ make config
~~~
* Run the following script To uninstall oracle after modifying your user and hostname
~~~
$ sh force_remove_oracle.sh
~~~
* Run make deinstall if you just want to destroy oracle software only.
~~~
$ make deinstall
~~~

## Planning
Add uninstall and upgraded playbook\
Consider playbook to add RAC referring to this link - https://github.com/oravirt/ansible-oracle

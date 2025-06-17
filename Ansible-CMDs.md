
ansible -m debug -a var=hostvars[inventory_hostname] all

ansible databases -m debug -a var=hostvars[inventory_hostname]

ansible -m setup iscsi | less


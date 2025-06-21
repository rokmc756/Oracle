USERNAME="jomoon"
COMMON="yes"
ANSIBLE_HOST_PASS="changeme"
ANSIBLE_TARGET_PASS="changeme"

VIRT_ENV=KVM

ifeq ($(VIRT_ENV),VMware)
        BOOT_CMD="powered-on"
        SHUTDOWN_CMD="shutdown-guest"
        ROLE_CONFIG="control-vms-vmware.yml"
        ANSIBLE_HOST_CONFIG="ansible-hosts-vmware"
else ifeq ($(VIRT_ENV),KVM)
        BOOT_CMD="start"
        SHUTDOWN_CMD="shutdown"
        ROLE_CONFIG="control-vms-kvm.yml"
        ANSIBLE_HOST_CONFIG="ansible-hosts-fedora"
else
        VIRT_ENV=
endif


boot:
	@if [ -z ${VIRT_ENV} ]; then echo "Not Supported Virtualization"; exit 1; fi
	@ansible-playbook -i ${ANSIBLE_HOST_CONFIG} --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} ${ROLE_CONFIG} --extra-vars "power_state=${BOOT_CMD} power_title=Power-On VMs"

shutdown:
	@if [ -z ${VIRT_ENV} ]; then echo "Not Supported Virtualization"; exit 1; fi
	@ansible-playbook -i ${ANSIBLE_HOST_CONFIG} --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} ${ROLE_CONFIG} --extra-vars "power_state=${SHUTDOWN_CMD} power_title=Shutdown VMs"

download:
	@if [ -z ${VIRT_ENV} ]; then echo "Not Supported Virtualization"; exit 1; fi
	@ansible-playbook --ssh-common-args='-o UserKnownHostsFile=./known_hosts' -u ${USERNAME} download-hadoop.yml --tags="download"


# For All Roles
%:
	@if [ -z ${VIRT_ENV} ]; then echo "Not Supported Virtualization"; exit 1; fi
	@cat setup-temp.yml.tmp | sed -e 's/temp/${*}/g' > setup-${*}.yml;

	@if [ "${*}" = "hosts" ]; then\
		ln -sf ansible-hosts-rk8 ansible-hosts;\
	elif [ "${*}" = "dns" ]; then\
		ln -sf ansible-hosts-rk9-dns ansible-hosts;\
		cat setup-temp.yml.tmp | sed -e 's/temp/hosts/g' > setup-${*}.yml;\
	elif [ "${*}" = "single" ]; then\
		ln -sf ansible-hosts-rk8-single ansible-hosts;\
	elif [ "${*}" = "rac" ] || [ "${*}" = "grid" ]; then\
		ln -sf ansible-hosts-rk8-rac ansible-hosts;\
	elif [ "${*}" = "iscsi" ]; then\
		ln -sf ansible-hosts-rk8 ansible-hosts;\
	else\
		echo "No actions to temp";\
		exit;\
	fi
	@cat Makefile.tmp  | sed -e 's/temp/${*}/g' > Makefile.${*}
	@make -f Makefile.${*} r=${r} s=${s} c=${c} USERNAME=${USERNAME}
	@rm -f setup-${*}.yml Makefile.${*}



# For All Roles
#%:
#	@ln -sf ansible-hosts-rk8-oracle ansible-hosts;
#	@cat Makefile.tmp  | sed -e 's/temp/${*}/g' > Makefile.${*}
#	@cat setup-temp.yml.tmp | sed -e 's/    - temp/    - ${*}/g' > setup-${*}.yml
#	@make -f Makefile.${*} r=${r} s=${s} c=${c} USERNAME=${USERNAME}
#	@rm -f setup-${*}.yml Makefile.${*}




# clean:
# 	rm -rf ./known_hosts install-hosts.yml update-hosts.yml


# https://stackoverflow.com/questions/4219255/how-do-you-get-the-list-of-targets-in-a-makefile
#no_targets__:
#role-update:
#	sh -c "$(MAKE) -p no_targets__ | awk -F':' '/^[a-zA-Z0-9][^\$$#\/\\t=]*:([^=]|$$)/ {split(\$$1,A,/ /);for(i in A)print A[i]}' | grep -v '__\$$' | grep '^ansible-update-*'" | xargs -n 1 make --no-print-directory
#        $(shell sed -i -e '2s/.*/ansible_become_pass: ${ANSIBLE_HOST_PASS}/g' ./group_vars/all.yml )


# Need to check what it should be needed
.PHONY:	all init install update ssh common clean no_targets__ role-update


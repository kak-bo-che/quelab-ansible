# Docker on windows notes
1) have to share drives in settings when using Hyper-v
2) have to append / to path when using $(pwd)

# Docker command
docker run -it --rm -v //C/Users/kakbo/Dropbox/Code/quelab/ansible:/ansib
le-playbooks quelab/ansible bash

## Example Ansible command for doorctrl
```bash
ssh-agent bash
ssh-add /root/id_rsa_quelab
export ANSIBLE_ROLES_PATH=$(pwd)/roles
# inventory is set to an ip address here because dns doesn't work within quelab
# all hosts should be done in the same way instead of using the inventory file
ansible-playbook -i "10.1.10.123," playbooks/doorctrl.yml --ask-vault-pass
ansible-playbook -i ansible_hosts playbooks/gameroomshelves.yml --ask-vault-pass 

ansible-playbook -i ansible_hosts playbooks/gameroomshelves.yml --vault-password-file=/root/.vault_pass
ansible-playbook -i ansible_hosts doorctrl.yml --vault-password-file=/root/.vault_pass --check

ansible-playbook -i ansible_hosts playbooks/gameroomshelves.yml --vault-password-file=/root/.vault_pass --tags shelf_light

## New Host setup
add admin user
setup no password required for sudo,
other subsequent entries may block this one
```admin   ALL=(ALL) NOPASSWD: ALL```
remove other passwords?
add ~/.ssh/authoroized_keys with quelab_pub key


# fix docker container:
apk update
apk add ansible
ServerAliveInterval 30

/usr/bin/ola_trigger -u 2 -l3 /opt/shelflights/shelf_lights.conf


## Raspberry pi ....
apt-get update 
install sudo vim python3 firmware-realtek python-is-python3ansible-playbook -i ansible_hosts doorctrl.yml --vault-password-file=.vault_passh
hostnamectl set-hostname doorctrl
/usr/sbin/adduser ...

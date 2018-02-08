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
ansible-playbook -i ansible_hosts doorctrl.yml --ask-vault-pass
ansible-playbook -i ansible_hosts playbooks/gameroomshelves.yml --ask-vault-pass 
ansible-playbook -i ansible_hosts playbooks/gameroomshelves.yml --vault-password-file=/root/.vault_pass
ansible-playbook -i ansible_hosts doorctrl.yml --vault-password-file=/root/.vault_pass --check

## New Host setup
add admin user
setup no password required for sudo, remove other passwords?
add ~/.ssh/authoroized_keys with quelab_pub key

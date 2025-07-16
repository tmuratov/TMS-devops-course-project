#!/bin/bash

REMOTE_USER="servitor"
REMOTE_HOME="/home/$REMOTE_USER"

PROJECT_ROOT="./tms-infra-project-root"

# check access level
if [[ $(id -u) -eq 0 ]]; then
    echo No sudo! sudo bad! Please run as the user who will be executing ansible commands
    exit 1
fi

# install packages
sudo apt install -y software-properties-common python3 python3-pip git ssh
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install -y ansible
echo "packages installed"

# create remote user and grant power on localhost
sudo useradd -mU -d $REMOTE_HOME -s /bin/bash -G sudo $REMOTE_USER || \
sudo usermod -d $REMOTE_HOME -aG sudo -s /bin/bash $REMOTE_USER || true
echo "$REMOTE_USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/servitor  > /dev/null
echo "user updated successfully"

# create ssh keypair FOR CURRENT USER and register on localhost's REMOTE home (as managed host)
[ -f ~/.ssh/id_rsa ] || ssh-keygen -t rsa -b 4096 -m PEM -N "" -f ~/.ssh/id_rsa -C ""
pubkey=$(cat ~/.ssh/id_rsa.pub)

sudo mkdir -p $REMOTE_HOME/.ssh && sudo touch $REMOTE_HOME/.ssh/authorized_keys
sudo grep -q "$pubkey" $REMOTE_HOME/.ssh/authorized_keys || echo "$pubkey" | sudo tee $REMOTE_HOME/.ssh/authorized_keys  > /dev/null
echo "keypair generated at and stored in localhost's remote user and root home folders"

# write ansible configuration overrides
sudo chmod +rw "$PROJECT_ROOT/ansible.cfg"
cat > "$PROJECT_ROOT/ansible.cfg" <<EOF

[defaults]
inventory = inventory.yml
remote_user = $REMOTE_USER
host_key_checking = False
roles_path = ./roles
vault_password_file = .vault_pass.txt

EOF

## .vault_pass.txt is optional for future use, using --ask-vault-pass here
## no exposed passwords here hehe

echo "ansible configuration updated"

echo "deploying test stand now..."
pushd $PROJECT_ROOT || exit 1
ansible-playbook playbooks/vagrant-up.ansible.yml --ask-vault-pass
popd || return

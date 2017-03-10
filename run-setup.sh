#!/bin/bash
echo "Enter ansible vault password: "
read password_vault
echo $password_vault >> ~/.vault_pass.txt
echo "Running Provisioning"
echo "##########################"
echo "\n"
echo "Accepting xcode license"
sudo xcodebuild -license accept
echo "Installing xcode cli tools"
sudo xcode-select --install
echo "installing pip"
sudo easy_install pip
echo "installing ansible"
sudo pip install ansible
echo "making provision directory"
mkdir .provision && cd .provision
echo "pulling down provisioning tools"
git clone https://github.com/moos3/macbook-setup.git
cd macbook-setup
echo "installing requirements"
ansible-galaxy install -r requirements.yml
echo "running provisioning"
ansible-playbook -i inventory -K --vault-password-file ~/.vault_pass.txt  main.yml
rm ~/.vault_pass.txt
echo "########################"
echo "\n"
echo "Happing Computing!"

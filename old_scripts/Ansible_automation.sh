#!/usr/bin/env bash
# First creating a var that will install

function operatingSys() {
  echo 'You chosen to insall ' $yuminstall
  echo '1. Debian'
  echo '2. Fedora'
  echo '3. Centos'
  echo '4. Ubuntu'
}
while true; do
  clear
  echo '1. httpd'
  echo '2. nss-pam-ldapd'
  echo '3. autofs'
  read -p 'Enter what you wish to install :' yuminstall

## After choosing what to install, you will be asked which to install to.

  if [[ $yuminstall == '1' ]]; then
    operatingSys
    read -p 'Chose an operating system :' distibution
    if [[ $distibution == '1' ]]; then
      ansible-playbook debian.yml -i hosts

    elif [[ $distibution == '2' ]]; then
      ansible all -u root -i hosts -a 'yum install httpd -y'

    elif [[ $distibution == '3' ]]; then
        ansible all -u root -i hosts -a 'yum install httpd -y'

    elif [[ $distibution == '4' ]]; then
          ansible-playbook ubuntu.yml -i hosts
     fi
        break
## If you choose nss-pam-ldapd then you will be asked again to which operating system

    elif [[ $yuminstall == '2' ]]; then
          operatingSys
          read -p 'Chose an operating system :' distibution

        if [[ $distibution == '1' ]]; then
          ansible-playbook nss-debian.yml -i hosts

        elif [[ $distibution == '2' ]]; then
          ansible all -u root -i hosts -a 'yum install nss-pam-ldapd -y'

        elif [[ $distibution == '3' ]]; then
            ansible all -u root -i hosts -a 'yum install nss-pam-ldapd -y'

        elif [[ $distibution == '4' ]]; then
             ansible-playbook nss-ubunto.yml -i hosts
        fi
            break
## If you chose autofs then you will be asked agian to which operating system

        elif [[ $yuminstall == '3' ]]; then
      operatingSys
      read -p 'Chose an operating system :' distibution

    if [[ $distibution == '1' ]]; then
      ansible all -u root -i hosts -a 'apt-get install autofs -y'

    elif [[ $distibution == '2' ]]; then
      ansible all -u root -i hosts -a 'yum install autofs -y'

    elif [[ $distibution == '3' ]]; then
        ansible all -u root -i hosts -a 'yum install autofs -y'

    elif [[ $distibution == '4' ]]; then
        ansible-playbook autofs_ubuntu.yml -i hosts
     fi
        break

  else
      echo 'You chose wrong option'
      sleep 2
  fi
done

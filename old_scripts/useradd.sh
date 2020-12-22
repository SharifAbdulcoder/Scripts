#!/bin/bash
for i in servers.txt
do
read -p "Please enter the IP/hostname of your server: " ip
read -p "Please enter a user of the server: " suser

ssh $suser@ip << EOF
read -p "grand or revoke access?: " gr
if [ "$gr" == "grand" ]; then
    read -p "New User or Existing user? (n, e): " user
    if [ "$user" == "n" ]; then
        read -p "Please enter username: " nuser
        read -p "Please enter password: " npasswd
        useradd $nuser
        echo "npasswd" | passwd $nuser --stdin
        mkdir /home/"$nuser"/.ssh
        read -p "Please paste ssh key for the user $nuser: " nsshkey
        echo "$nsshkey" >> /home/"$nuser"/.ssh/authorized_keys
        echo "user $nuser has been granted"

    elif [ "$user" == "e" ]; then
      read -p "Please enter the username of existing user: " euser
      mkdir /home/"$euser"/.ssh
      read -p "Please paste ssh key for the user $euser: " esshkey
      echo "$esshkey" >> /home/"$euser"/.ssh/authorized_keys
      echo "user $euser has been granted access "
    else
      echo "invalid option"
    fi

elif [ "$gr" == "revoke" ]; then
  read -p "Please enter the username of the user: " ruser
  echo "BE AWARE the authorized_keys file will be emptied for the user $ruser"
  echo "revoked" > /home/$ruser/.ssh/authorized_keys
  echo "User $ruser has been revoked"

else
  echo "invalid option"

fi
EOF
done

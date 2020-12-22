#!/bin/bash

user=$1
password=$2
ssh_pub_key=$3

sudo useradd $user && echo $password | passwd {} --stdin
sudo mkdir /home/$user/.ssh && sudo chmod 700 /home/$user/.ssh
echo $ssh_pub_key >> /home/$user/.ssh/authorized_keys
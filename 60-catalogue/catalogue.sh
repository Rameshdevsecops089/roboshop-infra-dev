#!/bin/bash

component=$1
dnf install ansible -y
ansible-pull -u https://github.com/Rameshdevsecops089/ansible-roboshop-roles-tf.git -e component=$1 -e env=$2 main.yaml # -u means url
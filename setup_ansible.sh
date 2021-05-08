#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install ansible2 -y
sudo yum install epel-release -y
sudo yum install -y python-pip wget
sudo pip install boto3 boto
mkdir ansible
cp -r /etc/ansible/* ansible/
sed -i '/#inventory      =/c\inventory = inventory_aws_ec2.yml' ansible/ansible.cfg
sed -i '/#host_key_checking = False/c\host_key_checking = False' ansible/ansible.cfg
echo "plugin: aws_ec2
keyed_groups:
  - key: tags
filters:
  instance-state-name : running
compose:
  ansible_host: private_ip_address" > /home/pawan/ansible/inventory_aws_ec2.yml
mkdir .ssh
touch .ssh/authorized_keys
chown -R pawan.pawan /home/pawan/
chmod -R 700 .ssh
mkdir -p /home/pawan/ansible/ES
cd /home/pawan/ansible/ES/ && wget https://raw.githubusercontent.com/Paws11/Automate/master/ES/es1.yml
cd /home/pawan/ansible/ES/ && wget https://raw.githubusercontent.com/Paws11/Automate/master/ES/es2.yml
cd /home/pawan/ansible/ES/ && wget https://raw.githubusercontent.com/Paws11/Automate/master/ES/es3.yml
cd /home/pawan/ansible/ && wget https://raw.githubusercontent.com/Paws11/Automate/master/vpc.yml
chown -R pawan.pawan /home/pawan/

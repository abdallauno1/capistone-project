#!/bin/bash

# remove comment if you want to enable debugging
#set -x

if [ -e /etc/redhat-release ] ; then
  REDHAT_BASED=true
fi

TERRAFORM_VERSION="1.1.5"
PACKER_VERSION="0.10.1"
# create new ssh key
#[[ ! -f /home/$USER/.ssh/id_rsa ]] \
# && mkdir -p /home/$USER/.ssh \
# && ssh-keygen -f /home/$USER/.ssh/id_rsa -N '' \
# && chown -R $USER:$USER /home/$USER/.ssh 
# && cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys

# install packages
if [ ${REDHAT_BASED} ] ; then
  yum -y update
  yum install -y docker ansible unzip wget tree curl mlocate
else 
  sudo apt-get update
  sudo apt-get -y install docker.io ansible unzip python3-pip mlocate net-tools git whois htop curl tree ruby
fi
# add docker privileges
sudo usermod -aG docker $USER

# add user as sudo
sudo -i
echo '$USER  ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

# install awscli and ebcli

pip3 install setuptools==45
#pip3 install -U awscli
#pip3 install -U awsebcli

#terraform
T_VERSION=$(/usr/local/bin/terraform -v | head -1 | cut -d ' ' -f 2 | tail -c +2)
T_RETVAL=${PIPESTATUS[0]}

[[ $T_VERSION != $TERRAFORM_VERSION ]] || [[ $T_RETVAL != 0 ]] \
&& wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip \
&& sudo unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip


# packer
P_VERSION=$(/usr/local/bin/packer -v)
P_RETVAL=$?

[[ $P_VERSION != $PACKER_VERSION ]] || [[ $P_RETVAL != 1 ]] \
&& wget -q https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip \
&& sudo unzip -o packer_${PACKER_VERSION}_linux_amd64.zip -d /usr/local/bin \
&& rm packer_${PACKER_VERSION}_linux_amd64.zip

# clean up
if [ ! ${REDHAT_BASED} ] ; then
  sudo apt-get clean
fi

# docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo systemctl restart sshd

# pull perscholas image from dockerHub
docker pull abdallauno1/perscholas:v1

# run the docker container 
docker run -d -p 4000:5000 --name perscholas abdallauno1/perscholas:v1
#!/bin/bash

# Shortcut script for adding public SSH key to remote (for passwordless login)
#

VERSION="1.00"
DATE=`date`

echo
echo -------------------------------
echo -- ADD PUBLIC SSH KEY v ${VERSION} --
echo -------------------------------
echo
echo Running at ${DATE}
echo

# Colors
red=$'\e[1;31m'
grn=$'\e[1;32m'
yel=$'\e[1;33m'
blu=$'\e[1;34m'
mag=$'\e[1;35m'
cyn=$'\e[1;36m'
end=$'\e[0m'

# Make sure the user has an SSH key
if [ ! -e ~/.ssh/id_rsa.pub ]
then
	echo "You don't have an SSH identity yet."
	echo "Please follow these instructions to generate one."
	echo
	echo -n "Enter your email: "
	read EMAIL
	echo
	echo "Save your SSH key in its default location (just press enter)"
	ssh-keygen -t rsa -C "${EMAIL}"
fi

# Prompt user for domain
echo -n "Domain: "
read DOMAIN

# You'll be asked for the password

#cat ~/.ssh/id_rsa.pub | ssh root@${DOMAIN} "cat >> ~/.ssh/authorized_keys"
cat ~/.ssh/id_rsa.pub | ssh root@${DOMAIN} "cat >> ~/authorized_keys; mkdir -p ~/.ssh; mv ~/authorized_keys ~/.ssh/authorized_keys"
if [ $? -eq 0 ] 
then
	echo $green
	echo "That seems to have worked... Trying to login to server..."
	echo $end
	ssh -l root $DOMAIN
else
	echo $red
	echo "FAILED"
	echo $end
fi
echo

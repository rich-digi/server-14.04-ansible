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
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

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
cat ~/.ssh/id_rsa.pub | ssh root@${DOMAIN} "cat >> ~/.ssh/authorized_keys"
if [ $? -eq 0 ] 
then
	echo $COL_GREEN
	echo "That seems to have worked... Trying to login to server..."
	echo $COL_RESET
	ssh -l root $DOMAIN
else
	echo $COL_RED
	echo "FAILED"
	echo $COL_RESET
fi
echo

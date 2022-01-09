#!/bin/bash

#Purpose: To add new users to linux system with temporary password

#OS : Ubuntu 21 LTS
#AUTHOR: Razat Aggarwal , razat.linuxprogrammer@gmail.com

#check if the current user is root or not, if not then exit 1 
if [[ "${UID}" -eq '0' ]] 
then 
	#Ask username 
	read -p "Enter the username of the local account: " USER_NAME
	#check if the username already exists or not in local system. 
	grep "^${USER_NAME}" /etc/passwd > /dev/null 
	if [[ "${?}" -eq '0' ]]
	then 
		echo "${USER_NAME} already exists"
		exit 2
	fi 
	#Ask Real Name 
	read -p "Enter the real name of the above account: " REAL_NAME
	#Ask initial password
	read -p "Enter the initial password for the above account : " PASS
	#create a new user on the local system with username and real name. 
	useradd -m -c "${REAL_NAME}" "${USER_NAME}"
	#check if user is created or not, if not then exit 1
	if [[ "${?}" -eq '0' ]] 
	then 
		echo "${USER_NAME} successfully created"
	else 
		echo "${USER_NAME} not created"
		exit 1 
	fi 
	#set the password of the user
	echo ${USER_NAME}:${PASS} | chpasswd
	#set the password to expire after first login.
	passwd -e ${USER_NAME}
	#display the username , password and hostname details
	HOST_NAME=$(hostname)
	echo -e "USERNAME : ${USER_NAME} \n PASSWORD : ${PASS} \n Hostname: ${HOST_NAME}"  
else 
	echo 'Only root users can create new user accounts'
	exit 1 
fi 
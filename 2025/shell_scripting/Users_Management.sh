#!/bin/bash

function UserManagement {

	# Create USer
	if [ "$1" == "-c" ] || [ "$1" == "--create" ]; then
		read -p "Enter User name: " username
		userValid=$(cat /etc/passwd | grep $username | wc -1)

		if [ $userValid -gt 0 ]; then
			echo "User already Exists"
			exit
		else
			echo "User Does not exist. Create the $username"
			useradd -m "$username" > /dev/null
			read -sp "ENTER THE PASSWORD For $username: " passwd
			echo -e "$passwd\n$passwd" | passwd "$username" > /dev/null
			echo "User Created "
			cat /etc/passwd | grep $username
		fi
	#Account Delete	

        elif [ "$1" == "-d" ] || [ "$1" == "--delete" ]; then
	
		read -p "Enter the username to be deleted: " username
		userValid=$(cat /etc/passwd | grep $username | wc -1)

		if [ $userValid -gt 0 ]; then
			echo "if user exists deleting the user:$username From home dir."
			userdel -r $username
		else
			echo "user not exists"
			exit
		fi
        #Password Reset
        elif [ "$1" == "-r" ] || [ "$1" == "--reset" ]; then

		 read -p "Enter User Name Whose Password You Want To Reset: " username
		 userValid=$(cat /etc/passwd | grep $username | wc -l)
		   
		 if [ $userValid -gt 0 ]; then
		       echo "User Exists."
		       read -sp "Enter Password For Your User $username: " passwd
	               echo -e "$passwd\n$passwd" | passwd "$username" > /dev/null
      	         else
		       echo "User Does Not Exist"
		       exit
		 fi
	elif [ "$1" == "-l" ] || [ "$1" == "--list" ]; then
		(echo -e "user\tuserID\tuserDir"; cat /etc/passwd | awk -F ':' '{print $1,$3,$6}') | column -t
        #help
	

	elif [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	         	echo "About => This PROJECT IS ABOUT CREATING A USER MANAGMEMNT. IN THIS MANY COMMANDS ARE CREATED FOR MAKING OUR LIFE EASIE FOR USER CREATION, DELETE,RESET,LIST"
			 echo "-c, --create : THIS IS USED TO CREATE A NEW USER"
		         echo "-d, --delete : DELETING THE USER"
			 echo "-r, --reset  : RESET A USER PASSWORD"
			 echo "-l, --list   : LISTING ALL USERS"
			 echo "-h, --help   : SHOWS HELP MESSAGE"


	else
			echo "Invalid option"
	fi

}

UserManagement $1



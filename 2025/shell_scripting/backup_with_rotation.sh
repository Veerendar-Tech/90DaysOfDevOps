#!/bin/bash
#

if [ $# -ne 1 ]; then
	echo "we need argument of file to backup"
	exit 1
fi
source="${1%/}"
backup_just="backup"
timestamp=$(date "+%Y-%m-%d_%H-%M-%S")
directory="${source}/${backup_just}_${timestamp}"

if [ ! -d $source ]; then
	echo "Target file is not found"
        exit 1
fi

if rsync -a --exclude="${backup_just}_*" "$source/" "$directory" ; then
	echo "backup is created except the backup files"
else
	echo "backup is failed"
	exit 1
fi

backups=($(ls -d "${source}/${backup_just}_"* 2> /dev/null | sort))
backup_count=${#backups[@]}

if [ "$backup_count" -gt 3 ]; then
    remove_count=$((backup_count - 3))
        echo -e "\nRotating backups - removing $remove_count old version(s)"

 #Loop through and remove the oldest backups
         for (( i=0; i<remove_count; i++ )); do
		 echo "Removing: ${backups[$i]}"
		 rm -rf "${backups[$i]}"
	 done
fi






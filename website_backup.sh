#!/bin/bash

sites[0]='<folder you want to backup>,<mysql username>,<mysql password>'
sites[1]='<folder you want to backup>,<mysql username>,<mysql password>'
sites[2]='<folder you want to backup>,<mysql username>,<mysql password>'

bak_home=/home4/lpatch
bak_dir=$bak_home/backup.lifepatch.org

# user, password, gzip file out
function backup_mysql(){
	echo "mysqldump --host=127.0.0.1 -A --user=${1} --password=${2} --all-databases | gzip > ${3}"
	#echo "mysqldump --host=127.0.0.1 -A --user=${bak_mysql_user} --password=${bak_mysql_pass} --all-databases | gzip > $bak_dir/$bak_mysql_file"
}

function backup_files()
{
	echo "tar -czvf ${1} ${2}"	
	#echo "tar -czvf $bak_dir/$bak_file $bak_home/$bak_target"	
}

function backup_sites()
{
	for element in "${sites[@]}"
	do
		IFS=', ' read -a array <<< "$element"
		echo "backup: ${array[0]}"
		source_folder=${array[0]}
		source_sql_user=${array[1]}
		source_sql_pass=${array[2]}
		
		bak_target_clean=$(echo "${source_folder}" | sed 's#/#\_#g')
		
		bak_mysql_file=${bak_target_clean}_sql_$(date +%Y%m%d).gz
		bak_file=${bak_target_clean}_$(date +%Y%m%d).tar.gz

		backup_mysql $source_sql_user $source_sql_pass $bak_dir/$bak_mysql_file
		backup_files $bak_dir/$bak_file $bak_home/$source_folder
		
		echo ""

	done
}

backup_sites
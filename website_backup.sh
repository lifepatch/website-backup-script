#!/bin/bash

# user, password, gzip file out
function backup_mysql(){
	param=`mysqldump --host=127.0.0.1 -A --user="${1}" --password="${2}" --all-databases | gzip > "${3}"`
	echo ${param}
	#echo "mysqldump --host=127.0.0.1 -A --user=${bak_mysql_user} --password=${bak_mysql_pass} --all-databases | gzip > $bak_dir/$bak_mysql_file"
}

function backup_files()
{
	echo "tar -czvf '${1}' '${2}'"	
	#echo "tar -czvf $bak_dir/$bak_file $bak_home/$bak_target"	
}

function backup_sites()
{
	for element in "${sites[@]}"
	do
		IFS='| ' read -a array <<< "$element"
		echo "backup: ${array[0]}"
		source_folder=${array[0]}
		source_sql_user=${array[1]}
		source_sql_pass=${array[2]}
		
		bak_target_clean=$(echo "${source_folder}" | sed 's#/#\_#g')
		
		bak_mysql_file=${bak_target_clean}_sql_$(date +%Y%m%d).sql.gz
		bak_file=${bak_target_clean}_$(date +%Y%m%d).tar.gz

		backup_mysql $source_sql_user $source_sql_pass $bak_dir/$bak_mysql_file
		backup_files $bak_dir/$bak_file $bak_home/$source_folder
		
		echo "backup for $bak_target_clean"
		echo "sql: $bak_url/$bak_mysql_file"
		echo "files: $bak_url/$bak_file"
		
		echo ""

	done
}

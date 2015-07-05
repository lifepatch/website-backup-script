#!/bin/bash

source ./website_backup.sh 

bak_home=/home4/lpatch
bak_dir=$bak_home/backup.lifepatch.org

sites[0]='source_folder|mysql_username|mysql_password'
#sites[1]='source_folder|mysql_username|mysql_password'
#sites[2]='source_folder|mysql_username|mysql_password'

#call backup function and start backup session
backup_sites

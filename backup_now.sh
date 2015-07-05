#!/bin/bash

source ./website_backup.sh 

bak_home=/home4/lpatch
bak_dir=$bak_home/backup.lifepatch.org

sites[0]='<folder you want to backup>,<mysql username>,<mysql password>'
sites[1]='<folder you want to backup>,<mysql username>,<mysql password>'
sites[2]='<folder you want to backup>,<mysql username>,<mysql password>'

#call backup function
backup_sites

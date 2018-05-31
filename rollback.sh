#!/bin/bash

### Script for rolback up SSYNC
### Initial version - Nikhilesh
### backup failed version and deploy the previous working backup
  restore_safe_copies () {
    echo "Starting rollback process `date` "
    echo "------------------------------------------------------------------------------"
    cd $HOME_DIR || exit 87
        pwd
        ls -l
    if [ ! -d "backup" ]
      then
         failed "There is no backup directory "
    fi
## Printing Backup folder
    echo "Checking if backup file exists"
    cd $HOME_DIR/backup || exit 87
       bkfiles=$(ls -d *${RUNID}*)
    if [ -z "$bkfiles" ]
        then
            echo "backup is not found"
            exit 87
        else
            echo "backup file is exists"
            echo "${bkfiles}"
            echo "Cleaning existing files"
            cd $HOME_DIR || exit 87
            find * -maxdepth 0 -name 'backup' -prune -o -exec rm -rf '{}' ';'
    fi
#Restore the backup
    echo "Copying backup to $HOME_DIR directory"
    cp -r $HOME_DIR/backup/$bkfiles/* $HOME_DIR/
    [ $? -ne 0 ] && failed "Unable to copy backup"
}

###Script usage- for wrong flag enetered
    usage ()  {
    echo "This scripts needs three flags with their values "
    echo "Example of correct usage is  ./rollback.sh -r runid -d HOME_DIR"
    exit 87

}

### Assigning variables
    set_environment  () {
    echo "Checking and assigning varibales"

    while getopts ":r:d:" opt
    do
        case "$opt" in
        r) RUNID="$OPTARG" ;;
        d) HOME_DIR="$OPTARG" ;;
       \?) echo "Wrong flag "
             usage ;;
    esac
    done
   }

################
###   MAIN   ###
################

    if [ $# -ne 4 ]; then
     usage
    fi
    echo "------------------------------------------------------------------------------"
    set_environment "$@"
        restore_safe_copies
    echo "------------------------------------------------------------------------------"

exit 0
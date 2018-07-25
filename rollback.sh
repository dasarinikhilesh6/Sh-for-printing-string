#!/bin/bash
### Script for rolback up SSYNC
### Initial version - Nikhilesh
### backup failed version and deploy the previous working backup
  restore_safe_copies () {
    echo "Starting rollback process `date` "
    echo "------------------------------------------------------------------------------"
    cd $BACKUP_DIR || exit 87
    echo "$BACKUP_DIR"
## Printing Backup folder
    echo "Checking if backup file exists"
    cd $BACKUP_DIR || exit 87
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
            echo "rm $HOME_DIR/*.jar"
			rm $HOME_DIR/*.jar
			if [ "$?" -gt "0" ]; then  echo "unable to remove old jar files" && exit 87; fi
			echo "rm $HOME_DIR/*.sh"
			rm $HOME_DIR/*.sh
			if [ "$?" -gt "0" ]; then  echo "unable to remove old script files" && exit 87; fi
			echo "rm -rf $HOME_DIR/config"
			rm -rf $HOME_DIR/config
			if [ "$?" -gt "0" ]; then  echo "unable to remove old config files" && exit 87; fi
    fi
#Restore the backup
    echo "Copying backup to $HOME_DIR directory"
    cp -r $BACKUP_DIR/$bkfiles/* $HOME_DIR/
	echo "cp -r $BACKUP_DIR/$bkfiles/* $HOME_DIR/"
    [ $? -ne 0 ] && failed "Unable to copy backup"
}

###Script usage- for wrong flag enetered
    usage ()  {
    echo "This scripts needs three flags with their values "
    echo "Example of correct usage is  ./rollback.sh -r runid -d HOME_DIR -b BACKUP_DIR"
    exit 87

}

### Assigning variables
    set_environment  () {
    echo "Checking and assigning variables"

    while getopts ":r:d:b:" opt
    do
        case "$opt" in
        r) RUNID="$OPTARG" ;;
        d) HOME_DIR="$OPTARG" ;;
		b) BACKUP_DIR="$OPTARG" ;;
       \?) echo "Wrong flag "
             usage ;;
    esac
    done
   }

################
###   MAIN   ###
################

    if [ $# -ne 6 ]; then
     usage
    fi
    echo "------------------------------------------------------------------------------"
    set_environment "$@"
        restore_safe_copies
    echo "------------------------------------------------------------------------------"

exit 0
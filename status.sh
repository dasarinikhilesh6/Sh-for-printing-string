#!/usr/bin/env bash
check_status () {
echo "$HOME_DIR"
ps -ef | grep -v grep | grep "$HOME_DIR/SoloSync" --color
number="$(ps -ef | grep -v grep | grep "$HOME_DIR/SoloSync" --color | awk '{print $2}' | wc -l)"
if [ "$number" -ge 2 ]
    then
        echo "-----------------------------------------------------------------------------"
        echo "Application started"
    else
        echo "-----------------------------------------------------------------------------"
        echo "Application not started"
		exit 87
        echo "End"
    exit
fi
}
###Script usage- for wrong flag entered
    usage ()  {
    echo "This script needs one flag with the value "
    echo "Example of correct usage is  ./status.sh -d HOME_DIR"
    exit 87

}

### Assigning variables
    set_environment  () {
    echo "Checking and assigning variables"

    while getopts ":d:" opt
    do
        case "$opt" in
        d) HOME_DIR="$OPTARG" ;;
       \?) echo "Wrong flag "
             usage ;;
    esac
    done
   }
   

################
###   MAIN   ###
################

    if [ $# -ne 2 ]; then
     usage
    fi
    echo "------------------------------------------------------------------------------"
    set_environment "$@"
        check_status
    echo "------------------------------------------------------------------------------"

exit 0
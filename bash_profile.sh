#!/bin/bash
### script to add PATH=$PATH:$HOME/.local/bin in bash profile
### Initial version - Nikhilesh
bash_profile () {
echo "grep \$HOME/.local/bin $HOME_DIR/.bash_profile"
grep \$HOME/.local/bin $HOME_DIR/.bash_profile
if [ $? = 0 ]
    then
        echo "Bash Profile with path \$PATH:\$HOME/.local/bin already exists"
    exit
    else
        echo "Bash Profile with path \$PATH:\$HOME/.local/bin doesn't exists"
        echo "Adding PATH=\$PATH:\$HOME/.local/bin in bash profile"
        echo "PATH=\$PATH:\$HOME/.local/bin" >> $HOME_DIR/.bash_profile
        source $HOME_DIR/.bash_profile      #To reload bash profile after updating it
fi
}
###Script usage- for wrong flag enetered
    usage ()  {
    echo "This script needs one flag with their values "
    echo "Example of correct usage is  ./bash_profile.sh -d HOME_DIR"
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
        bash_profile
    echo "------------------------------------------------------------------------------"

exit 0
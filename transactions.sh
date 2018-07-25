#!/usr/bin/env bash
##script to perform the following:
# - Collect transactions based on Transaction ID and move to staging location of primary server
collect_logs () {
echo "collecting transactions"
grep  -E $TRANSACTION_IDS $EM_MESSAGEEVENTS > $EM_LOG_PATH
echo "grep  -E $TRANSACTION_IDS $EM_MESSAGEEVENTS > $EM_LOG_PATH"
grep  -E $TRANSACTION_IDS $SSS_MESSAGEEVENTS > $SSS_LOG_PATH
echo "grep  -E $TRANSACTION_IDS $SSS_MESSAGEEVENTS > $SSS_LOG_PATH"
}
###Script usage- for wrong flag entered
    usage ()  {
    echo "This scripts needs five flags with the values "
    echo "Example of correct usage is  ./transactions.sh -t 'TRANSACTION_IDS|logTime' -e EM_LOG_PATH -s SSS_LOG_PATH -m EM_MESSAGEEVENTS -o SSS_MESSAGEEVENTS"
    exit 87

}

### Assigning variables
    set_environment  () {
    echo "Checking and assigning variables"

    while getopts ":t:e:s:m:o:" opt
    do
        case "$opt" in
        t) TRANSACTION_IDS="$OPTARG" ;;
        e) EM_LOG_PATH="$OPTARG" ;;
        s) SSS_LOG_PATH="$OPTARG" ;;
        m) EM_MESSAGEEVENTS="$OPTARG" ;;
        o) SSS_MESSAGEEVENTS="$OPTARG" ;;
       \?) echo "Wrong flag "
             usage ;;
    esac
    done
   }


################
###   MAIN   ###
################

    if [ $# -ne 10 ]; then
     usage
    fi
    echo "------------------------------------------------------------------------------"
    set_environment "$@"
        collect_logs
    echo "------------------------------------------------------------------------------"
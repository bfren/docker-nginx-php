#!/bin/bash

#======================================================================================================================
# Replace configuration values in a file.
#
# Arguments:
#   1   array of key/value pairs
#   2   path to the configuration file
#======================================================================================================================

replace () {

    # get array and file
    local -n A=${1}
    FILE=${2}

    # loop
    for KEY in ${!A[@]} ; do
        VAL=${A[$KEY]}
        if [ ! -z "${VAL}" ] ; then
            #bcg-echo " - ${KEY}=${VAL}"
            sed -i "s|^;\?${KEY}.*$|${KEY} = ${VAL}|i" ${FILE}
        fi
    done

}

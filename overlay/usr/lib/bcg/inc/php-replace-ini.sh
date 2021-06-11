#!/bin/bash


#======================================================================================================================
# Replace configuration values in a file.
#
# Arguments
#   1   name of array of key/value pairs
#   2   path to the configuration file
#======================================================================================================================

replace-ini () {

    # get array and file
    local -n A=${1}
    FILE=${2}

    bf-debug "Replacing configuration values in ${FILE}."

    # loop
    for KEY in ${!A[@]} ; do
        VAL=${A[$KEY]}
        if [ ! -z "${VAL}" ] ; then
            bf-debug "${KEY}=${VAL}." "replace-ini"
            sed -i "s|^;\?${KEY}.*$|${KEY} = ${VAL}|i" ${FILE}
        fi
    done

}

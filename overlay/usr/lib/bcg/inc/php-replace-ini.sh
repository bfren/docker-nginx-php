#!/bin/sh

set -euo pipefail


#======================================================================================================================
# Replace configuration values in a file.
#
# Arguments:
#   1   name of array of key/value pairs
#   2   path to the configuration file
#======================================================================================================================

replace-ini () {

    # get array and file
    local -n ARR=${1}
    FILE=${2}

    # loop
    for KEY in ${!A[@]} ; do
        VAL=${ARR[$KEY]}
        if [ ! -z "${VAL}" ] ; then
            bcg-debug "${KEY}=${VAL}." "replace-ini"
            sed -i "s|^;\?${KEY}.*$|${KEY} = ${VAL}|i" ${FILE}
        fi
    done

}

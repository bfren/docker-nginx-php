#!/bin/bash

replace () {

    # get array and file
    local -n A=$1
    FILE=$2

    # loop
    for KEY in "${!A[@]}"; do
        VAL="${A[$KEY]}"
        if [ ! -z "$VAL" ] ; then
            sed -i "s|^;\?$KEY.*$|$KEY = $VAL|i" "$FILE"
        fi
    done

}

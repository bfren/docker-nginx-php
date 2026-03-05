use bf

# Get php.ini override values
export def get_override_values []: nothing -> record {
    # get variables
    let ini_override = bf env PHP_INI_OVERRIDE_D

    # if the override path does not exist return nothing
    if not ($ini_override | path exists) {
        return
    }

    # load override json files,
    #   sorted alphabetically
    #   read as json
    #   reduce array so later values override earlier values
    return $"($ini_override)/*.json"
        | into glob
        | ls --full-paths $in
        | get name
        | sort --natural
        | each {|x| bf fs read $x | from json }
        | reduce {|it, acc| $acc | merge $it }
        | into record
}

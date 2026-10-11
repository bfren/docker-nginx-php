use bf

# Get override values for php.ini or www.conf
export def get_values [
    override_d: string    # path to directory containing json override files
]: nothing -> record {
    # if the override path does not exist return nothing
    if ($override_d | bf fs is_not_dir) {
        return {}
    }

    # load override json files,
    #   sorted alphabetically
    #   read as json
    #   reduce array so later values override earlier values
    let override_values = $"($override_d)/*.json"
        | into glob
        | ls --full-paths $in
        | get name
        | sort --natural
        | each {|x| bf fs read $x | from json }
        | reduce {|it, acc| $acc | merge $it }
        | sort --natural
        | into record

    return $override_values
}

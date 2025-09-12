use bf
use bf-php
bf env load

# Apply any overrides to php.ini
export def main [] {
    # load any override files and apply them
    let ini_override = bf env PHP_INI_OVERRIDE_D
    if ($ini_override | path exists) { $"($ini_override)/*.json" | into glob | ls --full-paths $in | get name | sort | each {|x|
        let override_values = bf fs read $x | from json
        bf-php ini $override_values
    } }

    # return nothing
    return
}

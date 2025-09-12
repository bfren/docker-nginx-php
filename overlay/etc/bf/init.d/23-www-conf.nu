use bf
use bf-php
bf env load

# Apply any overrides to www.conf
export def main [] {
    # PHP-FPM configuration file
    let fpm_conf = bf env PHP_FPM_CONF

    # load any override files and apply them
    let fpm_override = bf env PHP_FPM_OVERRIDE_D
    if ($fpm_override | path exists) { $"($fpm_override)/*.json" | into glob | ls --full-paths $in | get name | sort | each {|x|
        let override_values = bf fs read $x | from json
        bf-php ini insert_or_replace_values_in_file $fpm_conf $override_values
    } }
}

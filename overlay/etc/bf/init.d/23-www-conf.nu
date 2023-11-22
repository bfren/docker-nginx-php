use bf
use bf-php
bf env load

# Setup www.conf
export def main [] {
    # set user / group to www
    let fpm_conf = bf env PHP_FPM_CONF
    let www = "www"
    bf-php ini replace_values_in_file $fpm_conf {user: $www, group: $www}

    # if there is an override file, use it
    let override_file = bf env PHP_FPM_OVERRIDE
    let override_values = if ($override_file | path exists) { bf fs read $override_file | from json }
    bf-php ini replace_values_in_file $fpm_conf $override_values
}

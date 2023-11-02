use bf
use bf-php
bf env load

# Download and setup php.ini
export def main [] {
    # if there is an override file, use it - otherwise use defaults
    let override_file = bf env PHP_FPM_OVERRIDE
    let override_values = if ($override_file | path exists) { bf fs read $override_file | from json }

    # apply override values to www.conf file
    bf-php ini replace_values_in_file $"(bf env PHP_FPM_CONF)" $override_values
}

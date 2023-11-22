use bf
use bf-php
bf env load

# Download and setup php.ini
export def main [] {
    # if there is an override file, use it - otherwise use defaults
    let override_file = bf env PHP_INI_OVERRIDE
    let override_values = if ($override_file | path exists) { bf fs read $override_file | from json }

    # download php.ini file and apply override values
    bf-php ini $override_values
}

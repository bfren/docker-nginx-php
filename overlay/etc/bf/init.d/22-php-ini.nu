use bf
use bf-nginx-php
use bf-php
bf env load

# Apply any overrides to php.ini
export def main [] {
    # get ini override values
    let values = bf env PHP_INI_OVERRIDE_D
        | bf-nginx-php override get_values $in

    # download specified php.ini file and apply any override values
    bf-php ini $values

    # return nothing
    return
}

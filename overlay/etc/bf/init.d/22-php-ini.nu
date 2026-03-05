use bf
use bf-nginx-php
use bf-php
bf env load

# Apply any overrides to php.ini
export def main [] {
    # get ini override values
    let override_values = bf-nginx-php ini get_override_values

    # download specified php.ini file and apply any override values
    bf-php ini $override_values

    # return nothing
    return
}

use bf
use bf-nginx-php
use bf-php
bf env load

# Apply any overrides to www.conf
export def main [] {
    # set user / group to www by default
    let www = "www"
    let user_group = {user: $www, group: $www}

    # get conf override values
    let override = bf env PHP_FPM_OVERRIDE_D
        | bf-nginx-php override get_values $in

    # merge overrides and update www.conf
    let file = bf env PHP_FPM_CONF
    let values = $user_group | merge $override
    bf-php ini insert_or_replace_values_in_file $file $values

    # return nothing
    return
}

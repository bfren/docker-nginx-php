use bf
bf env load

# Set environment variables
def main [] {
    let ini_override = $"(bf env ETC)/php.d"
    let fpm_override = $"(bf env ETC)/php-fpm.d"
    bf env set PHP_INI_OVERRIDE_D $ini_override
    bf env set PHP_FPM_OVERRIDE_D $fpm_override

    let fpm_d = $"(bf env PHP_DIR)/php-fpm.d"
    bf env set PHP_FPM_D $fpm_d
    bf env set PHP_FPM_CONF $"($fpm_d)/www.conf"

    # return nothing
    return
}

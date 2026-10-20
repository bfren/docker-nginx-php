use std/assert
use ../bf-nginx-php/conf.nu *


#======================================================================================================================
# installation
#======================================================================================================================

export def install__php_fpm_is_a_symlink_to_versioned_executable [] {
    let target = ^readlink /usr/sbin/php-fpm | str trim

    assert (("/usr/sbin/php-fpm" | path type) == "symlink") "/usr/sbin/php-fpm should be a symlink"
    assert ($target =~ '^(/usr/sbin/)?php-fpm[0-9]+$') $"/usr/sbin/php-fpm should link to a versioned PHP-FPM executable, not ($target)"
}

export def install__session_and_opcache_extensions_are_loaded [] {
    let modules = ^php -m | lines | str trim

    assert ("session" in $modules) "the session extension should be loaded"
    assert ("Zend OPcache" in $modules) "OPcache should be loaded"
}


#======================================================================================================================
# conf
#======================================================================================================================

export def test__default_configuration_is_valid [] {
    # 'php-fpm -t' fails, and bf handle throws an error, if the configuration is invalid
    test
}

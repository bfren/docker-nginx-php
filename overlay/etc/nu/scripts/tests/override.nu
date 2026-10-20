use std/assert
use ../bf-nginx-php/override.nu *


#======================================================================================================================
# get_values
#======================================================================================================================

export def get_values__directory_does_not_exist__returns_empty_record [] {
    let result = get_values "/tmp/does-not-exist-bf-nginx-php"

    assert equal {} $result
}

export def get_values__merges_files_in_natural_order [] {
    let dir = mktemp --directory
    {a: "1", b: "1", c: "1"} | to json | save $"($dir)/2-first.json"
    {b: "2", c: "2"} | to json | save $"($dir)/10-second.json"
    {c: "3"} | to json | save $"($dir)/20-third.json"

    let result = get_values $dir
    rm --recursive --force $dir

    assert equal {a: "1", b: "2", c: "3"} $result "later files (in natural order, so 10 after 2) should override earlier ones"
}

export def get_values__image_defaults_are_valid [] {
    let php_ini = get_values "/etc/bf/php.d"
    let www_conf = get_values "/etc/bf/php-fpm.d"

    assert equal "256M" $php_ini.memory_limit
    assert equal "1" ($php_ini | get "session.cookie_secure")
    assert equal "yes" $www_conf.clear_env
}

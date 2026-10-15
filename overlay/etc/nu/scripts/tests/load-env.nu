use std/assert
use ../bf-nginx-php/load-env.nu


#======================================================================================================================
# main
#======================================================================================================================

export def main__appends_env_lines_to_www_conf [] {
    let conf = mktemp
    "[www]\nuser = www\n" | save --force $conf

    let variables = [
        {key: "BF_PHP_DB_HOST", override: null}
        {key: "BF_PHP_SECRET", override: "APP_SECRET"}
    ]
    with-env {BF_PHP_FPM_CONF: $conf} { load-env $variables }
    let result = open --raw $conf | lines
    rm --force $conf

    assert equal "user = www" ($result | get 1) "existing configuration should be kept"
    assert ($result | any {|x| $x == "env[BF_PHP_DB_HOST] = $BF_PHP_DB_HOST" }) "variable should be passed by its own name"
    assert ($result | any {|x| $x == "env[APP_SECRET] = $BF_PHP_SECRET" }) "override should set the name PHP sees"
}

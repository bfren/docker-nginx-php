use bf
use override.nu

# Clean sessions as user www
export def clean [] {
    # load environment
    bf env load

    # get session max lifetime (if set)
    let max_lifetime = bf env PHP_INI_OVERRIDE_D
        | override get_values $in
        | default 86400 session.gc_maxlifetime

    # hat-tip https://www.getpagespeed.com/server-setup/php/cleanup-php-sessions-like-a-pro
    let args = [
        "-d" "session.gc_probability=1"
        "-d" "session.gc_divisor=1"
        "-d" $"session.gc_maxlifetime=($max_lifetime)"
        "-r" "\"session_start(); session_destroy();\""
    ]

    # run as user www
    let code = { ^s6-setuidgid www php ...$args } | bf handle -c sessions/clean
    if $code != 0 { exit $code }
}

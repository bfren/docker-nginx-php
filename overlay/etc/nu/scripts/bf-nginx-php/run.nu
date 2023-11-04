use bf
use conf.nu

export def preflight [] {
    # load environment
    bf env load

    # manually set executing script
    bf env x_set --override run php-fpm

    # Test PHP FPM configuration
    conf test

    # if we get here we are ready to start PHP FPM
    bf write "Starting PHP FPM in foreground mode."
}

use bf

export def preflight [] {
    # load environment
    bf env load

    # manually set executing script
    bf env x_set --override run php-fpm

    # if we get here we are ready to start PHP
    bf write "Starting PHP in foreground mode."
}

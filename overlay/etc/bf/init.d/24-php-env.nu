use bf
use bf-nginx-php
use bf-php
bf env load

# Load PHP environment variables into FPM config
export def main [] {
    # check loading is enabled
    if not (bf env check PHP_LOAD_ENV) {
        bf write debug "Not loading BF_PHP_* environment variables into FPM config."
        return
    }

    # generate list of environment variables to insert
    bf write "Loading BF_PHP_* environment variables into FPM config."
    let variables = $env
        | transpose key value
        | where {|x| $x.key | str starts-with "BF_PHP_" }
        | select key override?
        | sort --natural

    # append variables to configuration file
    bf-nginx-php load-env $variables

    # return nothing
    return
}

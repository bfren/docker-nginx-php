use bf

# Load environment variables into PHP FPM processes
export def main [
    variables: list<string>     # list of environment variables to load into PHP FPM
]: nothing -> nothing {
    let conf = bf env PHP_FPM_CONF
    $variables
        | each {|k| $"env[($k)] = $($k)" }
        | prepend "[www]"
        | str join "\n"
        | echo $"\n($in)\n"
        | save --append --force $conf
}

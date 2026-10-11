use bf

# Load environment variables into PHP FPM processes
export def main [
    variables: table    # environment variables (key, override?) to load into PHP FPM
]: nothing -> nothing {
    let conf = bf env PHP_FPM_CONF
    $variables
        | each {|v| $"env[($v.key)] = $($v.override | default $v.key)" }
        | prepend "[www]"
        | str join "\n"
        | echo $"\n($in)\n"
        | save --append --force $conf
}

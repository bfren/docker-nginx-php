use bf
bf env load

# Install requested extensions
def main [] {
    # get requested extensions
    let extensions = bf env safe PHP_EXT
    if $extensions == null {
        bf write debug "No extensions requested for installation."
        return
    }

    # get prefix and PHP version from build log
    let prefix = bf env PHP_PREFIX
    let version = bf build | get "PHP"

    # split list of extensions by space, build and install list of packages
    let packages = $extensions | split row " " | each {|x| $"($prefix)-($x)=($version)" }
    bf pkg install $packages

    # return nothing
    return
}

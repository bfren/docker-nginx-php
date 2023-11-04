use bf

# Install a list of PHP extensions
export def install [
    extensions: list<string>    # List of extensions to install - PHP prefix and build version will be added
] {
    # get prefix and PHP version from build log
    let prefix = bf env PHP_PREFIX
    let version = bf build | get "PHP"

    # build and install list of packages
    let packages = $extensions | each {|x| $"($prefix)-($x)=($version)" }
    bf pkg install $packages
}

use bf
use bf-php
bf env load

# Install requested extensions
def main [] {
    # get requested extensions
    let extensions = bf env --safe PHP_EXT
    if $extensions == null {
        bf write debug "No extensions requested for installation."
        return
    }

    # split list of extensions by space and install
    bf-php ext install ($extensions | split row " ")

    # return nothing
    return
}

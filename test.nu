#!/usr/bin/env -S nu -n

use ../index/test.nu

const php_branches = [
    "8.2"
    "8.3"
    "8.4"
    "8.5"
]

# Run test suite for image
def main [
    php: string = "8.5"     # define which PHP version to use
    --all (-a)              # test all registered versions of PHP (overrides $php)
] {
    let branches = if $all { $php_branches } else { [$php] }
    test "nginx-php" $branches
}

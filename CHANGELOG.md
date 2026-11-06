# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [10.0.1] - 2026-11-06

### Changed

- Base image updated to `bfren/nginx` 9.0.1, which moves to Alpine 3.22.8 and 3.24.4 (with security fixes) and
  rebuilds BusyBox, figlet and Nushell - see the
  [Nginx changelog](https://github.com/bfren/docker-nginx/blob/main/CHANGELOG.md).
- The PHP overlay is updated to `bfren/php` 4.0.1, which makes no changes to the overlay - see the
  [PHP changelog](https://github.com/bfren/docker-php/blob/main/CHANGELOG.md).

## [10.0.0] - 2026-11-05

### Changed

- **Breaking:** base image updated to `bfren/nginx` 9.0.0 - see the
  [Nginx changelog](https://github.com/bfren/docker-nginx/blob/main/CHANGELOG.md).
  `bf env set` must now run as root.
- Images are built and published by the shared `bfren/docker` build workflow (`build.yml`), replacing the separate
  `dev.yml` and `publish.yml` workflows.

[10.0.1]: https://github.com/bfren/docker-nginx-php/compare/v10.0.0...v10.0.1
[10.0.0]: https://github.com/bfren/docker-nginx-php/compare/v9.1.1...v10.0.0

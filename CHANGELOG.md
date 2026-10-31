# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [10.0.0] - Unreleased

### Changed

- **Breaking:** base image updated to `bfren/nginx` 9.0.0 - see the
  [Nginx changelog](https://github.com/bfren/docker-nginx/blob/main/CHANGELOG.md).
  `bf env set` must now run as root.
- Images are built and published by the shared `bfren/docker` build workflow (`build.yml`), replacing the separate
  `dev.yml` and `publish.yml` workflows.

[10.0.0]: https://github.com/bfren/docker-nginx-php/compare/v9.1.1...v10.0.0

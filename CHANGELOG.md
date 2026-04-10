# xinetd Cookbook CHANGELOG

## [3.0.0](https://github.com/sous-chefs/xinetd/compare/v2.1.4...v3.0.0) (2026-04-10)


### ⚠ BREAKING CHANGES

* full custom resource migration ([#31](https://github.com/sous-chefs/xinetd/issues/31))

### Features

* full custom resource migration ([#31](https://github.com/sous-chefs/xinetd/issues/31)) ([c803913](https://github.com/sous-chefs/xinetd/commit/c80391350ae2ef806064fb685a1b0fcb910978b0))


### Bug Fixes

* **ci:** Update release job ([2160023](https://github.com/sous-chefs/xinetd/commit/2160023e89feb08d816c6daaf588425f9bf712a8))
* **ci:** Update workflows to use release pipeline ([#28](https://github.com/sous-chefs/xinetd/issues/28)) ([c0fb6fd](https://github.com/sous-chefs/xinetd/commit/c0fb6fd8d757670432db9e8995a351facd14df92))

## [2.1.4](https://github.com/sous-chefs/xinetd/compare/2.1.3...v2.1.4) (2025-10-16)


### Bug Fixes

* **ci:** Update workflows to use release pipeline ([#28](https://github.com/sous-chefs/xinetd/issues/28)) ([c0fb6fd](https://github.com/sous-chefs/xinetd/commit/c0fb6fd8d757670432db9e8995a351facd14df92))

## 2.1.0 - *2023-10-03*

* Remove CircleCI config
* Switch from Delivery to reusable workflows
* Update standardfiles

## 2.0.0 - *2021-11-02*

* Sous Chefs Adoption
* Migrate to custom resource and enabled unified_mode
* Require Chef >= 15.3
* Add ChefSpec & InSpec tests
* Fix service name for tcpmux-server

## 1.0.2 - *2017-02-26*

* Suppress warning already initialized constant
* Update xinetd service attribute key name
* bugfix: Respect enabled attribute for stream services

## 1.0.1 - *2015-01-16*

* Load template from xinetd cookbook unless explicitly overridden.
* Fix foodcritic errors and add basic TravisCI configuration

# xinetd Cookbook CHANGELOG

## Unreleased

- resolved cookstyle error: .delivery/project.toml:2:8 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:4:10 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:5:13 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:6:10 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:7:9 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:8:14 convention: `Style/StringLiterals`
- resolved cookstyle error: .delivery/project.toml:9:11 convention: `Style/StringLiterals`
## 2.0.0 - *2021-11-02*

- Sous Chefs Adoption
- Migrate to custom resource and enabled unified_mode
- Require Chef >= 15.3
- Add ChefSpec & InSpec tests
- Fix service name for tcpmux-server

## 1.0.2 - *2017-02-26*

- Suppress warning already initialized constant
- Update xinetd service attribute key name
- bugfix: Respect enabled attribute for stream services

## 1.0.1 - *2015-01-16*

- Load template from xinetd cookbook unless explicitly overridden.
- Fix foodcritic errors and add basic TravisCI configuration

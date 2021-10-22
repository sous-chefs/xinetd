# 1.0.1

## Unreleased

- resolved cookstyle error: libraries/matchers.rb:1:1 convention: `Style/Encoding`
- resolved cookstyle error: libraries/matchers.rb:3:1 refactor: `Chef/Modernize/DefinesChefSpecMatchers`
- resolved cookstyle error: libraries/matchers.rb:11:1 convention: `Layout/TrailingEmptyLines`
- resolved cookstyle error: metadata.rb:4:18 refactor: `Chef/Sharing/InvalidLicenseString`
- resolved cookstyle error: metadata.rb:6:1 refactor: `Chef/RedundantCode/LongDescriptionMetadata`
- resolved cookstyle error: metadata.rb:14:1 refactor: `Chef/Modernize/RespondToInMetadata`
- resolved cookstyle error: providers/service.rb:1:1 warning: `Chef/Deprecations/UseInlineResourcesDefined`
- resolved cookstyle error: recipes/default.rb:2:1 refactor: `Chef/Style/CommentFormat`
- resolved cookstyle error: recipes/default.rb:5:1 refactor: `Chef/Style/CommentFormat`

* Load template from xinetd cookbook unless explicitly overridden.
* Fix foodcritic errors and add basic TravisCI configuration

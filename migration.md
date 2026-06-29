# Migration Guide

This release completes the cookbook cleanup around the custom resource migration. The resource
API is the supported interface, and the test and platform coverage now exercise that path directly.

## Migration Path

Consumers still carrying older recipe or attribute usage should declare xinetd state explicitly
with resources:

| Old API | New API |
|---------|---------|
| `include_recipe 'xinetd'` | `xinetd_install` and `xinetd_config` |
| `include_recipe 'xinetd::default'` | `xinetd_install` and `xinetd_config` |
| `node['xinetd']['defaults']` | Properties on `xinetd_config` |
| Builtin service attributes | Properties on `xinetd_builtin_services` |
| Service definition recipe logic | `xinetd_service` resources |

## Basic Resource Usage

Use explicit install and config resources:

```ruby
xinetd_install 'default'

xinetd_config 'default' do
  log_type 'SYSLOG daemon info'
  cps '50 10'
  instances '50'
end
```

## Service Definitions

Declare service files directly:

```ruby
xinetd_service 'discard-stream' do
  service_name 'discard'
  id 'discard-stream'
  type 'INTERNAL'
  wait false
  socket_type 'stream'
  action :enable
end
```

Use `action :disable` to render the file with `disable = yes`, or `action :delete` to remove the
service definition from `/etc/xinetd.d/`.

## Builtin Services

Use `xinetd_builtin_services` for the standard INTERNAL services:

```ruby
xinetd_builtin_services 'default' do
  chargen_stream_enabled false
  chargen_dgram_enabled false
  tcpmux_server_enabled false
end
```

## Test Cookbook Examples

The migration examples used by Kitchen live under `test/cookbooks/test/recipes/`:

* `default.rb` installs xinetd and renders the main configuration.
* `builtin_services.rb` installs xinetd, renders the main configuration, and manages builtin
  INTERNAL services.

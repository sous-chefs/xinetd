# xinetd_service

Manages an xinetd service definition in `/etc/xinetd.d/`. Creates or updates the service configuration file from the `service.erb` template and notifies xinetd to reload.

## Actions

| Action     | Description                                                                                               |
|------------|-----------------------------------------------------------------------------------------------------------|
| `:enable`  | **Default.** Creates the service definition file with `disable = no` and starts xinetd.                   |
| `:disable` | Creates the service definition file with `disable = yes`. xinetd remains running but ignores the service. |
| `:delete`  | Removes the service definition file from `/etc/xinetd.d/` and reloads xinetd.                             |

## Properties

| Property       | Type     | Default       | Description                                                                                |
|----------------|----------|---------------|--------------------------------------------------------------------------------------------|
| `service_name` | `String` | Resource name | Name of the xinetd service (name property). Also used as the filename in `/etc/xinetd.d/`. |
| `cookbook`     | `String` | `'xinetd'`    | Cookbook to source the `service.erb` template from.                                        |

Additionally, the following xinetd service options are available as properties.
All are optional and accept the Ruby-native type
(`true`/`false` for boolean options, `String` for text, `Array` for multi-value options):

`id`, `type`, `flags`, `socket_type`, `protocol`, `wait`, `user`, `group`,
`instances`, `nice`, `server`, `server_args`, `libwrap`, `only_from`, `no_access`,
`access_times`, `log_type`, `log_on_success`, `log_on_failure`, `rpc_version`,
`rpc_number`, `env`, `passenv`, `port`, `redirect`, `bind`, `interface`, `banner`,
`banner_success`, `banner_failure`, `per_source`, `cps`, `max_load`, `groups`,
`mdns`, `umask`, `enabled`, `rlimit_as`, `rlimit_files`, `rlimit_cpus`,
`rlimit_data`, `rlimit_rss`, `rlimit_stack`, `deny_time`

Boolean values (`true`/`false`) are automatically converted to `yes`/`no` in the rendered configuration. Arrays are joined with a space.

## Examples

### Enable an INTERNAL echo service

```ruby
xinetd_service 'echo-stream' do
  service_name 'echo'
  id 'echo-stream'
  type 'INTERNAL'
  wait false
  socket_type 'stream'
  action :enable
end
```

### Enable a real service with a server path

```ruby
xinetd_service 'rsync' do
  server '/usr/bin/rsync'
  server_args '--daemon --no-detach'
  socket_type 'stream'
  wait false
  user 'root'
  only_from '192.168.1.0/24'
  action :enable
end
```

### Disable a service

```ruby
xinetd_service 'echo-stream' do
  service_name 'echo'
  action :disable
end
```

### Delete a service definition

```ruby
xinetd_service 'echo-stream' do
  service_name 'echo'
  action :delete
end
```

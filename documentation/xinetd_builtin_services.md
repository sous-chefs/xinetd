# xinetd_builtin_services

Manages xinetd builtin (INTERNAL) services: chargen, daytime, discard, echo, time, and tcpmux-server.

## Actions

| Action    | Description |
|-----------|-------------|
| `:create` | **Default.** Creates, enables, or disables builtin service definitions based on their enabled properties. |
| `:delete` | Removes all builtin service definitions from `/etc/xinetd.d/`. |

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `instance` | String | name_property | Instance name (used as the resource name) |
| `chargen_stream_enabled` | True, False | `true` | Enable chargen-stream builtin service |
| `chargen_dgram_enabled` | True, False | `true` | Enable chargen-dgram builtin service |
| `daytime_stream_enabled` | True, False | `true` | Enable daytime-stream builtin service |
| `daytime_dgram_enabled` | True, False | `true` | Enable daytime-dgram builtin service |
| `discard_stream_enabled` | True, False | `true` | Enable discard-stream builtin service |
| `discard_dgram_enabled` | True, False | `true` | Enable discard-dgram builtin service |
| `echo_stream_enabled` | True, False | `true` | Enable echo-stream builtin service |
| `echo_dgram_enabled` | True, False | `true` | Enable echo-dgram builtin service |
| `time_stream_enabled` | True, False | `true` | Enable time-stream builtin service |
| `time_dgram_enabled` | True, False | `true` | Enable time-dgram builtin service |
| `tcpmux_server_enabled` | True, False | `true` | Enable tcpmux-server builtin service |

## Examples

### Enable all builtin services with defaults

```ruby
xinetd_builtin_services 'default'
```

### Disable specific services

```ruby
xinetd_builtin_services 'default' do
  chargen_stream_enabled false
  chargen_dgram_enabled false
  tcpmux_server_enabled false
end
```

### Disable all services

```ruby
xinetd_builtin_services 'default' do
  chargen_stream_enabled false
  chargen_dgram_enabled false
  daytime_stream_enabled false
  daytime_dgram_enabled false
  discard_stream_enabled false
  discard_dgram_enabled false
  echo_stream_enabled false
  echo_dgram_enabled false
  time_stream_enabled false
  time_dgram_enabled false
  tcpmux_server_enabled false
end
```

### Delete all builtin service definitions

```ruby
xinetd_builtin_services 'default' do
  action :delete
end
```

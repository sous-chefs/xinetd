# xinetd_config

Configures xinetd: creates `/etc/xinetd.d/`, renders `/etc/xinetd.conf` from the `xinetd.conf.erb` template, and manages the `xinetd` service.

## Actions

| Action    | Description                                                                 |
|-----------|-----------------------------------------------------------------------------|
| `:create` | **Default.** Creates `/etc/xinetd.d/`, renders `/etc/xinetd.conf`, enables and starts the `xinetd` service. |
| `:delete` | Stops and disables the `xinetd` service, removes `/etc/xinetd.conf`, and deletes `/etc/xinetd.d/`. |

## Properties

| Property        | Type                 | Default                   | Description |
|-----------------|----------------------|---------------------------|-------------|
| `instance`      | `String`             | Resource name             | Instance name (name property). |
| `cookbook`      | `String`             | `'xinetd'`                | Cookbook to source the `xinetd.conf.erb` template from. |
| `log_type`      | `String`, `nil`      | `'SYSLOG daemon info'`    | xinetd `log_type` value in the `defaults` block. |
| `bind`          | `String`, `nil`      | `nil`                     | xinetd `bind` value. |
| `per_source`    | `String`, `nil`      | `'10'`                    | xinetd `per_source` value. |
| `umask`         | `String`, `nil`      | `'002'`                   | xinetd `umask` value. |
| `log_on_success`| `String`, `nil`      | `'PID HOST DURATION EXIT'`| xinetd `log_on_success` value. |
| `log_on_failure`| `String`, `nil`      | `'HOST'`                  | xinetd `log_on_failure` value. |
| `v6only`        | `true`, `false`, `nil` | `false`                 | xinetd `v6only` value. |
| `only_from`     | `String`, `nil`      | `nil`                     | xinetd `only_from` value. |
| `no_access`     | `String`, `nil`      | `nil`                     | xinetd `no_access` value. |
| `passenv`       | `String`, `nil`      | `nil`                     | xinetd `passenv` value. |
| `instances`     | `String`, `nil`      | `'50'`                    | xinetd `instances` value. |
| `disabled`      | `String`, `nil`      | `nil`                     | Space-separated list of services to disable globally. |
| `enabled`       | `String`, `nil`      | `nil`                     | Space-separated list of services to enable globally. |
| `banner`        | `String`, `nil`      | `nil`                     | xinetd `banner` value. |
| `banner_success`| `String`, `nil`      | `nil`                     | xinetd `banner_success` value. |
| `banner_fail`   | `String`, `nil`      | `nil`                     | xinetd `banner_fail` value. |
| `groups`        | `true`, `false`, `nil` | `true`                  | xinetd `groups` value. |
| `cps`           | `String`, `nil`      | `'50 10'`                 | xinetd `cps` value. |
| `max_load`      | `String`, `nil`      | `nil`                     | xinetd `max_load` value. |

## Examples

### Create with all defaults

```ruby
xinetd_config 'default'
```

### Create with custom log settings

```ruby
xinetd_config 'default' do
  log_type 'FILE /var/log/xinetd.log'
  log_on_success 'PID HOST DURATION EXIT'
  log_on_failure 'HOST ATTEMPT'
  cps '100 20'
  instances '100'
end
```

### Delete xinetd configuration

```ruby
xinetd_config 'default' do
  action :delete
end
```

# xinetd cookbook

[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

## Description

This cookbook provides custom resources for installing, configuring, and managing
the xinetd extended internet services daemon. See [AGENTS.md](AGENTS.md) for
platform availability details and [migration.md](migration.md) for the
custom-resource migration guide.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working
together to maintain important cookbooks. If you'd like to know more please visit
[sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in
[#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

| Platform      | Versions             |
|---------------|----------------------|
| AlmaLinux     | 8                    |
| Debian        | 12, 13               |
| Oracle Linux  | 8                    |
| Rocky Linux   | 8                    |
| Ubuntu        | 22.04 LTS, 24.04 LTS |

See [AGENTS.md](AGENTS.md) for architecture, package availability, and legacy platform details.

### Chef Version

Chef 15.3+

## Resources

### xinetd_install

Installs or removes the `xinetd` package. See [documentation/xinetd_install.md](documentation/xinetd_install.md).

```ruby
xinetd_install 'default'
```

### xinetd_config

Configures xinetd: creates `/etc/xinetd.d/`, renders `/etc/xinetd.conf`, and manages the `xinetd`
service. See [documentation/xinetd_config.md](documentation/xinetd_config.md).

```ruby
xinetd_config 'default' do
  log_type 'SYSLOG daemon info'
  cps '50 10'
  instances '50'
end
```

### xinetd_service

Manages an xinetd service definition in `/etc/xinetd.d/`.
See [documentation/xinetd_service.md](documentation/xinetd_service.md).

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

Boolean property values (`true`/`false`) are automatically rendered as `yes`/`no`.
Array values are joined with a space.

### xinetd_builtin_services

Manages xinetd builtin (INTERNAL) services: chargen, daytime, discard, echo, time, and tcpmux-server.
See [documentation/xinetd_builtin_services.md](documentation/xinetd_builtin_services.md).

```ruby
xinetd_builtin_services 'default'
```

To disable specific services:

```ruby
xinetd_builtin_services 'default' do
  chargen_stream_enabled false
  chargen_dgram_enabled false
  tcpmux_server_enabled false
end
```

## Author

Author:: Steven Danna

## Contributors

This project exists thanks to all the people who
[contribute.](https://opencollective.com/sous-chefs/contributors.svg?width=890&button=false)

### Backers

Thank you to all our backers!

![https://opencollective.com/sous-chefs#backers](https://opencollective.com/sous-chefs/backers.svg?width=600&avatarHeight=40)

### Sponsors

Support this project by becoming a sponsor. Your logo will show up here with a link to your website.

![https://opencollective.com/sous-chefs/sponsor/0/website](https://opencollective.com/sous-chefs/sponsor/0/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/1/website](https://opencollective.com/sous-chefs/sponsor/1/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/2/website](https://opencollective.com/sous-chefs/sponsor/2/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/3/website](https://opencollective.com/sous-chefs/sponsor/3/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/4/website](https://opencollective.com/sous-chefs/sponsor/4/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/5/website](https://opencollective.com/sous-chefs/sponsor/5/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/6/website](https://opencollective.com/sous-chefs/sponsor/6/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/7/website](https://opencollective.com/sous-chefs/sponsor/7/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/8/website](https://opencollective.com/sous-chefs/sponsor/8/avatar.svg?avatarHeight=100)
![https://opencollective.com/sous-chefs/sponsor/9/website](https://opencollective.com/sous-chefs/sponsor/9/avatar.svg?avatarHeight=100)

# xinetd cookbook

[![Cookbook Version](https://img.shields.io/cookbook/v/selnux.svg)](https://supermarket.chef.io/cookbooks/xinetd)
[![CI State](https://github.com/sous-chefs/xinetd/workflows/ci/badge.svg)](https://github.com/sous-chefs/xinetd/actions?query=workflow%3Aci)
[![OpenCollective](https://opencollective.com/sous-chefs/backers/badge.svg)](#backers)
[![OpenCollective](https://opencollective.com/sous-chefs/sponsors/badge.svg)](#sponsors)
[![License](https://img.shields.io/badge/License-Apache%202.0-green.svg)](https://opensource.org/licenses/Apache-2.0)

## Description

This cookbook installs and configures the xinetd internet service daemon. It also provides an LWRP for managing xinetd
services.

## Maintainers

This cookbook is maintained by the Sous Chefs. The Sous Chefs are a community of Chef cookbook maintainers working
together to maintain important cookbooks. If you’d like to know more please visit
[sous-chefs.org](https://sous-chefs.org/) or come chat with us on the Chef Community Slack in
[#sous-chefs](https://chefcommunity.slack.com/messages/C2V7B88SF).

## Requirements

### Platforms

This cookbook has been tested on Centos and Ubuntu.

## Chef Version

Chef 15.3+

# Resources

## xinetd_service

The xinetd_service resource allows you to define and enable xinetd
services.  For example:

```ruby
xinetd_service "discard" do
  id "discard-stream"
  type "INTERNAL"
  wait false
  socket_type "stream"
  action :enable
end
```

All options supported in xinetd 2.3.14 are currently supported by this
provider.

Note that no type checking is done for attribute values.  Values are
rendered directly into the xinetd configuration file for that
service.  Array's are coerced to space separated strings while `true`
and `false` are converted to "yes" and "no", respectively.

The `xinetd_service` provider will attempt to relaod the xinetd
service. Including this cookbooks default recipe before using it will
ensure that such a service exists.

# Attributes

The default recipe uses the following attributes to render the default
xinetd.conf configuration block.  See xinetd.conf(5) for their
meanings.  Boolean values are translated to "yes" and "no" before
being rendered and Array's are coerced to space separated strings.
Currently, the default attribute values are taken from the example
configuration in the xinetd source repository.

* `default['xinetd']['defaults']['log_type']`
* `default['xinetd']['defaults']['bind']`
* `default['xinetd']['defaults']['per_source']`
* `default['xinetd']['defaults']['umask']`
* `default['xinetd']['defaults']['log_on_success']`
* `default['xinetd']['defaults']['log_on_failure']`
* `default['xinetd']['defaults']['v6only']`
* `default['xinetd']['defaults']['only_from']`
* `default['xinetd']['defaults']['no_access']`
* `default['xinetd']['defaults']['passenv']`
* `default['xinetd']['defaults']['instances']`
* `default['xinetd']['defaults']['disabled']`
* `default['xinetd']['defaults']['enabled']`
* `default['xinetd']['defaults']['banner']`
* `default['xinetd']['defaults']['banner_success']`
* `default['xinetd']['defaults']['banner_fail']`
* `default['xinetd']['defaults']['groups']`
* `default['xinetd']['defaults']['cps']`
* `default['xinetd']['defaults']['max_load']`

The builtin_services recipe uses the following attributes to determine
which of the builtin xinetd services to configure and enable.  All are
true by default.

* `default['xinetd']['builtin_services']['chargen-stream']['enabled']`
* `default['xinetd']['builtin_services']['chargen-dgram']['enabled']`
* `default['xinetd']['builtin_services']['daytime-stream']['enabled']`
* `default['xinetd']['builtin_services']['daytime-dgram']['enabled']`
* `default['xinetd']['builtin_services']['discard-stream']['enabled']`
* `default['xinetd']['builtin_services']['discard-dgram']['enabled']`
* `default['xinetd']['builtin_services']['echo-stream']['enabled']`
* `default['xinetd']['builtin_services']['echo-dgram']['enabled']`
* `default['xinetd']['builtin_services']['time-stream']['enabled']`
* `default['xinetd']['builtin_services']['time-dgram']['enabled']`
* `default['xinetd']['builtin_services']['tcpmux-server']['enabled']`

# Recipes

## default.rb

Installs the xinetd package, renders a basic configuration file, and
starts the xinetd service.

## builtin_services.rb

This recipe configures stream and datagram services that xinetd
implements internally:

* echo
* time
* daytime
* chargen
* discard
* tcpmux-server

By default this recipes configures all services.  Individual services
can be disabled by using the appropriate attributes (see above.)

# Author

Author:: Steven Danna (<steve@opscode.com>)

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

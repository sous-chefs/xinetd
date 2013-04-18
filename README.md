# xinetd cookbook

This cookbook installs and configures the xinetd internet service
daemon.  It also provides an LWRP for managing xinetd services.

# Requirements

## Platforms

This cookbook has been tested on Centos and Ubuntu.

## Chef Version

This cookbook only supports Chef 11.

# Resources

## xinetd_service

The xinetd_service resource allows you to define and enable xinetd
services.  For example:

    xinetd_service "discard" do
      id "discard-stream"
      type "INTERNAL"
      wait false
      socket_type "stream"
      action :enable
    end

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

- echo
- time
- daytime
- chargen
- discard
- tcpmux-server

By default this recipes configures all services.  Individual services
can be disabled by using the appropriate attributes (see above.)


# Author

Author:: Steven Danna (<steve@opscode.com>)

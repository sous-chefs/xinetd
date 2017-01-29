# Configuration options that will be rendered to the
# 'default' section of the xinetd config.
# See xinetd.conf(5) for further details
default["xinetd"]["defaults"]["log_type"] = "SYSLOG daemon info"
default["xinetd"]["defaults"]["bind"] = nil
default["xinetd"]["defaults"]["per_source"] = "10"
default["xinetd"]["defaults"]["umask"] = "002"
default["xinetd"]["defaults"]["log_on_success"] = "PID HOST DURATION EXIT"
default["xinetd"]["defaults"]["log_on_failure"] = "HOST"
default["xinetd"]["defaults"]["v6only"] = false
default["xinetd"]["defaults"]["only_from"] = nil
default["xinetd"]["defaults"]["no_access"] = nil
default["xinetd"]["defaults"]["passenv"] = nil
default["xinetd"]["defaults"]["instances"] = "50"
default["xinetd"]["defaults"]["disabled"] = nil
default["xinetd"]["defaults"]["enabled"] = nil
default["xinetd"]["defaults"]["banner"] = nil
default["xinetd"]["defaults"]["banner_success"] = nil
default["xinetd"]["defaults"]["banner_fail"] = nil
default["xinetd"]["defaults"]["groups"] = true
default["xinetd"]["defaults"]["cps"] = "50 10"
default["xinetd"]["defaults"]["max_load"] = nil

# Controls whether the builtin_services recipes will enable to specified
# builtin service.
default["xinetd"]["builtin_services"]["chargen-stream"]["enabled"] = true
default["xinetd"]["builtin_services"]["chargen-dgram"]["enabled"] = true
default["xinetd"]["builtin_services"]["daytime-stream"]["enabled"] = true
default["xinetd"]["builtin_services"]["daytime-dgram"]["enabled"] = true
default["xinetd"]["builtin_services"]["discard-stream"]["enabled"] = true
default["xinetd"]["builtin_services"]["discard-dgram"]["enabled"] = true
default["xinetd"]["builtin_services"]["echo-stream"]["enabled"] = true
default["xinetd"]["builtin_services"]["echo-dgram"]["enabled"] = true
default["xinetd"]["builtin_services"]["time-stream"]["enabled"] = true
default["xinetd"]["builtin_services"]["time-dgram"]["enabled"] = true
default["xinetd"]["builtin_services"]["tcpmux-server"]["enabled"] = true

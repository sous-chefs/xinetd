module XinetdServiceHelpers
  # All documented xinetd options other than disable and those listed
  # as not being valid inside a service block.
  OPTIONS = [:id, :type, :flags, :socket_type, :protocol, :wait, :user,
             :group, :instances, :nice, :server, :server_args, :libwrap,
             :only_from, :no_access, :access_times, :log_type,
             :log_on_success, :log_on_failure, :rpc_version, :rpc_number,
             :env, :passenv, :port, :redirect, :bind, :interface, :banner,
             :banner_success, :banner_failure, :per_source, :cps, :max_load,
             :groups, :mdns, :umask, :enabled, :rlimit_as, :rlimit_files,
             :rlimit_cpus, :rlimit_data, :rlimit_rss, :rlimit_stack, :deny_time ] unless defined? OPTIONS

  def self.xinetd_bool(bool)
    bool ? "yes" : "no"
  end

  def self.xinetd_value(v)
    case v
    when Array
      v.join(" ")
    when TrueClass, FalseClass
      xinetd_bool(v)
    else
      v
    end
  end
end

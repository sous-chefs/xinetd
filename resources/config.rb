# frozen_string_literal: true

provides :xinetd_config
unified_mode true

description 'Configures xinetd: creates /etc/xinetd.d/, renders /etc/xinetd.conf, and manages the xinetd service'

property :instance, String,
         name_property: true,
         description: 'Instance name (used as the resource name)'

property :cookbook, String,
         default: 'xinetd',
         description: 'Cookbook to source the xinetd.conf.erb template from'

# Defaults section properties (map to node['xinetd']['defaults'] in old recipe)
property :log_type, [String, nil],
         default: 'SYSLOG daemon info',
         description: 'xinetd log_type value'

property :bind, [String, nil],
         description: 'xinetd bind value'

property :per_source, [String, nil],
         default: '10',
         description: 'xinetd per_source value'

property :umask, [String, nil],
         default: '002',
         description: 'xinetd umask value'

property :log_on_success, [String, nil],
         default: 'PID HOST DURATION EXIT',
         description: 'xinetd log_on_success value'

property :log_on_failure, [String, nil],
         default: 'HOST',
         description: 'xinetd log_on_failure value'

property :v6only, [true, false, nil],
         default: false,
         description: 'xinetd v6only value'

property :only_from, [String, nil],
         description: 'xinetd only_from value'

property :no_access, [String, nil],
         description: 'xinetd no_access value'

property :passenv, [String, nil],
         description: 'xinetd passenv value'

property :instances, [String, nil],
         default: '50',
         description: 'xinetd instances value'

property :disabled, [String, nil],
         description: 'xinetd disabled value'

property :enabled, [String, nil],
         description: 'xinetd enabled value'

property :banner, [String, nil],
         description: 'xinetd banner value'

property :banner_success, [String, nil],
         description: 'xinetd banner_success value'

property :banner_fail, [String, nil],
         description: 'xinetd banner_fail value'

property :groups, [true, false, nil],
         default: true,
         description: 'xinetd groups value'

property :cps, [String, nil],
         default: '50 10',
         description: 'xinetd cps value'

property :max_load, [String, nil],
         description: 'xinetd max_load value'

default_action :create

action :create do
  directory '/etc/xinetd.d/' do
    action :create
  end

  template '/etc/xinetd.conf' do
    cookbook new_resource.cookbook
    source 'xinetd.conf.erb'
    variables defaults: config_defaults
    notifies :reload, 'service[xinetd]', :immediately
  end

  service 'xinetd' do
    supports reload: true
    action [:enable, :start]
  end
end

action :delete do
  service 'xinetd' do
    supports reload: true
    action [:stop, :disable]
  end

  file '/etc/xinetd.conf' do
    action :delete
  end

  directory '/etc/xinetd.d/' do
    recursive true
    action :delete
  end
end

action_class do
  include Xinetd::Cookbook::Helpers

  def config_defaults
    {
      'log_type' => xinetd_value(new_resource.log_type),
      'bind' => xinetd_value(new_resource.bind),
      'per_source' => xinetd_value(new_resource.per_source),
      'umask' => xinetd_value(new_resource.umask),
      'log_on_success' => xinetd_value(new_resource.log_on_success),
      'log_on_failure' => xinetd_value(new_resource.log_on_failure),
      'v6only' => xinetd_value(new_resource.v6only),
      'only_from' => xinetd_value(new_resource.only_from),
      'no_access' => xinetd_value(new_resource.no_access),
      'passenv' => xinetd_value(new_resource.passenv),
      'instances' => xinetd_value(new_resource.instances),
      'disabled' => xinetd_value(new_resource.disabled),
      'enabled' => xinetd_value(new_resource.enabled),
      'banner' => xinetd_value(new_resource.banner),
      'banner_success' => xinetd_value(new_resource.banner_success),
      'banner_fail' => xinetd_value(new_resource.banner_fail),
      'groups' => xinetd_value(new_resource.groups),
      'cps' => xinetd_value(new_resource.cps),
      'max_load' => xinetd_value(new_resource.max_load),
    }
  end

  def xinetd_value(v)
    Xinetd::Cookbook::Helpers.xinetd_value(v)
  end
end

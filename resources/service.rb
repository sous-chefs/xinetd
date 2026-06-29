# frozen_string_literal: true

provides :xinetd_service
unified_mode true

description 'Manages an xinetd service definition in /etc/xinetd.d/'

property :service_name, String,
         name_property: true,
         description: 'Name of the xinetd service (also the filename in /etc/xinetd.d/)'

property :cookbook, String,
         default: 'xinetd',
         description: 'Cookbook to source the service.erb template from'

Xinetd::Cookbook::Helpers::OPTIONS.each do |opt|
  property opt
end

default_action :enable

action :enable do
  service 'xinetd' do
    supports reload: true
    action :start
  end
  service_def_template(false)
end

action :disable do
  service 'xinetd' do
    supports reload: true
    action :nothing
  end
  service_def_template(true)
end

action :delete do
  file "/etc/xinetd.d/#{new_resource.name}" do
    action :delete
    notifies :restart, 'service[xinetd]', :delayed
  end

  service 'xinetd' do
    supports reload: true
    action :nothing
  end
end

action_class do
  include Xinetd::Cookbook::Helpers

  def service_def_template(disabled)
    template "/etc/xinetd.d/#{new_resource.name}" do
      cookbook new_resource.cookbook
      source 'service.erb'
      variables name: new_resource.service_name,
                options: xinetd_options,
                disabled: Xinetd::Cookbook::Helpers.xinetd_bool(disabled)
      notifies :restart, 'service[xinetd]', :delayed
    end
  end

  def xinetd_options
    ret = {}
    Xinetd::Cookbook::Helpers::OPTIONS.each do |opt|
      next unless new_resource.respond_to?(opt.to_sym)
      ret[opt] = Xinetd::Cookbook::Helpers.xinetd_value(new_resource.send(opt))
    end
    ret
  end
end

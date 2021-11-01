property :cookbook, kind_of: String, default: 'xinetd'
property :service_name, String, name_property: true
unified_mode true

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

action_class do
  def service_def_template(disabled)
    template "/etc/xinetd.d/#{new_resource.name}" do
      cookbook new_resource.cookbook
      source 'service.erb'
      variables name: new_resource.service_name,
                options: xinetd_options,
                disabled: Xinetd::Cookbook::Helpers.xinetd_bool(disabled)
      notifies :reload, 'service[xinetd]', :immediately
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

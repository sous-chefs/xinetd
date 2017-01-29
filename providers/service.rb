use_inline_resources

action :enable do
  service "xinetd" do
    supports :reload => true
    action :start
  end
  service_def_template(false)
end

action :disable do
  service "xinetd" do
    supports :reload => true
    action :nothing
  end
  service_def_template(true)
end

def service_def_template(disabled)
  template "/etc/xinetd.d/#{new_resource.name}" do
    cookbook new_resource.cookbook
    source "service.erb"
    variables :name => new_resource.service_name,
              :options => xinetd_options,
              :disabled => XinetdServiceHelpers.xinetd_bool(disabled)
    notifies :reload, "service[xinetd]", :immediately
  end
end

def xinetd_options
  ret = Hash.new
  XinetdServiceHelpers::OPTIONS.each do |opt|
    next unless new_resource.respond_to?(opt.to_sym)
    ret[opt] = XinetdServiceHelpers.xinetd_value(new_resource.send(opt))
  end
  ret
end

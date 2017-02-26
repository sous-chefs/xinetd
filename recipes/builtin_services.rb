include_recipe "xinetd::default"

%w{chargen daytime discard echo time}.each do |svc|
  xinetd_service "#{svc}-stream" do
    service_name svc
    id "#{svc}-stream"
    type "INTERNAL"
    wait false
    socket_type "stream"
    if node["xinetd"]["builtin_services"]["#{svc}-stream"]["enabled"]
      action :enable
    else
      action :disable
    end
  end

  xinetd_service "#{svc}-dgram" do
    service_name svc
    id "#{svc}-dgram"
    type "INTERNAL"
    wait true
    socket_type "dgram"
    if node["xinetd"]["builtin_services"]["#{svc}-dgram"]["enabled"]
      action :enable
    else
      action :disable
    end
  end
end

xinetd_service "tcpmux-server" do
  service_name "tcpmux-server"
  id "tcpmux-server"
  type "INTERNAL"
  wait false
  socket_type "stream"
  if node["xinetd"]["builtin_services"]["tcpmux-server"]["enabled"]
    action :enable
  else
    action :disable
  end
end

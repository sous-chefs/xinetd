# frozen_string_literal: true

provides :xinetd_builtin_services
unified_mode true

description 'Manages xinetd builtin (INTERNAL) services: chargen, daytime, discard, echo, time, and tcpmux-server'

property :instance, String,
         name_property: true,
         description: 'Instance name (used as the resource name)'

# Per-service enabled/disabled properties (defaults match old attributes/default.rb)
property :chargen_stream_enabled, [true, false],
         default: true,
         description: 'Enable chargen-stream builtin service'

property :chargen_dgram_enabled, [true, false],
         default: true,
         description: 'Enable chargen-dgram builtin service'

property :daytime_stream_enabled, [true, false],
         default: true,
         description: 'Enable daytime-stream builtin service'

property :daytime_dgram_enabled, [true, false],
         default: true,
         description: 'Enable daytime-dgram builtin service'

property :discard_stream_enabled, [true, false],
         default: true,
         description: 'Enable discard-stream builtin service'

property :discard_dgram_enabled, [true, false],
         default: true,
         description: 'Enable discard-dgram builtin service'

property :echo_stream_enabled, [true, false],
         default: true,
         description: 'Enable echo-stream builtin service'

property :echo_dgram_enabled, [true, false],
         default: true,
         description: 'Enable echo-dgram builtin service'

property :time_stream_enabled, [true, false],
         default: true,
         description: 'Enable time-stream builtin service'

property :time_dgram_enabled, [true, false],
         default: true,
         description: 'Enable time-dgram builtin service'

property :tcpmux_server_enabled, [true, false],
         default: true,
         description: 'Enable tcpmux-server builtin service'

default_action :create

action :create do
  service 'xinetd' do
    action :nothing
  end

  %w(chargen daytime discard echo time).each do |svc|
    builtin_service_file "#{svc}-stream",
                         service_name: svc,
                         id: "#{svc}-stream",
                         type: 'INTERNAL',
                         wait: false,
                         socket_type: 'stream',
                         disabled: !new_resource.send(:"#{svc}_stream_enabled")

    builtin_service_file "#{svc}-dgram",
                         service_name: svc,
                         id: "#{svc}-dgram",
                         type: 'INTERNAL',
                         wait: true,
                         socket_type: 'dgram',
                         disabled: !new_resource.send(:"#{svc}_dgram_enabled")
  end

  builtin_service_file 'tcpmux-server',
                       service_name: 'tcpmux',
                       id: 'tcpmux-server',
                       type: 'INTERNAL',
                       wait: false,
                       socket_type: 'stream',
                       disabled: !new_resource.tcpmux_server_enabled
end

action :delete do
  service 'xinetd' do
    action :nothing
  end

  %w(chargen daytime discard echo time).each do |svc|
    file "/etc/xinetd.d/#{svc}-stream" do
      action :delete
      notifies :restart, 'service[xinetd]', :delayed
    end

    file "/etc/xinetd.d/#{svc}-dgram" do
      action :delete
      notifies :restart, 'service[xinetd]', :delayed
    end
  end

  file '/etc/xinetd.d/tcpmux-server' do
    action :delete
    notifies :restart, 'service[xinetd]', :delayed
  end
end

action_class do
  def builtin_service_file(name, service_name:, id:, type:, wait:, socket_type:, disabled:)
    template "/etc/xinetd.d/#{name}" do
      cookbook 'xinetd'
      source 'service.erb'
      variables name: service_name,
                disabled: Xinetd::Cookbook::Helpers.xinetd_bool(disabled),
                options: {
                  'id' => id,
                  'type' => type,
                  'socket_type' => socket_type,
                  'wait' => Xinetd::Cookbook::Helpers.xinetd_bool(wait),
                }
      notifies :restart, 'service[xinetd]', :delayed
    end
  end
end

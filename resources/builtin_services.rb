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
  %w(chargen daytime discard echo time).each do |svc|
    xinetd_service "#{svc}-stream" do
      service_name svc
      id "#{svc}-stream"
      type 'INTERNAL'
      wait false
      socket_type 'stream'
      action new_resource.send(:"#{svc}_stream_enabled") ? :enable : :disable
    end

    xinetd_service "#{svc}-dgram" do
      service_name svc
      id "#{svc}-dgram"
      type 'INTERNAL'
      wait true
      socket_type 'dgram'
      action new_resource.send(:"#{svc}_dgram_enabled") ? :enable : :disable
    end
  end

  xinetd_service 'tcpmux-server' do
    service_name 'tcpmux'
    id 'tcpmux-server'
    type 'INTERNAL'
    wait false
    socket_type 'stream'
    action new_resource.tcpmux_server_enabled ? :enable : :disable
  end
end

action :delete do
  %w(chargen daytime discard echo time).each do |svc|
    xinetd_service "#{svc}-stream" do
      action :delete
    end

    xinetd_service "#{svc}-dgram" do
      action :delete
    end
  end

  xinetd_service 'tcpmux-server' do
    action :delete
  end
end

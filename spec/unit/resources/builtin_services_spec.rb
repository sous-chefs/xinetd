# frozen_string_literal: true

require 'spec_helper'

describe 'xinetd_builtin_services' do
  step_into :xinetd_builtin_services, :xinetd_service
  platform 'ubuntu', '22.04'

  context 'action :create with defaults (all enabled)' do
    recipe do
      xinetd_builtin_services 'default'
    end

    %w(chargen daytime discard echo time).each do |svc|
      it do
        is_expected.to enable_xinetd_service("#{svc}-stream").with(
          service_name: svc,
          id: "#{svc}-stream",
          type: 'INTERNAL',
          wait: false,
          socket_type: 'stream'
        )
      end

      it do
        is_expected.to enable_xinetd_service("#{svc}-dgram").with(
          service_name: svc,
          id: "#{svc}-dgram",
          type: 'INTERNAL',
          wait: true,
          socket_type: 'dgram'
        )
      end
    end

    it do
      is_expected.to enable_xinetd_service('tcpmux-server').with(
        service_name: 'tcpmux',
        id: 'tcpmux-server',
        type: 'INTERNAL',
        wait: false,
        socket_type: 'stream'
      )
    end
  end

  context 'action :create with some services disabled' do
    recipe do
      xinetd_builtin_services 'custom' do
        chargen_stream_enabled false
        chargen_dgram_enabled false
        echo_stream_enabled false
        tcpmux_server_enabled false
      end
    end

    it { is_expected.to disable_xinetd_service('chargen-stream') }
    it { is_expected.to disable_xinetd_service('chargen-dgram') }
    it { is_expected.to disable_xinetd_service('echo-stream') }
    it { is_expected.to disable_xinetd_service('tcpmux-server') }

    it { is_expected.to enable_xinetd_service('daytime-stream') }
    it { is_expected.to enable_xinetd_service('echo-dgram') }
  end

  context 'action :delete' do
    recipe do
      xinetd_builtin_services 'default' do
        action :delete
      end
    end

    %w(chargen daytime discard echo time).each do |svc|
      it { is_expected.to delete_xinetd_service("#{svc}-stream") }
      it { is_expected.to delete_xinetd_service("#{svc}-dgram") }
    end

    it { is_expected.to delete_xinetd_service('tcpmux-server') }
  end
end

# frozen_string_literal: true

require 'spec_helper'

describe 'xinetd_builtin_services' do
  step_into :xinetd_builtin_services
  platform 'ubuntu', '22.04'

  context 'action :create with defaults (all enabled)' do
    recipe do
      xinetd_builtin_services 'default'
    end

    %w(chargen daytime discard echo time).each do |svc|
      it do
        is_expected.to create_template("/etc/xinetd.d/#{svc}-stream")
      end

      it do
        expect(chef_run.template("/etc/xinetd.d/#{svc}-stream").variables).to include(
          name: svc,
          disabled: 'no',
          options: {
            'id' => "#{svc}-stream",
            'type' => 'INTERNAL',
            'socket_type' => 'stream',
            'wait' => 'no',
          }
        )
      end

      it do
        is_expected.to create_template("/etc/xinetd.d/#{svc}-dgram")
      end

      it do
        expect(chef_run.template("/etc/xinetd.d/#{svc}-dgram").variables).to include(
          name: svc,
          disabled: 'no',
          options: {
            'id' => "#{svc}-dgram",
            'type' => 'INTERNAL',
            'socket_type' => 'dgram',
            'wait' => 'yes',
          }
        )
      end
    end

    it do
      is_expected.to create_template('/etc/xinetd.d/tcpmux-server')
    end

    it do
      expect(chef_run.template('/etc/xinetd.d/tcpmux-server').variables).to include(
        name: 'tcpmux',
        disabled: 'no',
        options: {
          'id' => 'tcpmux-server',
          'type' => 'INTERNAL',
          'socket_type' => 'stream',
          'wait' => 'no',
        }
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

    it { expect(chef_run.template('/etc/xinetd.d/chargen-stream').variables).to include(disabled: 'yes') }
    it { expect(chef_run.template('/etc/xinetd.d/chargen-dgram').variables).to include(disabled: 'yes') }
    it { expect(chef_run.template('/etc/xinetd.d/echo-stream').variables).to include(disabled: 'yes') }
    it { expect(chef_run.template('/etc/xinetd.d/tcpmux-server').variables).to include(disabled: 'yes') }

    it { expect(chef_run.template('/etc/xinetd.d/daytime-stream').variables).to include(disabled: 'no') }
    it { expect(chef_run.template('/etc/xinetd.d/echo-dgram').variables).to include(disabled: 'no') }
  end

  context 'action :delete' do
    recipe do
      xinetd_builtin_services 'default' do
        action :delete
      end
    end

    %w(chargen daytime discard echo time).each do |svc|
      it { is_expected.to delete_file("/etc/xinetd.d/#{svc}-stream") }
      it { is_expected.to delete_file("/etc/xinetd.d/#{svc}-dgram") }
    end

    it { is_expected.to delete_file('/etc/xinetd.d/tcpmux-server') }
  end
end

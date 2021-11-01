require 'spec_helper'

describe 'xinetd::builtin_services' do
  platform 'ubuntu'
  step_into :xinetd_service

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
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
      service_name: 'tcpmux-server',
      id: 'tcpmux-server',
      type: 'INTERNAL',
      wait: false,
      socket_type: 'stream'
    )
  end

  # Test resource internals
  it { is_expected.to start_service 'xinetd' }

  it do
    is_expected.to create_template('/etc/xinetd.d/chargen-stream').with(
      cookbook: 'xinetd',
      source: 'service.erb',
      variables: {
        name: 'chargen',
        options: {
          access_times: nil,
          banner: nil,
          banner_failure: nil,
          banner_success: nil,
          bind: nil,
          cps: nil,
          deny_time: nil,
          enabled: nil,
          env: nil,
          flags: nil,
          group: nil,
          groups: nil,
          id: 'chargen-stream',
          instances: nil,
          interface: nil,
          libwrap: nil,
          log_on_failure: nil,
          log_on_success: nil,
          log_type: nil,
          max_load: nil,
          mdns: nil,
          nice: nil,
          no_access: nil,
          only_from: nil,
          passenv: nil,
          per_source: nil,
          port: nil,
          protocol: nil,
          redirect: nil,
          rlimit_as: nil,
          rlimit_cpus: nil,
          rlimit_data: nil,
          rlimit_files: nil,
          rlimit_rss: nil,
          rlimit_stack: nil,
          rpc_number: nil,
          rpc_version: nil,
          server: nil,
          server_args: nil,
          socket_type: 'stream',
          type: 'INTERNAL',
          umask: nil,
          user: nil,
          wait: 'no',
        },
        disabled: 'no',
      }
    )
  end

  it do
    is_expected.to create_template('/etc/xinetd.d/chargen-dgram').with(
      cookbook: 'xinetd',
      source: 'service.erb',
      variables: {
        name: 'chargen',
        options: {
          access_times: nil,
          banner: nil,
          banner_failure: nil,
          banner_success: nil,
          bind: nil,
          cps: nil,
          deny_time: nil,
          enabled: nil,
          env: nil,
          flags: nil,
          group: nil,
          groups: nil,
          id: 'chargen-dgram',
          instances: nil,
          interface: nil,
          libwrap: nil,
          log_on_failure: nil,
          log_on_success: nil,
          log_type: nil,
          max_load: nil,
          mdns: nil,
          nice: nil,
          no_access: nil,
          only_from: nil,
          passenv: nil,
          per_source: nil,
          port: nil,
          protocol: nil,
          redirect: nil,
          rlimit_as: nil,
          rlimit_cpus: nil,
          rlimit_data: nil,
          rlimit_files: nil,
          rlimit_rss: nil,
          rlimit_stack: nil,
          rpc_number: nil,
          rpc_version: nil,
          server: nil,
          server_args: nil,
          socket_type: 'dgram',
          type: 'INTERNAL',
          umask: nil,
          user: nil,
          wait: 'yes',
        },
        disabled: 'no',
      }
    )
  end

  it { expect(chef_run.template('/etc/xinetd.d/chargen-stream')).to notify('service[xinetd]').to(:reload).immediately }
end

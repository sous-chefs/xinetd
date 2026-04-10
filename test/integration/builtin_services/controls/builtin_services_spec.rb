# frozen_string_literal: true

title 'Builtin Services Suite Tests'

control 'xinetd-install-01' do
  impact 1.0
  title 'xinetd package is installed'
  desc 'The xinetd package should be installed'

  describe package('xinetd') do
    it { should be_installed }
  end
end

control 'xinetd-service-01' do
  impact 1.0
  title 'xinetd service is enabled and running'
  desc 'The xinetd service should be enabled and running'

  describe service('xinetd') do
    it { should be_enabled }
    it { should be_running }
  end
end

control 'xinetd-builtin-service-files' do
  impact 0.7
  title 'xinetd.d contains builtin service definitions'
  desc 'Each builtin service should have a config file in /etc/xinetd.d/'

  %w(chargen-stream chargen-dgram daytime-stream daytime-dgram
     discard-stream discard-dgram echo-stream echo-dgram
     time-stream time-dgram tcpmux-server).each do |svc|
    describe file("/etc/xinetd.d/#{svc}") do
      it { should exist }
      its('content') { should match(/service/) }
      its('content') { should match(/disable = no/) }
    end
  end
end

control 'xinetd-builtin-ports' do
  impact 0.5
  title 'Builtin INTERNAL service ports are listening'
  desc 'xinetd should listen on well-known INTERNAL service ports'

  # chargen=19, daytime=13, discard=9, echo=7, time=37
  # TCP stream services
  [7, 9, 13, 19, 37].each do |p|
    describe port(p) do
      it { should be_listening }
      its('protocols') { should include 'tcp' }
    end
  end

  # UDP dgram services (all except tcpmux which is tcp only)
  [7, 9, 13, 19, 37].each do |p|
    describe port(p) do
      it { should be_listening }
      its('protocols') { should include 'udp' }
    end
  end
end

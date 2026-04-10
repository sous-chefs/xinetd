# frozen_string_literal: true

title 'Default Suite Tests'

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
  title 'xinetd service is enabled'
  desc 'The xinetd service should be enabled (it may not be running when no services are configured)'

  describe service('xinetd') do
    it { should be_enabled }
  end
end

control 'xinetd-config-01' do
  impact 0.7
  title 'xinetd configuration file exists'
  desc 'The /etc/xinetd.conf file should exist'

  describe file('/etc/xinetd.conf') do
    it { should exist }
    it { should be_file }
    its('content') { should match(/defaults/) }
    its('content') { should match(%r{includedir /etc/xinetd\.d}) }
  end
end

control 'xinetd-config-02' do
  impact 0.7
  title 'xinetd.d directory exists'
  desc 'The /etc/xinetd.d directory should exist'

  describe directory('/etc/xinetd.d') do
    it { should exist }
  end
end

builtin = input('builtin')

control 'xinetd-default' do
  describe package 'xinetd' do
    it { should be_installed }
  end

  describe service 'xinetd' do
    it { should be_enabled }
    it { should be_running }
  end

  # builtin services
  %w(
    1
    7
    9
    13
    19
    37
  ).each do |p|
    describe port p do
      if builtin
        it { should be_listening }
        its('processes') { should include 'xinetd' }
        its('protocols') { should include 'tcp' }
        its('protocols') { should include 'udp' } unless p.to_i == 1 # only listening on tcp
      else
        it { should_not be_listening }
        its('processes') { should_not include 'xinetd' }
        its('protocols') { should_not include 'tcp' }
        its('protocols') { should_not include 'udp' }
      end
    end
  end
end

require 'spec_helper'

describe 'xinetd::default' do
  platform 'ubuntu'

  it 'converges successfully' do
    expect { :chef_run }.to_not raise_error
  end

  it { is_expected.to install_package 'xinetd' }
  it { is_expected.to create_directory '/etc/xinetd.d/' }
  it { is_expected.to create_template '/etc/xinetd.conf' }
  it { is_expected.to enable_service 'xinetd' }
  it { is_expected.to start_service 'xinetd' }

  it do
    expect(chef_run.template('/etc/xinetd.conf')).to notify('service[xinetd]').to(:reload)
  end

  it do
    is_expected.to render_file('/etc/xinetd.conf').with_content(
      <<~EOF
        defaults
        {
           log_type = SYSLOG daemon info
           per_source = 10
           umask = 002
           log_on_success = PID HOST DURATION EXIT
           log_on_failure = HOST
           v6only = no
           instances = 50
           groups = yes
           cps = 50 10
        }

        includedir /etc/xinetd.d
      EOF
    )
  end
end

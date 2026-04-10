# frozen_string_literal: true

require 'spec_helper'

describe 'xinetd_config' do
  step_into :xinetd_config, :xinetd_install
  platform 'ubuntu', '22.04'

  context 'action :create with defaults' do
    recipe do
      xinetd_config 'default'
    end

    it { is_expected.to create_directory('/etc/xinetd.d/') }

    it { is_expected.to create_template('/etc/xinetd.conf').with(cookbook: 'xinetd', source: 'xinetd.conf.erb') }

    it { is_expected.to enable_service('xinetd') }
    it { is_expected.to start_service('xinetd') }

    it do
      expect(chef_run.template('/etc/xinetd.conf')).to notify('service[xinetd]').to(:reload).immediately
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

  context 'action :create with custom values' do
    recipe do
      xinetd_config 'custom' do
        log_type 'FILE /var/log/xinetd.log'
        per_source '5'
        instances 'UNLIMITED'
        only_from '127.0.0.1'
      end
    end

    it { is_expected.to create_template('/etc/xinetd.conf') }

    it do
      is_expected.to render_file('/etc/xinetd.conf').with_content(%r{log_type = FILE /var/log/xinetd\.log})
    end

    it do
      is_expected.to render_file('/etc/xinetd.conf').with_content(/per_source = 5/)
    end

    it do
      is_expected.to render_file('/etc/xinetd.conf').with_content(/instances = UNLIMITED/)
    end

    it do
      is_expected.to render_file('/etc/xinetd.conf').with_content(/only_from = 127\.0\.0\.1/)
    end
  end

  context 'action :delete' do
    recipe do
      xinetd_config 'default' do
        action :delete
      end
    end

    it { is_expected.to stop_service('xinetd') }
    it { is_expected.to disable_service('xinetd') }
    it { is_expected.to delete_file('/etc/xinetd.conf') }
    it { is_expected.to delete_directory('/etc/xinetd.d/') }
  end
end

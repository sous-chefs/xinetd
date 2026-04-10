# frozen_string_literal: true

require 'spec_helper'

describe 'xinetd_service' do
  step_into :xinetd_service
  platform 'ubuntu', '22.04'

  context 'action :enable with required properties' do
    recipe do
      xinetd_service 'my-service' do
        service_name 'myservice'
        id 'my-service'
        type 'INTERNAL'
        wait false
        socket_type 'stream'
      end
    end

    it { is_expected.to start_service('xinetd') }

    it do
      is_expected.to create_template('/etc/xinetd.d/my-service').with(
        cookbook: 'xinetd',
        source: 'service.erb'
      )
    end

    it do
      expect(chef_run.template('/etc/xinetd.d/my-service')).to notify('service[xinetd]').to(:reload).immediately
    end
  end

  context 'action :disable' do
    recipe do
      xinetd_service 'my-service' do
        service_name 'myservice'
        id 'my-service'
        type 'INTERNAL'
        wait true
        socket_type 'dgram'
        action :disable
      end
    end

    it do
      is_expected.to create_template('/etc/xinetd.d/my-service')
    end
  end

  context 'action :delete' do
    recipe do
      xinetd_service 'my-service' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/etc/xinetd.d/my-service') }

    it do
      expect(chef_run.file('/etc/xinetd.d/my-service')).to notify('service[xinetd]').to(:reload).immediately
    end
  end

  context 'with custom cookbook' do
    recipe do
      xinetd_service 'custom-cookbook-svc' do
        service_name 'myservice'
        id 'custom-cookbook-svc'
        socket_type 'stream'
        wait false
        cookbook 'my-cookbook'
      end
    end

    it do
      is_expected.to create_template('/etc/xinetd.d/custom-cookbook-svc').with(
        cookbook: 'my-cookbook'
      )
    end
  end
end

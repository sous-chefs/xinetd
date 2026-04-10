# frozen_string_literal: true

require 'spec_helper'

describe 'xinetd_install' do
  step_into :xinetd_install
  platform 'ubuntu', '22.04'

  context 'action :install with defaults' do
    recipe do
      xinetd_install 'default'
    end

    it { is_expected.to install_package('xinetd') }
  end

  context 'action :install with custom package_name' do
    recipe do
      xinetd_install 'custom' do
        package_name 'xinetd-nox'
      end
    end

    it { is_expected.to install_package('xinetd-nox') }
  end

  context 'action :remove' do
    recipe do
      xinetd_install 'default' do
        action :remove
      end
    end

    it { is_expected.to remove_package('xinetd') }
  end
end

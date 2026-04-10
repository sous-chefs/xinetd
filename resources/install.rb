# frozen_string_literal: true

provides :xinetd_install
unified_mode true

description 'Installs the xinetd package'

property :package_name, String,
         default: 'xinetd',
         description: 'Name of the xinetd package to install'

default_action :install

action :install do
  package new_resource.package_name do
    action :install
  end
end

action :remove do
  package new_resource.package_name do
    action :remove
  end
end

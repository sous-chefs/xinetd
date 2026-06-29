# frozen_string_literal: true

name              'xinetd'
maintainer        'Sous Chefs'
maintainer_email  'help@sous-chefs.org'
license           'Apache-2.0'
description       'Provides xinetd_install, xinetd_config, xinetd_service, and xinetd_builtin_services resources'
version           '3.0.0'
source_url        'https://github.com/sous-chefs/xinetd'
issues_url        'https://github.com/sous-chefs/xinetd/issues'
chef_version      '>= 15.3'

supports 'almalinux', '~> 8.0'
supports 'debian', '>= 12.0'
supports 'oracle', '~> 8.0'
supports 'rocky', '~> 8.0'
supports 'ubuntu', '>= 22.04'

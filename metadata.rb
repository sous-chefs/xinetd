name             'xinetd'
maintainer       'Steven Danna'
maintainer_email 'steve@chef.io'
license          'Apache 2.0'
description      'Installs/Configures xinetd'
long_description 'Installs and configures the xinetd internet service daemon.  Also provides an LWRP for configuring xinetd services.'
version          '1.0.2'

supports 'ubuntu'
supports 'centos'

source_url 'https://github.com/stevendanna/xinetd'
issues_url 'https://github.com/stevendanna/xinetd/issues'
chef_version '>= 12.1' if respond_to?(:chef_version)

# -*- mode: ruby; coding: utf-8; -*-

if defined?(ChefSpec)
  def enable_xinetd_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:xinetd_service,
                                            :enable,
                                            resource_name)
  end

end


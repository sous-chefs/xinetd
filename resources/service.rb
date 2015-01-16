actions :enable, :disable

attribute :cookbook, :kind_of => String, :default => "xinetd"
attribute :service_name, :name_attribute => true

XinetdServiceHelpers::OPTIONS.each do |opt|
  attribute opt
end

default_action :enable

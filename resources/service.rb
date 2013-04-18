actions :enable, :disable

attribute :service_name, :name_attribute => true

XinetdServiceHelpers::OPTIONS.each do |opt|
  attribute opt
end

default_action :enable

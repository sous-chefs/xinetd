# frozen_string_literal: true

name 'xinetd'

run_list 'test::default'

cookbook 'xinetd', path: '.'
cookbook 'test', path: './test/cookbooks/test'

Dir.glob('./test/cookbooks/test/recipes/*.rb').sort.each do |recipe|
  name = File.basename(recipe, '.rb')
  named_run_list :"#{name}", "test::#{name}"
end

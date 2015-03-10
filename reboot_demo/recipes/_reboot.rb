node.default['windows']['allow_reboot_on_failure'] = true
include_recipe 'windows::reboot_handler'

ruby_block 'endrun' do
  block do
    raise 'Need to reboot'
  end
  action :nothing
end

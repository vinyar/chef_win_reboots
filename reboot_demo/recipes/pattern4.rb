# using reboot handler from windows cookbook
# this will cause a reboot at the end of the chef client run

node.default['windows']['allow_reboot_on_failure'] = true
include_recipe 'windows::reboot_handler'

include_recipe 'somecookbook::recipe1'
include_recipe 'somecookbook::recipe2'
include_recipe 'somecookbook::recipe3'  unless reboot_pending?
include_recipe 'somecookbook::recipe4'  unless reboot_pending?

# request a reboot at the end of chef client run only if reboot is needed.
# We are adding dependency on windows cookbook in metadata.rb for this scenario to work.

windows_reboot 1 do
  reason 'Reboot'
  action :request
  only_if { reboot_pending? }
end

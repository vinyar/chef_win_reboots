# using raise to elegantly end the chef run immediately and reboot.
# Will still run report handlers at the end.
# just terminating the chef run will kill the chef run, resulting in end handlers being skipped.

# in this scenario node will not be saved because raise exits the chef run. If state needs to be captured, use node.save

include_recipe 'reboot_demo::_reboot'

powershell_script 'badly described resource that doesnt actually need a reboot' do
  code <<-EOH
    $svc=Get-WmiObject Win32_Service | Where-Object {$_.Name -eq 'chef-client'}
    $svc.change($null,$null,$null,$null,$null,$null,'.\\someuser','some_password',$null,$null,$null)
  EOH
  guard_interpreter :powershell_script
  only_if "(Get-WmiObject Win32_Service | Where-Object {$_.Name -eq 'chef-client' -and $_.StartName -eq '.\\someuser'}) -eq $null"
  notifies :request, 'windows_reboot[17]', :immediately
end


windows_reboot '17' do
  reason 'Chef client logon changed'
  timeout 10
  action :nothing
  notifies :run, 'ruby_block[endrun]', :immediately
end

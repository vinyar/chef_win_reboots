# using guard interpeter for custom reboot detection
# borrowed from https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542

include_recipe 'windows::reboot_handler'

local_path = ::File.join(Chef::Config[:file_cache_path], '/Get-PendingReboot.ps1')


cookbook_file local_path do
  source 'Get-PendingReboot.ps1'
  action :create_if_missing
end

service 'w3svc' do
  action [:start, :stop]
  notifies :request, 'windows_reboot[20]', :immediately
end

# chef_gem 'pry' do
#   action :install
# end

windows_reboot 20 do
  reason 'cause chef said so'
  guard_interpreter :powershell_script
  # leaving this line in here on purpose. Using pry is a great way to troubleshoot Chef.
  # require 'pry';binding.pry
  not_if <<-HRD
    . #{local_path}
    # forcing 'truthiness' in powershell
    (Get-PendingReboot | ConvertTo-Csv)[2] -match 'True' -eq $false
  HRD
  action :nothing
end

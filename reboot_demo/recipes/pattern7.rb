# using guard interpeter for custom reboot detection
# borrowed from https://gallery.technet.microsoft.com/scriptcenter/Get-PendingReboot-Query-bdb79542

# this function is actually defined in the windows cookbook.
def win_friendly_path(path)
  path.gsub(::File::SEPARATOR, ::File::ALT_SEPARATOR || '\\') if path
end

local_path = ::File.join(Chef::Config[:file_cache_path], '/Get-PendingReboot.ps1')


cookbook_file win_friendly_path(local_path) do
  source 'Get-PendingReboot.ps1'
end

service 'w3svc' do
  action [ :start, :enable ]
  notifies :request, "windows_reboot[60]", :immediately
end


windows_reboot 60 do
  reason 'cause chef said so'
  guard_interpreter :powershell_script
  not_if <<-HRD
    . #{local_path}\\Get-PendingReboot.ps1
    # forcing truthiness in powreshell
    (Get-PendingReboot | ConvertTo-Csv)[2] -match 'True' -eq $false
  HRD
  action :nothing
end

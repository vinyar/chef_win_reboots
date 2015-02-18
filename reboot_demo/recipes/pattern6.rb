# using reboot resource introduced in chef-client 12.x.x


service 'w3svc' do
  action [ :start, :enable ]
  not_if reboot_pending?
end

package 'notepad' do
  action :install
  # not_if reboot_pending?
end

template 'c:/myfolder/myfile.txt' do
  source 'source.erb'
  variables(:config_var => node['configs']['config_var'])
  # not_if reboot_pending?
end


reboot "app_requires_reboot" do
  action :request_reboot
  reason "Need to reboot when the run completes successfully."
  delay_mins 5
end

# using custom library.
# For example, if your application has specific requirements.
# useful for older versions of chef-client before pending_reboot? was implemented.

service 'w3svc' do
  action [:start, :enable]
  not_if reboot_pending_old?
end

package 'notepad' do
  action :install
  not_if reboot_pending_old?
end

template 'c:/myfolder/myfile.txt' do
  source 'source.erb'
  variables(:config_var => node['configs']['config_var'])
  not_if reboot_pending_old?
end



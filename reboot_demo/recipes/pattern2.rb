# Resource level reboot skipping.
# this leverages the reboot_pending? method in Chef. Usefull for skipping resources which depend on no-reboot-pending condition.
# for example, some roles and some patches require that there is no pending reboot prior to installation.
# 
# original prototype here: http://www.toddpigram.com/2013/10/testing-puppet-and-chef-cant-decide.html

# Powershell Default Server
powershell "DefaultServer" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature FS-FileServer
  Add-WindowsFeature Backup
  Add-WindowsFeature Backup-Tools
  Add-WindowsFeature Net-Framework-Core
  Add-WindowsFeature Powershell-ISE
  Add-WindowsFeature WSRM
  Add-WindowsFeature GPMC
  Add-WindowsFeature XPS-Viewer
  EOH
end

# Install RDS
powershell "RDS" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature RDS-RD-Server
  EOH
  not_if {reboot_pending?}
end

# Install desktop experience
powershell "desktop_experience" do
  code <<-EOH
  Import-Module ServerManager
  Add-WindowsFeature Desktop-Experience
  EOH
  not_if {reboot_pending?}
end

# install 7zip
windows_package "7-Zip for 64-bit Windows x64" do
  source "http://downloads.sourceforge.net/sevenzip/7z920-x64.msi"
  action :install
  not_if {reboot_pending?}
end

windows_package "AdbeRdr11000_en_US" do
  source "http://<server>/repo/AdbeRdr11000_en_US.msi"
  action :install
  not_if {reboot_pending?}
end

windows_package "Google Chrome" do 
  source "https://dl.google.com/edgedl/chrome/install/GoogleChromeStandaloneEnterprise.msi"
  action :install
  not_if {reboot_pending?}
end

windows_package "Firefox" do 
  source "http://hicap.frontmotion.com.s3.amazonaws.com/Firefox/Firefox-24.0/Firefox-24.0-en-US.msi"
  action :install
  not_if {reboot_pending?}
end

windows_package "flash Plugin" do
  source "http://<server>/repo/install_flash_player_11_plugin.msi"
  action :install
  not_if {reboot_pending?}
end

windows_package "Flash_Player_activex" do
  source "http://<server>/repo/install_flash_player_11_active_x.msi"
  action :install
  not_if {reboot_pending?}
end

# if feature installs, schedule a reboot at end of chef run
windows_reboot 60 do
  reason 'cause chef said so'
  only_if {reboot_pending?}
end

# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  # config.vm.box = "alex_win2k8"
  # config.vm.box = "windows2008r2"
  config.vm.box = "win2k8r2_11_18"

  # config.vbguest.auto_update = true # experiment with vagrant-vbguest plugin


  # config.omnibus.chef_version = :latest
  # config.vm.synced_folder "../../Alex_personal/password\ safe", "c:/password_safe"
  config.vm.synced_folder "~/Documents/ISO_BOX_etc/binaries/", "c:/binaries"
  # config.vm.synced_folder '/Volumes/NIKON D610', "c:/nikon_d610"
  # config.vm.synced_folder '/Volumes/win8', "c:/win8"


  # config.vm.guest = :windows
  # New veature in vagrant 1.6. Makes windows much easier.
  config.vm.communicator = "winrm"
  config.vm.guest = :windows #needed for vagrant omnibus to work (1.4.1 has a bug https://github.com/chef/vagrant-omnibus/issues/90)

  config.windows.halt_timeout = 25
  config.winrm.username = "vagrant"
  config.winrm.password = "vagrant"
  config.winrm.max_tries = 30

  # # Port forward WinRM and RDP
  # config.vm.network :forwarded_port, { :guest=>3389, :host=>3389, :id=>"rdp"}#, :auto_correct=>true }
  # config.vm.network :forwarded_port, { :guest=>5985, :host=>5985, :id=>"winrm"}#, :auto_correct=>true }
  # config.vm.network :private_network, ip: "192.168.33.10" # needed for Consultants/Contractors to spin up vagrant on VPN.


  # Example for VirtualBox:
  config.vm.provider :virtualbox do |vb|
    vb.gui = true
    vb.name = "reboot_demo"
  
    vb.customize [
      "modifyvm", :id,'--memory', '1536','--clipboard', 'bidirectional','--usb', 'on'
      # ,'--usbehci', 'on'
      ]

  end

  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "."
  #   chef.add_recipe "win_lang_pack"
  #   chef.log_level = :debug
  # end

end




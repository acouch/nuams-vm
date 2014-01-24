# -*- mode: ruby -*-
# vi: set ft=ruby :

is_windows = (RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/)

# Uncomment if using virtualbox
vmware = true 

Vagrant.configure("2") do |config|

  config.vm.hostname = "local"
  

  config.vm.provider "vmware_fusion" do |v|
    v.vmx["memsize"] = "2048"
    v.vmx["numvcpus"] = "2"
  end
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

  if vmware
    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64_vmware.box"
  else
    config.vm.network :private_network, ip: "33.33.33.33"
    config.vm.box = "precise-vbox-4.2.18"
    config.vm.box_url = "http://fattony.zivtech.com/files/precise-vbox-4.2.18.box"
  end

  config.ssh.forward_agent = true

  config.vm.provision :puppet do |puppet|
    puppet.module_path = "modules"
    puppet.manifests_path = "manifests"
    puppet.manifest_file = "default.pp"
  end

  require 'rbconfig'

  if not is_windows
    config.vm.synced_folder "www", "/var/www", :nfs => true
  else
    config.vm.synced_folder "www", "/var/www"
  end
end

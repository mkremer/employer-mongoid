# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.host_name = "employer"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :hostonly, "192.168.33.33"
  config.vm.customize ["modifyvm", :id, "--memory", 512]
  config.vm.share_folder "v-root", "/vagrant", ".", :nfs => !(ENV["OS"] =~ /windows/i)
  if File.directory?(File.expand_path("./.apt-cache/partial/"))
    config.vm.share_folder "apt-cache", "/var/cache/apt/archives", "./.apt-cache", :owner => "root", :group => "root"
  end 
  config.vm.provision :shell, :path => "script/vagrant-keep-agent-forwarding"
  config.vm.provision :shell, :path => "script/vagrant-provision"
end

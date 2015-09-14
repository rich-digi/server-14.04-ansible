# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 
	config.vm.box = "ubuntu/trusty64"

	config.vm.provider "virtualbox" do |v|
		v.memory = 1536
		v.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
	end
  
  	config.vm.network "private_network", ip: "192.168.33.10"

	config.vm.provision :ansible do |ansible|
		ansible.playbook = "playbook.yml"
		ansible.verbose = "vvvv"
	end

end
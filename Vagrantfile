# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.vm.box = "trusty64"

    config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 3306, host: 3306


    config.vm.provision "shell", inline: "puppet module install puppetlabs-stdlib --force --target-dir /vagrant/provision/modules/"
    config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "provision/manifests"
        puppet.manifest_file = "default.pp"
        puppet.module_path = "provision/modules"
    end

    config.vm.synced_folder "./", "/vagrant/", id: "vagrant-root",
        owner: "www-data",
        group: "www-data",
        mount_options: ["dmode=777,fmode=777"]


end

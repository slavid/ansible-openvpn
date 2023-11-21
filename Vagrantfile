# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "alvistack/debian-12"
  config.vm.synced_folder ".", "/vagrant", disabled: false
  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   pacman -Sy python3 ansible --needed --noconfirm
  # SHELL

  config.vm.network :private_network, ip: "192.168.56.42"

  provisioner = Vagrant::Util::Platform.windows? ? :guest_ansible : :ansible
  puts "Provisioner that will be used: #{provisioner}"
  config.vm.provision provisioner do |ansible|
      ansible.playbook = "main.yml"
  end
end

# Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#   if Vagrant::Util::Platform.windows?
#     config.vm.provision :guest_ansible do |ansible|
#       ansible.playbook = "any_playbook.yml"
#     end
#   else
#     config.vm.provision :ansible do |ansible|
#       ansible.playbook = "any_playbook.yml"
#     end
#   end
# end
# -*- mode: ruby -*-
# vi: set ft=ruby :

$ip1="192.168.33.12"
$ip2="192.168.33.13"
$dir="d:/lab_chef2"
$script = <<EOF
sudo -i
cd /lab_chef2/cookbooks
knife cookbook create jboss
knife cookbook create java_se
EOF


Vagrant.configure(2) do |config|

  config.vm.define "virtual1" do |v1|
    v1.vm.synced_folder $dir, "/lab_chef2"
    config.vm.provision :shell do |shell|
    shell.inline = $script
	end
  end
  
    config.vm.define "virtual2" do |v2|
    config.vm.provision "chef_solo" do |chef|
      chef.cookbooks_path = $dir+"/cookbooks"
      chef.add_recipe "java_se::default"
      chef.add_recipe "jboss::default"
      chef.add_recipe "deploy::default"
    end
    v2.vm.synced_folder $dir, "/lab_chef2"
  end
end
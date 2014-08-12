Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 80, auto_correct: true

  # config.vm.synced_folder "./www", "/home/www"
  config.vm.synced_folder "./", "/home/vagrant", create: true, group: "www-data", owner: "www-data"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provider "virtualbox" do |v|
    v.name = "vagrant_dev_vm"
    v.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision "shell" do |s|
    s.path = "provision/setup.sh"
  end

end

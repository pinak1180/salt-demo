Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty32'


  config.vm.provider :virtualbox do |vb|
    vb.cpus = 1
    vb.memory = 512
  end

  
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.enable :apt
    config.cache.enable :apt_lists
    config.cache.enable :npm
    config.cache.enable :gem
  end

  config.vm.network 'forwarded_port', guest: 3000, host: 3000
  config.vm.network 'private_network', ip: '192.168.100.100'
  config.vm.synced_folder 'salt/roots/', '/srv/'

  config.vm.provision :salt do |salt|
    # Use the latest stable version of salt-bootstrap as found on github
    salt.install_type = 'git'
    salt.install_args = 'develop'

    salt.verbose = true
    salt.colorize = true
    salt.log_level = :debug

    salt.run_highstate = true

   
    #salt.install_master = true

    salt.master_config = 'salt/etc/master'
    salt.minion_config = 'salt/etc/minion'

    
    salt.master_key = 'salt/keys/master.pem'
    salt.master_pub = 'salt/keys/master.pub'

 
    salt.minion_key = 'salt/keys/minion.pem'
    salt.minion_pub = 'salt/keys/minion.pub'

    salt.seed_master = { 'vagrant-ubuntu-trusty-32' => salt.minion_pub }
  end

 
  config.vm.provision :shell, inline: 'apt-get install -yq python-git'
  config.vm.provision :shell, inline: 'service salt-master restart'
  config.vm.provision :shell, inline: 'service salt-minion restart'

 
  config.vm.provision :shell, inline: 'salt "*" "state.highstate"'
end

Vagrant.configure('2') do |config|
  config.vm.box = 'ubuntu/trusty32'

  # Configure this virtual machine to use 2 CPU cores and 2GB of RAM.
  # Without this, Vagrant defaults new machines to 1 CPU core and 512MB of RAM
  config.vm.provider :virtualbox do |vb|
    vb.cpus = 1
    vb.memory = 512
  end

  # Configure this virtual machine to use 1GB of memory
  # Without this, Vagrant defaults new machines to 512MB
  # config.vm.provider 'virtualbox' do |vb|
  #   vb.customize [
  #     'modifyvm', :id,
  #     '--memory', 1024,
  #   ]
  # end

  # See http://fgrehm.viewdocs.io/vagrant-cachier for details
  # TLDR: this will save you a lot of time if you reprovision a box
  # or if you privision multiple boxes
  if Vagrant.has_plugin?('vagrant-cachier')
    config.cache.scope = :box
    config.cache.enable :apt
    config.cache.enable :apt_lists
    config.cache.enable :npm
    config.cache.enable :gem
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. As configured below,
  # accessing "localhost:3000" will access port 3000 on the guest machine.
  config.vm.network 'forwarded_port', guest: 3000, host: 3000

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network 'private_network', ip: '192.168.100.100'

  # Make the first argument (a folder form the host OS)
  # available at the seciond argument (a path on the guest OS)
  config.vm.synced_folder 'salt/roots/', '/srv/'

  # Run Salt and provision with salt states in `salt/roots`
  config.vm.provision :salt do |salt|
    # Use the latest stable version of salt-bootstrap as found on github
    salt.install_type = 'git'
    salt.install_args = 'develop'

    salt.verbose = true
    salt.colorize = true
    salt.log_level = :debug

    salt.run_highstate = true

    # Configure this VM to act as a salt master and a minon
    #salt.install_master = true

    # Minion and master configs
    salt.master_config = 'salt/etc/master'
    salt.minion_config = 'salt/etc/minion'

    # Insecure master keys for use with Vagrant
    salt.master_key = 'salt/keys/master.pem'
    salt.master_pub = 'salt/keys/master.pub'

    # Insecure minion keys for use with Vagrant
    salt.minion_key = 'salt/keys/minion.pem'
    salt.minion_pub = 'salt/keys/minion.pub'

    # Pre-seed our master sever so that it will accept connections from
    # anything on the local network using the insecure minion keys
    salt.seed_master = { 'vagrant-ubuntu-trusty-32' => salt.minion_pub }
  end

  # GitFS support
  config.vm.provision :shell, inline: 'apt-get install -yq python-git'
  config.vm.provision :shell, inline: 'service salt-master restart'
  config.vm.provision :shell, inline: 'service salt-minion restart'

  # Run Salt provisioning scripts to wrap things up
  config.vm.provision :shell, inline: 'salt "*" "state.highstate"'
end

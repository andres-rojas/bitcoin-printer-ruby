# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box     = 'precise64'
  config.vm.box_url = 'http://files.vagrantup.com/precise64.box'

  config.berkshelf.enabled    = true
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe 'apt'
    chef.add_recipe 'imagemagick'
    chef.add_recipe 'imagemagick::devel'
    chef.add_recipe 'ruby_build'
    chef.add_recipe 'rbenv::vagrant'
    chef.add_recipe 'rbenv::user'
    chef.add_recipe 'vim'

    chef.json = { rbenv: { user_installs: [{
      user:     'vagrant',
      rubies: [ '2.0.0-p247' ],
      global:   '2.0.0-p247',
      gems:   { '2.0.0-p247' => [
        { name: 'bundler' },
      ] }
    }] } }
  end
end

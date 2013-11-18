Bitcoin Printer
===============

A quick and dirty port of [Carlos Bueno's bitcoin-printer python script](https://github.com/aristus/bitcoin-printer), which generates "paper Bitcoins" which contain one-time-use keypairs and Bitcoin payment addresses.

See also: http://carlos.bueno.org/2012/07/paper-bitcoins.html

## License
### Original Python script
carlos@bueno.org 17 July 2012

BSD license: Share and enjoy, but give credit where it's due.

### Ruby port
breakyboy@gmail.com 17 November 2013

BSD license: Share and enjoy, but give credit where it's due.

## Installation
### Ruby Versions
As of yet, it has only been tested and verified to work with:
- Ruby 2.0.0

### Dependencies
#### Universal
You will need [ImageMagick](http://www.imagemagick.org/), and it's development libraries set up for your OS.

After that, make sure you have [bundler](http://bundler.io/) installed and then, run:
```
bundle install
```
That should get you all set up to run the script.

#### Mac OS X
You'll probably need [Ghostscript](http://www.ghostscript.com/), which you can helpfully grab with [brew](http://brew.sh/).

## Usage
```
$ ./paper_bitcoin.rb AMOUNT
```
where AMOUNT is a decimal number like "0.1". The default is "0.001". This will create a new keypair and bitcoin address, and generate the front and back images for printing complete with QR codes and text. The filename will be in the form "iSamPLE-front.png", where "iSamPLE" is the newly-minted Bitcoin address.

Remember to actually send the Bitcoin to that address!

## Development
I developed using a Virtualbox-based 64-bit Ubuntu Precise Vagrant box. I've included my Vagrantfile and Berksfile in case anyone wants to pick up exactly where I left off.

To set up, you'll need:

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](http://downloads.vagrantup.com/)
- [Berkshelf](http://berkshelf.com/) -- i.e. ```gem install berkshelf```
- [Vagrant-Berkshelf](https://github.com/berkshelf/vagrant-berkshelf) -- i.e. ```vagrant plugin install vagrant-berkshelf```
- [Vagrant-Omnibus](https://github.com/schisamo/vagrant-omnibus) -- i.e. ```vagrant plugin install vagrant-omnibus```

Once all of that is set up:
```vagrant up```

After several minutes (the chef-solo run alone can take about 15 minutes), that will get your VM spun up and ready to roll. You can SSH into the running VM with: ```vagrant ssh```

You can access the script (and all other files in your host's directory) at: ```/vagrant```

To suspend the VM and free up your system resources without having to rebuild the whole VM from scratch: ```vagrant suspend```
If you really want to just delete the VM, then: ```vagrant destroy```

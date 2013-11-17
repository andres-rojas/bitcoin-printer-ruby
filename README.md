Bitcoin Printer
===============

A quick and dirty port of [Carlos Bueno's bitcoin-printer python script](https://github.com/aristus/bitcoin-printer), which generates "paper Bitcoins" which contain one-time-use keypairs and Bitcoin payment addresses.

See also: http://carlos.bueno.org/2012/07/paper-bitcoins.html

# License
## Original Python script
carlos@bueno.org 17 July 2012

BSD license: Share and enjoy, but give credit where it's due.

## Ruby port
breakyboy@gmail.com 17 November 2013

BSD license: Share and enjoy, but give credit where it's due.

# Installation
## Ruby Versions
As of yet, it has only been tested and verified to work with:
- Ruby 2.0.0

## Dependencies
Make sure you have [bundler](http://bundler.io/) installed and running:
```
bundle install
```
should get you all set up to run the script.

# Usage
```
$ ./paper_bitcoin.rb AMOUNT
```
where AMOUNT is a decimal number like "0.1". The default is "0.001". This will create a new keypair and bitcoin address, and generate the front and back images for printing complete with QR codes and text. The filename will be in the form "iSamPLE-front.png", where "iSamPLE" is the newly-minted Bitcoin address.

Remember to actually send the Bitcoin to that address!


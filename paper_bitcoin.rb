#!/usr/bin/env ruby

amount = ARGV.empty? ? '0.001' : "#{ARGV.first.to_f.round(3)}"
amount += ' BTC'

key = Bitcoin::generate_key
secret = key[0]
pubkey = key[1]
addr_58 = Bitcoin::pubkey_to_address(pubkey)
secreta = secret[0, 32]
secretb = secret[32..-1]

#!/usr/bin/env ruby

require 'bitcoin'
require './lib/rqrcode-rmagick'

amount = ARGV.empty? ? '0.001' : "#{ARGV.first.to_f.round(3)}"
amount += ' BTC'

key = Bitcoin::generate_key
secret = key[0]
pubkey = key[1]
addr_58 = Bitcoin::pubkey_to_address(pubkey)
secreta = secret[0, 32]
secretb = secret[32..-1]

## Given a string, returns a transparent QR code image object 
## that has been rotated and resized to fit the template
def rotated_qr(s)
  derp = RQRCode::QRCode.new(s)
  i = derp.draw(20, 'black', 'transparent')
  i.rotate! 315
  i.resize! 1100, 1100
end



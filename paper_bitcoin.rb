#!/usr/bin/env ruby

require 'bitcoin'
require './lib/rqrcode-rmagick'

amount = ARGV.empty? ? '0.001' : "#{ARGV.first.to_f.round(3)}"
amount += ' BTC'

TYPEFACE = 'Arial Rounded Bold.ttf'
DENOMINATION = 200
ADDRESS = 100
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
  i.rotate!(315)
  i.resize!(1100, 1100)
end

front = Magick::ImageList.new
front.read('template-front.png')

draw = Magick::Draw.new
draw.font = TYPEFACE
draw.font_weight = Magick::BoldWeight

draw.pointsize = DENOMINATION

## bottom left
draw.annotate(front, 0, 0, 390, 2275, amount)

## top right
draw.annotate(front, 0, 0, 3740, 630, amount)

draw.pointsize = ADDRESS

## address
draw.annotate(front, 0, 0, 550, 700, addr_58[0, 18])
draw.annotate(front, 0, 0, 550, 800, addr_58[18..-1])

# QRCODEZZZ
addrq = rotated_qr(addr_58)
front.composite!(addrq, 520, 830, Magick::OverCompositeOp)
priva = rotated_qr(secreta)
front.composite!(priva, 3450, 830, Magick::OverCompositeOp)

# write it
front.write('test.png')

## Now the back.
back = Magick::ImageList.new
back.read('template-back.png')
draw.pointsize = DENOMINATION
draw.annotate(back, 0, 0, 390, 2420, amount)
draw.pointsize = ADDRESS
draw.annotate(back, 0, 0, 1500, 2380, addr_58)

privb = rotated_qr(secretb)
back.composite!(privb, 3700, 1100, Magick::OverCompositeOp)

back.write('test2.png')

puts "Generated images for #{addr_58}"

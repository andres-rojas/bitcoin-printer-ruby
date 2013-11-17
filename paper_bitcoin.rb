#!/usr/bin/env ruby

require 'bitcoin'
require './lib/rqrcode-rmagick'

# Types for the 'write' function
ADDRESS      = 1
DENOMINATION = 2

# Bill templates
FRONT_TEMPLATE = 'template-front.png'
BACK_TEMPLATE  = 'template-back.png'

# Font settings
TYPEFACE   = 'Arial Rounded Bold.ttf'
DENOM_SIZE = 200
ADDR_SIZE  = 100

## Artifact positioning
# Denominations
FRONT_BL_DENOM = [390, 2275]
FRONT_TR_DENOM = [3740, 630]
BACK_DENOM     = [390, 2420]

# Addresses
FRONT_ADDR = [550, 700]
BACK_ADDR  = [1500, 2380]

# QR Codes
ADDR_QR   = [520, 830]
PRIV_QR_A = [3450, 830]
PRIV_QR_B = [3700, 1100]


def get_amount
  amount = ARGV.empty? ? '0.001' : "#{ARGV.first.to_f.round(3)}"
  amount + ' BTC'
end

## Given a string, returns a transparent QR code image object 
## that has been rotated and resized to fit the template
def rotated_qr(s)
  derp = RQRCode::QRCode.new(s)
  i = derp.draw(20, 'black', 'transparent')
  i.rotate!(315)
  i.resize!(1100, 1100)
end

def write_bill(dest, type, text, offset_pos)
  draw             = Magick::Draw.new
  draw.font        = TYPEFACE
  draw.font_weight = Magick::BoldWeight

  draw.pointsize = case type
  when DENOMINATION
    DENOM_SIZE
  when ADDRESS
    ADDR_SIZE
  end

  draw.annotate(dest, 0, 0, offset_pos[0], offset_pos[1], text)
end

def draw_qr(dest, s, offset_pos)
  qr = rotated_qr(s)
  dest.composite(qr, offset_pos[0], offset_pos[1], Magick::OverCompositeOp)
end

def draw_bill(front_template, back_template, amount, key)
  secret  = key[0]
  addr_58 = Bitcoin::pubkey_to_address(key[1])

  front = Magick::ImageList.new
  front.read(front_template)

  write_bill(front, DENOMINATION, amount, FRONT_BL_DENOM)
  write_bill(front, DENOMINATION, amount, FRONT_TR_DENOM)
  write_bill(front, ADDRESS, addr_58[0, 18], FRONT_ADDR)
  write_bill(front, ADDRESS, addr_58[18..-1], [FRONT_ADDR[0], FRONT_ADDR[1] + ADDR_SIZE])

  front = draw_qr(front, addr_58, ADDR_QR)
  front = draw_qr(front, secret[0, 32], PRIV_QR_A)

  front.write(addr_58 + '.front.png')

  back = Magick::ImageList.new
  back.read(back_template)

  write_bill(back, DENOMINATION, amount, BACK_DENOM)
  write_bill(back, ADDRESS, addr_58, BACK_ADDR)

  back = draw_qr(back, secret[32..-1], PRIV_QR_B)

  back.write(addr_58 + '.back.png')
end


## Main flow
key = Bitcoin::generate_key
draw_bill(FRONT_TEMPLATE, BACK_TEMPLATE, get_amount, key)
puts "Generated images for #{Bitcoin::pubkey_to_address(key[1])}"

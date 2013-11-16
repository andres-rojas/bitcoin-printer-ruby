#!/usr/bin/env ruby

amount = ARGV.empty? ? '0.001' : "#{ARGV.first.to_f.round(3)}"
amount += ' BTC'

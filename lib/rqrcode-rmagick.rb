# Yanked and slightly modified from https://github.com/siuying/qrcode-rails/vendor/plugins/rqrcode-rmagick/lib/rqrcode-rmagick.rb

require 'RMagick'
require 'rqrcode'

module RQRCode
  class QRCode
    DEFAULT_MODULE_SIZE  = 4
    DEFAULT_FILL         = 'black'
    DEFAULT_BG           = 'white'
   
    def save_as(filename, module_size = DEFAULT_MODULE_SIZE, fill = DEFAULT_FILL, bg = DEFAULT_BG)
      canvas = draw(module_size, fill, bg)
         canvas.write(filename)
    end
    
    def draw(module_size = DEFAULT_MODULE_SIZE, fill = DEFAULT_FILL, bg = DEFAULT_BG)
      length = self.modules.size
      width  = module_size * length
      dx     = module_size * 4

      canvas = Magick::Image.new(width + 2 * dx, width + 2 * dx) do |c|
        c.background_color = bg
      end
      gc = Magick::Draw.new

      gc.stroke_opacity(0)
      gc.fill(fill)

      row_cnt, col_cnt = 0, 0
      self.modules.each do |col|
        row_cnt = 0
        col.each do |row|
          if row
            point_tl_x, point_tl_y = dx + row_cnt * module_size, dx + col_cnt * module_size
            point_br_x, point_br_y = point_tl_x + module_size,   point_tl_y + module_size
            gc.rectangle point_tl_x, point_tl_y, point_br_x, point_br_y
          end
          row_cnt += 1
        end
        col_cnt += 1
      end
      gc.draw(canvas)
      canvas
    end
  end
end


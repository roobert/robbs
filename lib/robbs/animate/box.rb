#!/usr/bin/env ruby

module Robbs
  module Animate
    module Box
      def self.topleft_grow_diagonal(x: , y: , columns: , lines: , step: 0.05)
      end

      def self.resize(box, lines: , columns: )
        $logger.info "resizing box: #{box.columns}x#{box.lines} -> #{columns}x#{lines}"
        box.clear
        box.resize(lines: lines, columns: columns)
        box.display_border
        box.refresh
        Rurses.update_screen
      end

      def self.top_grow_down(x: , y: , columns: , lines: , x_step: 0.05, y_step: 0.05)
        box = Draw::Box.new(x: x, y: y, columns: 1, lines: 1)
        box.refresh
        Rurses.update_screen

        until box.columns == columns
          resize(box, lines: box.lines, columns: box.columns + 1)
          sleep x_step
        end

        until box.lines == lines
          resize(box, lines: box.lines + 1, columns: box.columns)
          sleep y_step
        end
      end
    end
  end
end

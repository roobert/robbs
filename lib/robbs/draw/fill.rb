#!/usr/bin/env ruby

module Robbs
  module Draw
    module Fill
      def stars(x: cursor_x, y: cursor_y, columns: , lines: , step: 0.05)
        subwindow[:star_field]

        (cursor_y..lines).each do |y|
          (cursor_x..columns).each do |x|
            move_cursor(x: x, y: y)
            draw_string(".") unless rand(10) % 3 == 0
          end
        end
        refresh
      end

      def shutter(char = " ")
        message = char * Curses.cols + "\n"
        message = message * Curses.lines
        line_by_line(message, step: 0.01)
      end

      def line_by_line_pattern()
      end
    end
  end
end


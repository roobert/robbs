#!/usr/bin/env ruby

module Robbs
  module Draw
    class Canvas
      include Shape

      attr_reader :x1, :y1, :x2, :y2

      def initialize(x1, y1, x2, y2)
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
      end

      def fill(char = " ")
        (y1..y2).each do |row|
          (x1..x2).each do |col|
            write(col, row, char)
          end
        end
      end

      # FIXME: line wrap
      def text(message, start_x: @x1, start_y: @y1)
        Curses.setpos(start_y, start_x)

        message.each_char do |char|
          Curses.addstr(char)
          Curses.refresh
          sleep 0.1
          start_y + 1
          start_x + 1
        end
      end
    end
  end
end

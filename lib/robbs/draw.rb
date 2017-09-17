#!/usr/bin/env ruby

module Robbs
  module Draw
    module Shape
      def write(x, y, string)
        Curses.setpos(y, x)
        Curses.addstr(string)
        Curses.setpos(y, x)
        Curses.refresh
      end
    end

    class HLine
      include Shape

      attr_reader :row, :x1, :x2, :char

      def initialize(row, x1, x2, char)
        @row  = row
        @x1   = x1
        @x2   = x2
        @char = char
      end

      def draw
        (x1..x2).each { |col| write(col, row, char) }
      end
    end

    class VLine
      include Shape

      attr_reader :col, :y1, :y2, :char

      def initialize(col, y1, y2, char)
        @col  = col
        @y1   = y1
        @y2   = y2
        @char = char
      end

      def draw
        (y1..y2).each { |row| write(col, row, char) }
      end
    end

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

    class Box
      include Shape
      extend Forwardable

      def_instance_delegator :@canvas, :fill
      def_instance_delegator :@canvas, :text

      attr_reader :x1, :y1, :x2, :y2, :x_char, :y_char, :canvas

      def initialize(x1, y1, x2, y2, x_char: "-", y_char: "|")
        @x1 = x1
        @y1 = y1
        @x2 = x2
        @y2 = y2
        @x_char = x_char
        @y_char = y_char
        @canvas = Canvas.new(x1+1, y1+1, x2-1, y2-1)
      end

      def draw
        HLine.new(y1, x1, x2, x_char).draw
        VLine.new(x1, x1, y2, y_char).draw
        HLine.new(y2, x1, x2, x_char).draw
        VLine.new(x2, x1, y2, y_char).draw
        fill
        corners unless y_char == " " and x_char == " "

        self
      end

      def destroy(char = " ")
        (y1..y2).each do |row|
          (x1..x2).each do |col|
            write(col, row, char)
          end
        end
      end

      private

      def corners(char = "+")
        write(x1, y1, "+")
        write(x2, y1, "+")
        write(x2, y2, "+")
        write(x1, y2, "+")
      end
    end
  end

  module Animate
    module Box
      def self.topleft_extend(x1, y1, x2, y2, step: 0.05)
        x2_target = x2
        y2_target = y2
        x2 = x1
        y2 = y1

        until x2 == x2_target and y2 == y2_target
          x2 += 1 unless x2 == x2_target
          y2 += 1 unless y2 == y2_target
          box = Robbs::Draw::Box.new(x1, y1, x2, y2).draw
          sleep step
        end

        box
      end
    end
  end
end

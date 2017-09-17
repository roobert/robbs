#!/usr/bin/env ruby

module Robbs
  module Draw
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
end

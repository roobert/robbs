#!/usr/bin/env ruby

module Robbs
  module Draw
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
  end
end

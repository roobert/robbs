#!/usr/bin/env ruby

module Robbs
  module Draw
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
  end
end

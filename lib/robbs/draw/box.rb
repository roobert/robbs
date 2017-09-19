#!/usr/bin/env ruby

module Robbs
  module Draw
    class Box < Rurses::Window
      include Text
      include Border
      include Fill

      def initialize(**details)
        super
        display_border
        create_subwindow(name: :text_area, top_padding: 1, bottom_padding: 1, left_padding: 1, right_padding: 1)
      end

      alias_method :refresh, :refresh_in_memory

      def create_subwindow(name: , top_padding: 0, left_padding: 0, right_padding: 0, bottom_padding: 0)
        s  = size
        xy = cursor_xy

        subwindows[name] =
          Rurses::Window.new(
            curses_ref: Rurses.curses.derwin(
              curses_ref,
              s[:lines]   - (top_padding  + bottom_padding),
              s[:columns] - (left_padding + right_padding),
              xy[:y]      + top_padding,
              xy[:x]      + left_padding
            )
          )
      end
    end
  end
end

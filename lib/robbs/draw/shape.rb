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
  end
end

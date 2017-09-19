#!/usr/bin/env ruby

module Robbs
  module Draw
    module Text
      def h_center(message)
        longest_line = message.split("\n").sort { |line| line.length }[0].length
        (columns - longest_line) / 2
      end

      def v_center(message)
        (lines - message.split("\n").length) / 2
      end

      def text(message)
        subwindow(:text_area).draw_string(message)
      end

      def column_by_column(message, x: cursor_x, y: cursor_y, step: 0.05)
      end

      def line_by_line(message, x: cursor_x, y: cursor_y, step: 0.05)
        $logger.info "start x: #{x}, start y: #{y}, lines: #{message.split.length}"

        subwindow(:text_area).move_cursor(x: x, y: y)

        message.each_line do |line|
          subwindow(:text_area).move_cursor(x: x, y: y)
          subwindow(:text_area).draw_string(line)
          subwindow(:text_area).refresh_in_memory
          Rurses.update_screen
          sleep step
          y += 1
        end
      end

      def type(message, x: cursor_x, y: cursor_y, step: 0.05)
        subwindow(:text_area).move_cursor(x: x, y: y)

        message.each_char do |char|
          (y += 1; x = cursor_x) if x == columns
          (y += 1; x = cursor_x; next) if char == "\n"

          subwindow(:text_area).move_cursor(x: x, y: y)
          subwindow(:text_area).draw_string(char)

          subwindow(:text_area).refresh_in_memory
          Rurses.update_screen

          sleep step
          x += 1
        end
      end
    end
  end
end

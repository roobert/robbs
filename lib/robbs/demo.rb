#!/usr/bin/env ruby

require "figlet"

module Robbs
  module Demo
    def self.border
      {
        left:     "|", right:     "|", top:         "-", bottom:       "-",
        top_left: "+", top_right: "+", bottom_left: "+", bottom_right: "+"
      }
    end

    def self.banner
      box0 = Draw::Box.new(x: 0, y: 0, lines: Rurses.stdscr.lines, columns: Rurses.stdscr.columns)
      banner_text = Figlet::Typesetter.new(Figlet::Font.new(File.join(File.dirname(__FILE__), 'demo/alligator2.flf')))["DUST"]
      box0.line_by_line(banner_text, x: box0.h_center(banner_text), y: box0.v_center(banner_text), step: 0.1)
      sleep 2
      box0.subwindow(:text_area).clear
      box0.subwindow(:text_area).refresh_in_memory
      Rurses.update_screen
    end

    def self.boxes
      box_width = 50
      box_height = 10
      #Animate::Box.top_grow_down(x: ((Rurses.stdscr.columns - box_width) / 2), y: ((Rurses.stdscr.lines - box_height) / 2), lines: box_height, columns: box_width)
      x_position = ((Rurses.stdscr.columns - box_width) / 2)
      y_position = ((Rurses.stdscr.lines - box_height) / 2)
      $logger.info "x_position: #{x_position}, y_position: #{y_position}"
      $logger.info "box_width: #{box_width}, box_height: #{box_height}"

      #Animate::Box.top_grow_down(x: 10, y: 5, lines: 10, columns: 10)
      #Animate::Box.top_grow_down(x: 10, y: 10, lines: 10, columns: 10, step: 0.3)
      Animate::Box.top_grow_down(x: x_position, y: y_position, lines: box_height, columns: box_width, x_step: 0.03)
      box1 = Draw::Box.new(x: x_position, y: y_position, lines: box_height, columns: box_width)
      box1.refresh
      box1.subwindow(:text_area).refresh_in_memory
      Rurses.update_screen

      box1.type("Lorem ipsum dolor sit amet, consectetur adipiscing elit. In iaculis enim ac sagittis laoreet. In tincidunt ligula vel congue auctor. Phasellus nisi dolor, bibendum sed est nec, porta aliquam enim.")

      sleep 2
    end

    # improve refresh by using panels
    # move 'center' for boxes, etc. into classes?

    def self.start
      Rurses.program(modes: %i[c_break no_echo keypad hide_cursor]) do |root_window|
        #panels = Rurses::PanelStack.new

        banner
        boxes

        box0 = Draw::Box.new(x: 0, y: 0, lines: Rurses.stdscr.lines, columns: Rurses.stdscr.columns)
        box0.refresh
        box0.stars(x: 0, y: 0, lines: Rurses.stdscr.lines, columns: Rurses.stdscr.columns)
        Rurses.update_screen
        sleep 3

        #panels = Rurses::PanelStack.new
      end
    end
  end
end

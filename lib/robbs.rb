#!/usr/bin/env ruby

require "curses"
require "forwardable"
require "tty"
require "robbs/draw"
require "robbs/demo"

module Robbs
  def self.run
    setup
    Demo.start
  end

  private

  def self.onsig(signal)
    Curses.close_screen
    exit signal
  end

  def self.setup
    %w[HUP INT QUIT TERM].each do |sig|
      unless trap(sig, "IGNORE") == "IGNORE"
        trap(sig) {|s| onsig(s) }
      end
    end

    Curses.init_screen
    Curses.nl
    Curses.noecho
    Curses.curs_set 0
    Curses.setpos(0, 0)
  end
end

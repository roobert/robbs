#!/usr/bin/env ruby

require "rurses"
require "forwardable"
require "tty"
require "logger"
require "timeout"

require "robbs/draw/fill"
require "robbs/draw/border"
require "robbs/draw/text"
require "robbs/draw/box"
require "robbs/animate/box"
require "robbs/demo"

$logger = Logger.new(File.open('robbs.log', "w+"))

module Robbs
  def self.run
    setup
    Demo.start
  end

  def self.setup
    %w[HUP INT QUIT TERM].each do |sig|
      next if trap(sig, "IGNORE") == "IGNORE"

      trap(sig) do |signal|
        Rurses.curses.endwin
        exit signal
      end
    end
  end
end

#!/usr/bin/env ruby

module Robbs
  module Demo
    def self.start
      box = Animate::Box.topleft_extend(1,1,20,10)
      box.text "test"
      sleep 3
      box.destroy
      sleep 1
    end
  end
end

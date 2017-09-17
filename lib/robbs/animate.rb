#!/usr/bin/env ruby

module Robbs
  module Animate
    module Box
      def self.topleft_extend(x1, y1, x2, y2, step: 0.05)
        x2_target = x2
        y2_target = y2
        x2 = x1
        y2 = y1

        until x2 == x2_target and y2 == y2_target
          x2 += 1 unless x2 == x2_target
          y2 += 1 unless y2 == y2_target
          box = Robbs::Draw::Box.new(x1, y1, x2, y2).draw
          sleep step
        end

        box
      end
    end
  end
end

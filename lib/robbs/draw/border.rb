#!/usr/bin/env ruby

module Robbs
  module Draw
    module Border
      def display_border
        draw_border(**border)
      end

      def border
        {
          left:     "|", right:     "|", top:         "-", bottom:       "-",
          top_left: "+", top_right: "+", bottom_left: "+", bottom_right: "+"
        }
      end
    end
  end
end

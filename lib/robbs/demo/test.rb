#!/usr/bin/env ruby

require "figlet"


figlet = Figlet::Typesetter.new(Figlet::Font.new('alligator2.flf'))
puts figlet['hello world']

# coding: utf-8

require 'dxruby'
require_relative 'director'
require_relative 'pawn'
require_relative 'wall'

Window.caption = "Quoridor"
Window.width = 800
Window.height = 600

director = Director.new

Window.loop do
  break if Input.keyPush?(K_ESCAPE)
  director.input
  director.play
  director.draw
end

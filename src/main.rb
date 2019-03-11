require 'dxopal'
include DXOpal

require_remote 'director.rb'
require_remote 'pawn.rb'
require_remote "wall.rb"

director = Director.new

Window.load_resources do
  Window.bgcolor = C_BLACK

  Window.loop do
    director.input
    director.play
    director.draw
  end
end

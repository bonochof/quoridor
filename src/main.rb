require 'dxopal'
include DXOpal

require_remote 'director.rb'
require_remote 'pawn.rb'
require_remote 'wall.rb'

Image.register(:tile, '../data/image/tile.png')
Image.register(:pawn1, '../data/image/pawn1.png')
Image.register(:pawn2, '../data/image/pawn2.png')

director = Director.new

Window.load_resources do
  Window.bgcolor = C_BLACK

  Window.loop do
    director.input
    director.play
    director.draw
  end
end

require 'dxopal'
include DXOpal

require_remote 'director.rb'
require_remote 'tile.rb'
require_remote 'wall.rb'
require_remote 'pawn.rb'

Image.register(:tile, '../data/image/tile.png')
Image.register(:wall, '../data/image/wall.png')
Image.register(:pawn1, '../data/image/pawn1.png')
Image.register(:pawn2, '../data/image/pawn2.png')

Window.load_resources do
  Window.bgcolor = C_BLACK
  director = Director.new

  Window.loop do
    $img = Image[:tile]
    #director.input
    #director.play
    director.draw
  end
end

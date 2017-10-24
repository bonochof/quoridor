# coding: utf-8

class Pawn
  attr_reader :x, :y
  
  def initialize( pnum )
    case pnum
    when 1
      pos_x = 8
      pos_y = 4
    when 2
      pos_x = 0
      pos_y = 4
    when 3
      pos_x = 4
      pos_y = 8
    when 4
      pos_x = 4
      pos_y = 0
    else
      abort "player number is wrong"
    end
    @x = pos_x
    @y = pos_y
  end
  
  def movable?(key)
    
  end
  
  def move
    
  end
end

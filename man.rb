# coding: utf-8

class Man
  attr_reader :x, :y
  
  def initialize( pnum )
    case pnum
    when 1
      pos_x = 
      pos_y = 
    when 2
      pos_x = 
      pos_y =
    when 3
      pos_x = 
      pos_y = 
    when 4
      pos_x = 
      pos_y = 
    else
      abort "player number is wrong"
    end
    @x = pos_x
    @y = pos_y
  end
  
  def movable?
    
  end
  
  def move
  
  end
end

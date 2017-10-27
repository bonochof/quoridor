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
    @num = pnum
    @x = pos_x
    @y = pos_y
  end
  
  def movable?( dir )
    case dir
    when :up
      return true if @y > 0
    when :down
      return true if @y < $size - 1
    when :left
      return true if @x > 0
    when :right
      return true if @x < $size - 1
    end
    
    return false
  end
  
  def move( dir )
    case dir
    when :up
      @y -= 2
    when :down
      @y += 2
    when :left
      @x -= 2
    when :right
      @x += 2
    end
  end
end

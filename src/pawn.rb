# coding: utf-8

class Pawn
  attr_reader :x, :y, :num
  
  def initialize( pnum )
    case pnum
    when 1
      pos_x = 16
      pos_y = 8
    when 2
      pos_x = 0
      pos_y = 8
    when 3
      pos_x = 8
      pos_y = 16
    when 4
      pos_x = 8
      pos_y = 0
    else
      abort "player number is wrong"
    end
    
    @num = pnum
    @x = pos_x
    @y = pos_y
    
    $map[@y][@x] = 2 if @num == 1
    $map[@y][@x] = 3 if @num == 2
  end
  
  def movable?( dir )
    case dir
    when :up
      return true if @y > 0
    when :down
      return true if @y < $size*2 - 2
    when :left
      return true if @x > 0
    when :right
      return true if @x < $size*2 - 2
    end
    
    return false
  end
  
  def move( dir )
    $map[@y][@x] = 0 if $turn == 1
    $map[@y][@x] = 0 if $turn == 2
    
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

    $map[@y][@x] = 2 if $turn == 1
    $map[@y][@x] = 3 if $turn == 2
  end
end

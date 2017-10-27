# coding: utf-8

class Wall
  attr_reader :setflag
  attr_writer :x, :y

  def initialize
    @x = 0
    @y = 0
    @dir = :vertical
    @setflag = false
  end
  
  def change_dir
    case @dir
    when :vertical
      @dir = :horizontal
    when :horizontal
      @dir = :vertical
    end
  end
  
  def dead_end?( x, y )
    stack = Array.new
    visit = Array.new( $size * $size, 0 )
    map = $map.flatten
    i = x + 10 * y
    stack.push( i )
    visit[i] = 1;
    until stack.size == 0 do
      for j in [-10, -1, 10, 1] do
        if i + j > 0 and i + j < ( $size + 1 ) ** 2 - 1
        if map[i+j] == 0 and visit[i+j] == 0
          stack.push( i+j )
          visit[i+j] = 1
          i = i + j
          redo
        end
      end
      j = stack.pop
    end
    
    return false
  end
  
  def setable?
    case @dir
    when :vertical
      return false if @y < 0 or @y >= $size
    when :horizontal
      return false if @x < 0 or @x >= $size
    end
    
    return false if self.dead_end?
    
    return true
  end
  
  def set
    @setflag = true
  end
end

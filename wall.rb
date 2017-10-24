# coding: utf-8

class Wall
  def initialize
    #@num = 20 / pnum
    @x = 0
    @y = 0
    @dir = :vertical
  end
  
  def change_dir
    case @dir
    when :vertical
      @dir = :horizontal
    when :horizontal
      @dir = :vertical
    end
  end
  
  def dead_end?
=begin
    stack = Array.new
    visit = Array.new( $size, 0 )
    stack.push( i )
    visit[i] = 1;
    j = i;
    until stack.size == 0 do
      @map.each_with_index do |line, k|
        if @map[j][k] == 1 and visit[k] == 0
          j = k
          k = 0
          stack.push( j )
          visit[j] = 1
        end
      end
      j = stack.pop
    end
=end
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
  
  end
end

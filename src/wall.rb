# coding: utf-8

class Wall
  attr_reader :setflag
  attr_writer :x, :y
  
  def initialize
    @x = 1
    @y = 1
    @dir = :vertical
    @setflag = false
    
    $map[@y][@x] = 1
    $map[@y-1][@x] = 1
    $map[@y+1][@x] = 1
  end
  
  def spin
    case @dir
    when :vertical
      @dir = :horizontal
      $map[@y-1][@x] = 0
      $map[@y+1][@x] = 0
      $map[@y][@x-1] = 1
      $map[@y][@x+1] = 1
    when :horizontal
      @dir = :vertical
      $map[@y][@x-1] = 0
      $map[@y][@x+1] = 0
      $map[@y-1][@x] = 1
      $map[@y+1][@x] = 1
    end
  end
  
  def dead_end?( px, py, pnum )
    case pnum
    when 1
      goal = 0
    when 2
      goal = $map_size - 1
    end
    visit = Array.new( $map_size ){ Array.new( $map_size, 0 ) }
    i = py
    j = px
    stack_y = Array.new
    stack_x = Array.new
    stack_y.push( i )
    stack_x.push( j )
    visit[i][j] = 1;
    until stack_y.size == 0 do
      for dy in [-2, 2] do
        for dx in [-2, 2] do
          if i + dy > 0 and i + dy < $map_size - 1 and j + dx > 0 and j + dx < $map_size - 1
            if $map[i+dy][j+dx] == goal
              return false
            end
            
            if $map[i+dy][j+dx] == 0 and visit[i+dy][j+dx] == 0
              i += dy
              j += dx
              stack_y.push( i )
              stack_x.push( j )
              visit[i][j] = 1
              dy = -2
              redo
            end
          end
        end
      end
      i = stack_y.pop
      j = stack_x.pop
    end
    
    return true
  end
  
  def setable?( px, py, pnum )
    case @dir
    when :vertical
      return false if @y < 0 or @y >= $size
    when :horizontal
      return false if @x < 0 or @x >= $size
    end
    
    return false if self.dead_end?( px, py, pnum )
    
    return true
  end
  
  def set
    @setflag = true
  end
  
  def movable?( dir )
    return false if @setflag
  
    case dir
    when :up
      if @y - 1 > 0
        return false if $map[@y-2][@x] == 1
        return true
      end
    when :down
      if @y + 1 < $size * 2 - 2
        return false if $map[@y+2][@x] == 1
        return true
      end
    when :left
      if @x - 1 > 0
        return false if $map[@y][@x-2] == 1
        return true
      end
    when :right
      if @x + 1 < $size * 2 - 2
        return false if $map[@y][@x+2] == 1
        return true
      end
    end
    
    return false
  end
  
  def move( dir )
    $map[@y][@x] = 0
    case @dir
    when :vertical
      $map[@y-1][@x] = 0
      $map[@y+1][@x] = 0
    when :horizontal
      $map[@y][@x-1] = 0
      $map[@y][@x+1] = 0
    end
    
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
    
    $map[@y][@x] = 1
    case @dir
    when :vertical
      $map[@y-1][@x] = 1
      $map[@y+1][@x] = 1
    when :horizontal
      $map[@y][@x-1] = 1
      $map[@y][@x+1] = 1
    end
    
    $actionflag = true
  end
end
